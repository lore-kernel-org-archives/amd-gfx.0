Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B3FC433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 14:20:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158F76117A
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 14:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158F76117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C95386EB16;
	Tue,  4 May 2021 14:20:26 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2084.outbound.protection.outlook.com [40.107.101.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA9266EB16
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 14:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuBVGjCvVOPLqeE8QB2myOM1eIIBX0KLS6aiyNPTBJyoFIWZ+VF4Bu3+1CNziGJwFJ8UHSpcE61XHjunbGb6Tu9OBXZmPNiPmgvONjvROymQPpixToa9MuEyt7YqbHmOAIG071JIp2lFH4lwxqMHECA2RBJPwEJWcImnEaM3qlUUeHw6Q0f8nVBbd0Z1J2o6o1wj5/hI5np29LJKxWHJ/YyazxobHqn/DpAoGqzEtS6OTV3w9TTWVy1itOUWVT5FubozaKKeNr1prjXA7dxHfyVBreyo0OaLt3m5KyFPDVKCRRptwIXGC7ZvXFImEJAcu96cDoctbTUJBIZcsuisFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OhcQAg2+RJT0s6myVHXKBWMzuRKUi0gMKeR7ysdQpI=;
 b=kZWOHm+qrtoNwPk4Cq961ZcHEYXmXcodcYt+RPoQOcOIxHneZ1hXcSywNQe5XTulXaX71V13QvB8b2olRpp0CjOGJgAJ1RP+N0+I/xyuW12M82Wo3RoLEfxzluod2kclpbSuxjNYyzniNFgWaJ9FMfKa7GXHcoJJi2z1AjWHvhIpwbYhuRJATurS10tAyTjBCUJlXTArBMY/0gD7Y+et6vCAyB7VKXMyBgaOtsmKldq6nW6tBbV7qqtXg2xPyu7CzpAxkVB9Uw2Wi86pXos5K/SwN2DdXYGkILWVzbd21u8/F4W6UMVuZ7oythM+EAbimYCP2+/awb4CX1Xt7XXGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OhcQAg2+RJT0s6myVHXKBWMzuRKUi0gMKeR7ysdQpI=;
 b=T+H6UXXculhzg74ojz0XiDmDqFH3y4NIVekmy6FbpFwTg7FqtHXrawqVGtlZmJAU1W5fuaAFPyDWYREok7JstcP8Krj0lN0RpFpmJlzm7t8IgNpUQzVzHD8+Nqb7YLPJa0RruTTrXoa4NRSdnyM5T67QlQ9vgubKq7VSrTY2lBA=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Tue, 4 May
 2021 14:20:23 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 14:20:23 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: drop the GCR packet from the emit_ib
 frame for sdma5.0
Thread-Topic: [PATCH 2/2] drm/amdgpu: drop the GCR packet from the emit_ib
 frame for sdma5.0
Thread-Index: AQHXQO4mBQumHkbaeU+1lqJXMlZi36rTX0rw
Date: Tue, 4 May 2021 14:20:23 +0000
Message-ID: <BN9PR12MB5368817C3E0D6782E3FCD36CFC5A9@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210504140211.1703369-1-alexander.deucher@amd.com>
 <20210504140211.1703369-2-alexander.deucher@amd.com>
In-Reply-To: <20210504140211.1703369-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=328876a1-8b10-4ebf-bfd9-60cca8bd47ad;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-04T14:20:03Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b24fc3c3-960a-431c-2089-08d90f07c18a
x-ms-traffictypediagnostic: BN9PR12MB5337:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB53375BA8890AF1173497628DFC5A9@BN9PR12MB5337.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pXvMlBQa0zC1AbTawSZnwybREuKGMATnGz3JbK5NHGXEP1uO8LmBZaefHG57n6PEw5rb0nCvJE6Cw7U33A5zzpjoCR+5pP/UifxOq6lOAFX3EhbJCm59fQ+z28oR6MIYnMPAPJbMbMWCnN/YvP+Vdwfuv26yKZ8mtXgUBUxNDSARrZ/7cIl4D/h1dwG8c21ufUCamkcCfjesB0Wsgikm+/mUOfJhaNGCo2TRLIyyXPaIm5aXKNDGCBJKlXisecZ0Wqy1Dbk5twSaezka6w8x/4KU3QLW9ypIKgYpE/0P6sEucRw4qX0WSnVNpCsDHAbONq0iesg3xWZqPdZMkDR/IgMBlNFdtD5CFh0k9KMnnq6NkfSREkRMcYgE3uDJMguK6IvEP7CmBbI0d9f7EBJpY7plxUh1hrYQRIyAkKNa1Fm3lCRckMpf/tomDWfy4bwh1tG0g86b7SiHztylSSHfuxetxiJ4lYmqehKYgjALLGlmIDcHeMwlXH+RHzNO6NNISgGcEXOtTTR1dVcFTEsP93iExk2QukQKM7lISjZeRaV+Mtl6yuYxgcYTvivtEP6Bqz4+6/QZ+NUcJCjCejdyPpfqAVvtF+iqWQuOkSogRwrAMGtomuATIyucuqxFrPodzlchKYP0Qpe3iXKWvRUFdw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(346002)(136003)(396003)(366004)(9686003)(33656002)(52536014)(55016002)(83380400001)(5660300002)(8676002)(71200400001)(8936002)(26005)(122000001)(186003)(316002)(76116006)(2906002)(86362001)(4326008)(478600001)(66946007)(64756008)(966005)(66446008)(45080400002)(66476007)(66556008)(6506007)(110136005)(38100700002)(53546011)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/1KmcDT6f+F3I87IW4iCzCQtweOomzkTSY8PJoi+jmfqU0fLJ27HcqntSw+q?=
 =?us-ascii?Q?x4xGhI8cz5aaBgjRZ4pt0LXNna1JBYBlbhHDbO4zi1VvdYuHXl2QTXfpFOTy?=
 =?us-ascii?Q?mfKIp88GS960a3d/9DrUbwEV9sNvxruoHtGnD54iROcV0mIiq0kaQcHvW9lg?=
 =?us-ascii?Q?ayAeM+Q//YXD1aYFyC3QIEuYeElbhoK2KZ1M3nAZ+GFHbs9EvRrehQmvhfil?=
 =?us-ascii?Q?ZrcxciZ4usCaIrPddnFFWFYipXdgTU0CbbSgoO09ANSR4lzgb9tt6ol4fzaF?=
 =?us-ascii?Q?jn1ch+LCJaqzJTvCY1FC4gHuZD2huTvWKO3FsmCiEGLbFlUZa5ZvhU00V95C?=
 =?us-ascii?Q?9x45po14/bDJhfCayi++7TNul2xCqbJIJ579LjwTVQCzQhduM1JvaeTOFE1d?=
 =?us-ascii?Q?mrHSWh+0nspzmyH7mTySxCTZIfCW42EHB6kxZPqYrdkqxvBl0hH6064q8aX9?=
 =?us-ascii?Q?nvIVeeVkvcbm48hRq40QAam3lgcW8Ik6dfXzOIb0mC0Rugr0zv6h3WIJ3RMu?=
 =?us-ascii?Q?MuXBU9GTCftKCAupFfL/lLwGi3iK1sadgHlsLpnK+v95o9EcAzY94bSdEjZE?=
 =?us-ascii?Q?RK3WW/ov+Ng2GN6eM5VZ7JTAZUNn6eLDLNKzUfvUdxpQu2SeBLPmmNkcLgIp?=
 =?us-ascii?Q?WX+/ttZaSAIWSSXnMZLMNiRbv3lgm1clF0Lxb2qt77OnTNe8ZTFhVIeZ6U9Z?=
 =?us-ascii?Q?JwLABECCVCVyrinrmoLha9Ote8uq89basD4ksjXFwfh386Jnf9eCWcqpN4Dn?=
 =?us-ascii?Q?8jANzCx+v36dKwqFZejtEu5+/pwMdHzo3KnUtdM+cX8zqadKwiGadI62bqdh?=
 =?us-ascii?Q?azOrussMYCht3hiCAJP0d6X3V0C1Z8z+C+WORA4asBNOfxe5sSovqfjeEoCv?=
 =?us-ascii?Q?4Suvo84p4U8ZDfeA7idc6FbSDUHmoCVB7sGyoJYztzk804K9hvRcQv5huqXg?=
 =?us-ascii?Q?5hG4op7HDGu69///OsXk/xMWD0OgORZaCejr7XCCL5J6Qk75ermRTx/OzWuL?=
 =?us-ascii?Q?nW79VNcXYrMwsAWmj2rc32UcLRETSmYKU9JdIfGi4xmPQvUFxhzbt2KJBf1p?=
 =?us-ascii?Q?hTM9fRJPFW8gXTghlNt6EIgbCt2yCJ/cug9N0+Nb9kh6c/RbgO3kDbHbLBP/?=
 =?us-ascii?Q?Cc+WK3ihUFVcBKcA4e052zrPoEHwgxsxNn/aghV2LoScJKG0lzJ+lWKswQLe?=
 =?us-ascii?Q?C90mXeIYBz+P8SREHlU/nSWENgR2fxHvrV86RCmJi+Lt4jiugNmS3cdLiIZ/?=
 =?us-ascii?Q?+UrdsLCauvQvQRpguQhYzgk7UE1ksWC+hwzxcgs1tCc5VshpDZiNCC3jldOm?=
 =?us-ascii?Q?Dbz96VhuC612E35bFr74GwOP?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24fc3c3-960a-431c-2089-08d90f07c18a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 14:20:23.4146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LERggrZunZ1/Wp7pFU+ih/VshpJYj1WzKPl8DWBruXPzbaHCI2Jozv/GRF7h0EBD91PPiFzz80i6hSlvdchI8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, May 4, 2021 22:02
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: drop the GCR packet from the emit_ib frame for sdma5.0

It's not needed here and has been added to the proper place in the previous patch.  This aligns with what we do for sdma 5.2.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index d294ef6a625a..04c68a79eca4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -405,18 +405,6 @@ static void sdma_v5_0_ring_emit_ib(struct amdgpu_ring *ring,
 unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 uint64_t csa_mc_addr = amdgpu_sdma_get_csa_mc_addr(ring, vmid);

-/* Invalidate L2, because if we don't do it, we might get stale cache
- * lines from previous IBs.
- */
-amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_GCR_REQ));
-amdgpu_ring_write(ring, 0);
-amdgpu_ring_write(ring, (SDMA_GCR_GL2_INV |
- SDMA_GCR_GL2_WB |
- SDMA_GCR_GLM_INV |
- SDMA_GCR_GLM_WB) << 16);
-amdgpu_ring_write(ring, 0xffffff80);
-amdgpu_ring_write(ring, 0xffff);
-
 /* An IB packet must end on a 8 DW boundary--the next dword
  * must be on a 8-dword boundary. Our IB packet below is 6
  * dwords long, thus add x number of NOPs, such that, in
--
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C604d5a9a3c0348c8cc4f08d90f0547e8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637557337630279443%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=yUKpkFGxOa8MRRXUudMEX69jweKswUwqA9FnDNsTRFE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
