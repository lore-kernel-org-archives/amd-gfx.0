Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB25C7619A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 07:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C64B310E2EE;
	Tue, 11 Apr 2023 07:25:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B7710E2EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 07:25:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khskVl+rzEx8ym+xESZZr2oRerJo+D2NPcGZF/4rI1DaOFvqYUdTpBzQwTA41+52v4yNphEIJVaIOnFLSyQ+5KOsaEI2bHCxms5e1fNF/rmFERCnZ8TcavLYokVtJZvUl7811AVuGGpXAKOUKVNNF1iKZeXQ0gm60+sg4IQwLVh4cIbVBjwPQ1sAv5w8A60MPS5rVPxuIJ04yiF/cmdCIT9rC5QwMWHzfBKHIvseS4LZsCWEe3k01+cS6Eu0VsY9KzV80T1fXJ/S6AzsCubtYGlOQP4Dl/6eNRTtB5l6hy06VYSMySn3wZWj6inCVq/4ggyoCO1LAHrR9dJfeWiBTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaTMd6LqkbC+czATJNcj5+puydlVcDHovZ3HGjM3MGw=;
 b=S1kMz7IAzSCQbXJ45sMQ35iGwi/cQCp+4kFUj71RtbXdJ6wSWcgDAClMzmFQvXMakWY/Uo+KG98HMisISKmnI+bG2LUnVfF80r//xc3RoPQmnqVcP35t6Ty9I4rnaDZGKgQxXb2sQn3fe644+lhDdMyIaKuEfTCX/yFkQpweO+PgmGjw39GHRyAosN9Fp0BOVaoml0HxLTc56NSuEn8LFUUT7WW92DMgCmXWTAnKKx97fGdEC3mBZBsJ2YL/gnzFLOMLCAiFQe8FSY/HHwWOGSjKtfXBUZiwc19/6XdGMcI95MG+SnDLjKILG5Hzz+T7DxdSmhucIe6xWOzsujirnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaTMd6LqkbC+czATJNcj5+puydlVcDHovZ3HGjM3MGw=;
 b=bdfD6/TAUWQrYdtqaBf4zAc2uTRJuolme5kcWe2rajSkVu6cmXzZIKZUnh8/h5P+ZkCBDQ2W7ePg0etZamGSW3ovk57D8DJg2dVOnRYD5N494p+hXswLlVc2amymVxK/a2vRq496KrXgofIlgJq45sBDaCmvRezYNDP268Xdsck=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Tue, 11 Apr
 2023 07:25:42 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::594d:e591:e271:c1ba]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::594d:e591:e271:c1ba%6]) with mapi id 15.20.6277.035; Tue, 11 Apr 2023
 07:25:42 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: use sdma_v6 single packet invalidation
Thread-Topic: [PATCH] drm/amdgpu: use sdma_v6 single packet invalidation
Thread-Index: AQHZbEW81LzPpIOiEUaFLP6kyrbGr68ls5Zg
Date: Tue, 11 Apr 2023 07:25:41 +0000
Message-ID: <BL1PR12MB5269B1FC1E71EA91829FE51D849A9@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20230411071638.279795-1-YuBiao.Wang@amd.com>
In-Reply-To: <20230411071638.279795-1-YuBiao.Wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-11T07:25:37Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f8be1664-b2d0-490c-b95c-0fe49d773cb3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-11T07:25:37Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 2f37f2a4-0557-40c5-9941-c887112b96e9
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5269:EE_|CY5PR12MB6369:EE_
x-ms-office365-filtering-correlation-id: db7ad39a-7354-4aba-48c4-08db3a5df505
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sstjkDhzhf4z60ID2utvshhEjfQvriJSiYYlnrX6a+qtjjRmvxJwofL2hI9uDZcOjFdgv0m3dZ6Tfxd8jSFcDeK8geeTPzUTQBzeg8p0oZafOoCoXbTNr4bakMOigvIGLAN/r+rIoSphIWcSQRDSiYTtaiua3Ngvh8HMnBoeNMCYd75uTpydkIZvfUHHR2gT9C4NPXFqw5j2oSuHHUn66glUxgpctzwk6SEIsHJOrAL/Zl4FSS7TVvMKazwDLGYrsppQBdzDjwEfzpK2FvCXmXs6165NnnYqUgnZNT0Wa40Ezc2k86hatm0aT4B4WtxW3VKMksUPOTBqIAkVKLAksZO4t8AsncBKr0QulQkqmcmSJSXN3BDBEF8IdLMbXR5xfTvY9FVC+hcHArnIIJRSb7Vwz7B2LKR1YSI5e3U1EvkduzS4s6Ka+wm40fK/YmY3vV5m+lCYQUjhs905W5KzAiQGynKJHRg//1HmIw1Hsy2lzoZ/CSqcKJT2GF8HyJqArUmaZURJ9rLBrajiUQA0UlSqZ89ws3PYfzJUjag+RqeZVfv81V/qEc+r3hG0lYkze2wO7HOpEQa4RHEtllNLTl3ZiynU917satuxM/2XcqR896mOy0nxd5jNR+c2Avb9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(2906002)(76116006)(5660300002)(33656002)(8676002)(4326008)(478600001)(8936002)(41300700001)(66476007)(64756008)(66556008)(55016003)(66946007)(66446008)(52536014)(71200400001)(110136005)(54906003)(7696005)(9686003)(122000001)(6506007)(186003)(83380400001)(86362001)(53546011)(38070700005)(38100700002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZmE5WktSb1BHRVpXQVVCTS9yNkNObFlYcVhiWHBNRUJWaWROalUxQXp2?=
 =?iso-2022-jp?B?WFRFSWNTbTlpNlZKWWF5bVJIcjRDWXhrY1ZhckdHdmtMMFRnb3hLZUhk?=
 =?iso-2022-jp?B?WERHOXFSRkt2RWkyejJKdUNJMy9oYTNsZDFTNTF0Z1h5MXcvUml5OGZj?=
 =?iso-2022-jp?B?WUhVZFJBSG5ITmNsbTkrQVdTN2tPZWRVQ2VMc0xJQTM0bFhRNHJqMXJv?=
 =?iso-2022-jp?B?Q0lQblRkZENiSTYxL2lpUFNZQXcvZG12dUtjM2hJenVVc1FVdVVRRWo0?=
 =?iso-2022-jp?B?RFpDeGI0a3NmVk5JNWxueEFwMEpFckVtTlc0ZkdRdXVvdlpyRG5EdkQr?=
 =?iso-2022-jp?B?bW9sNHhwbGJVS1UrOEVlWW9GeHM4UG8zTll3N0lYQkQybE1TRDN5TVh4?=
 =?iso-2022-jp?B?NnhBTEN6U2VFakF1KzhCY2dvTzBOdkxWTzRVY0h4T0pIYlVjeUhKRThp?=
 =?iso-2022-jp?B?ZHgyV2UzSWJoTHQxYWYvUXk4TG5qcDRxN1dkQ2w4WllHY05mOUlFK2Jj?=
 =?iso-2022-jp?B?RlFMNWthaWMrTlVMaXBHdXNQbWtaS2J6Z28yb0t6bkdhKzZzMVU0OTA2?=
 =?iso-2022-jp?B?YWw2MkcxRmxZNEtHZEo2a1BJYnE0RW9TOTJOYnVVN3ZYY1FpU0kvaVIz?=
 =?iso-2022-jp?B?cFBKWFk1U1RrbHFNU1Q5S3pUME1uWWlQbHdtemJST2lxTFRDRWo0dEdw?=
 =?iso-2022-jp?B?TDJNK3pGWENsNmUvbmt2dW9uTy9XQktDR3BXS2YxTENpN2hHN3VjNlBp?=
 =?iso-2022-jp?B?ZWtObTUzY1NmaEQ1YzJjdTMzSmhDRldqMU9zTDN3eDIzMC83R0F3R1Jv?=
 =?iso-2022-jp?B?bVVRTkJXcndtamhKQjIwZVB4cGx3am40bjl1cW5KcVpKVXpPamh5YU84?=
 =?iso-2022-jp?B?SVBqYytFa1Rwb1ZtWW1TamY4SUhzQ1U5OStnZVNEWThnV0JybE14TDBB?=
 =?iso-2022-jp?B?WnZXN2Vkblp1aS9SMDhMV2xoNkhpK015bTA3eXQrdWUvWHIwRzlEcmhJ?=
 =?iso-2022-jp?B?elJJSVZNY2ZmZDczdmpTMVd0d1dDcXIrN25NcE5mcWM1OXYzUy9mcWlM?=
 =?iso-2022-jp?B?SGFRSS85MkY5cjVSWXhjaW5oVmhuaUVVYWp0MWJUWDhDQmhDVGtMc0xP?=
 =?iso-2022-jp?B?ckdkRVBrSlZJU3Y4Y0dTU3JXQ2V4WlpDdFhFLzJOVkpwdHRyMjNCajBN?=
 =?iso-2022-jp?B?bUVkYzhTUXhkUDRxSEFERVZjNjBXMUhVdzlnZ2loT2tiUmNXazB6c0ht?=
 =?iso-2022-jp?B?UWo4L0RkNzhPOG1zb1dERnZ4cURKMjNYeTdGc2g2ZlRzUnBzeThSY0FI?=
 =?iso-2022-jp?B?U1pGajRtWEh0cTdMR21Ya1c3amZ0TG1aWUdJMnViVDNSWlB2TDZiSFJB?=
 =?iso-2022-jp?B?NmhHSjgyWndWL3NleWhaR2phbWhYYjhid3hwaGM5QU1UVGUyM1JyM0k4?=
 =?iso-2022-jp?B?SWlKcm91cEpVcGdjbHYxSkpxU3IvOHB6YXphL0lyeTM5WTJnVEZLWUh4?=
 =?iso-2022-jp?B?N1BhYTVub3ZEa3ovOFdZVGFzRHRQN1MwVytCWnFMdElDcFhOY0hTUmZZ?=
 =?iso-2022-jp?B?NjNORGViSXlMT2hyeUg5REYxYzRBMzNBN0Z6dWppbWYwbExrWk43RnFZ?=
 =?iso-2022-jp?B?NUcrMldNVzVrMm9lUldkWmlGTndpS3JNaWlPNytqbE8wbW5tWjJBUERD?=
 =?iso-2022-jp?B?Wk9EUERFb0lTNWtHWUhSRkxzRXNaRklaRU5FenVYVkZkSnEwYWQ5U3ZX?=
 =?iso-2022-jp?B?dThpQTFBYWR3ZHMwajZtT2xRZVJoNXVYRmQzT3dIS0tCYVR6WnZjQ3Yz?=
 =?iso-2022-jp?B?Y2VLZFUyZ0ZBUlJMTmk2MTF1TUpJUE9tVHVxOGNac0JDN1RiTSsvcE1y?=
 =?iso-2022-jp?B?alVTWVJWMWtKdi9iSitOcUwxelo0dFJqQzlBWWFrT1VheENFVU5WSEpl?=
 =?iso-2022-jp?B?RWw3TzhxS0xzUUw3TG1ZQktzdUlCUFdkOXBPdE5xWjN1UnB1bVJ1ZjZU?=
 =?iso-2022-jp?B?c1lWdDk5RWJ2VmpSdTl6QXdhejZvNFArSjRrV1lNcGx6ekFtMWxXa2lZ?=
 =?iso-2022-jp?B?VU9BSVc4MGR0TERhUmZ2OE1rK3lZVzFiTlpTMWZUVEU0M3ZqQjRXVDFq?=
 =?iso-2022-jp?B?QWJ1RVZRZE13eGdTeC83dWVLajY5a09OYmNHcXN5UEhJNDNNdDVVRmVY?=
 =?iso-2022-jp?B?eGRKNmk1RUFIWmNlL3VQUWsvYmx6VjY5Y3ZkQThnaHRPRnhEbmVWcnYr?=
 =?iso-2022-jp?B?bHFiUT09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7ad39a-7354-4aba-48c4-08db3a5df505
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 07:25:41.9955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWzdP2lpuJ0/wEFJVrN331HJm2TZLP65oa1sx8PuA1y3xOhlBjCByPKMcXK4+LbZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6369
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Monk Liu <monk.liu@amd.com>

Hi guys, please chime in if with questions or concerns, this patch looks go=
od to me.

Thanks=20
-------------------------------------------------------------------
Monk Liu | Cloud GPU & Virtualization Software | AMD
-------------------------------------------------------------------

-----Original Message-----
From: YuBiao Wang <YuBiao.Wang@amd.com>=20
Sent: 2023=1B$BG/=1B(B4=1B$B7n=1B(B11=1B$BF|=1B(B 15:17
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tui=
kov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.=
com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawki=
ng.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.=
com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Pelloux-Prayer, Pierre-Er=
ic <Pierre-eric.Pelloux-prayer@amd.com>
Subject: [PATCH] drm/amdgpu: use sdma_v6 single packet invalidation

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Send this patch on behalf of Pierre-Eric.

This achieves the same result as the sequence used in emit_flush_gpu_tlb bu=
t the invalidation is now a single packet instead of the 3 packets required=
 to implement reg_write_reg_wait.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.c=
om>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v6_0.c
index 3d36329be384..8d0c8f2cac06 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1175,7 +1175,28 @@ static void sdma_v6_0_ring_emit_pipeline_sync(struct=
 amdgpu_ring *ring)  static void sdma_v6_0_ring_emit_vm_flush(struct amdgpu=
_ring *ring,
 					 unsigned vmid, uint64_t pd_addr)
 {
-	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+	struct amdgpu_vmhub *hub =3D &ring->adev->vmhub[ring->funcs->vmhub];
+	uint32_t req =3D hub->vmhub_funcs->get_invalidate_req(vmid, 0);
+
+	/* Update the PD address for this VMID. */
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
+			      (hub->ctx_addr_distance * vmid),
+			      lower_32_bits(pd_addr));
+	amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
+			      (hub->ctx_addr_distance * vmid),
+			      upper_32_bits(pd_addr));
+
+	/* Trigger invalidation. */
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATION) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(ring->vm_inv_eng) |
+			  SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(0x1f));
+	amdgpu_ring_write(ring, req);
+	amdgpu_ring_write(ring, 0xFFFFFFFF);
+	amdgpu_ring_write(ring,
+			  SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(1 << vmid) |
+			  SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(0x1F));
 }
=20
 static void sdma_v6_0_ring_emit_wreg(struct amdgpu_ring *ring,
--
2.40.0
