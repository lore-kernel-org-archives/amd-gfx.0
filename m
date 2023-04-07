Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76672C6FD1D
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Apr 2023 08:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9A410E00E;
	Fri,  7 Apr 2023 08:20:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3AC210E00E
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Apr 2023 08:20:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIyiuMqmI0mdmraWRnj7fwZwOoUBeL7zxYPbIS+6mQrPr66blYqYkxMIK3qWfxIcraZeKFCttDosw6sJEBhimXfRIZIA6//+fSpL9XJ2i7fLAmjhuBsAzk7uU55DDghO37KRoU/j1Vosbs+pp7YwIDLddCyYFLJrD2YlhSU13N1tAwmmlGKk+hixOBINtO2/jc2voQQso8D5db84YaOHQNvBhCDkSwaeFBjcXAUXTVohYjFtQAvfCBv/sFdJnW/9UD71GRTMWS424wF890Ogr36u2y0TZr3kUV+4NP0LY1dxNQ7o8C6ba9VUKyfXkwq96V+YDd6hvBo5ZOCoJcSBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRPHfRuuzqu1jxkKw/pbXExqWwrJhAq0uEmpzyw/Rgw=;
 b=QP1qaxJc1MdiBbZbt44G4R/wka+04uGNb62ltGGaUvMUuQoo7iuh+VFq1hAoBPUGfNyQZE1yFhLlxAGNmvzZ/5mh9oRed4It/yi1CYFkDGxAuGJRRuMtQUe6g0tpJBCTf49XRU+nRG6+Zv+i/XiqTor2M+bsEMpTol42IECeo1fFnyexh8AiID/6OEefEHXdGu6yViby10qeGhNIerKAzHhqI4vT+OJApcW2kwpU12PcEERkLzOwlQ/k+bvyMbbWZVzma6RyYbFBkm8GlJq9COu8cZou6eu+B6dYBOF+mUtcJauq5DzRJkBe95EHZJ85tWZexNaF4M2iS+maOK+Ujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRPHfRuuzqu1jxkKw/pbXExqWwrJhAq0uEmpzyw/Rgw=;
 b=VUR2jdD9Cx1mxeaBT6Ck5oj8WWCTNbejJ4tRS676gz+oX48L83A1qeI3y4ZwGmunhwdH09JjiuuYgE0qnXvcqTsjvy7pzVjzTzmZqajkDxF0AUD8+yjv/36Tk57pNIEOB41F/ccgB+SIaIrwhoumEEtd7v+sTX/E798dOnx2008=
Received: from DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) by
 SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Fri, 7 Apr
 2023 08:20:29 +0000
Received: from DM4PR12MB6134.namprd12.prod.outlook.com
 ([fe80::75a9:e409:8d14:bfeb]) by DM4PR12MB6134.namprd12.prod.outlook.com
 ([fe80::75a9:e409:8d14:bfeb%6]) with mapi id 15.20.6254.026; Fri, 7 Apr 2023
 08:20:29 +0000
From: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>
To: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: refine get gpu clock counter method
Thread-Topic: [PATCH] drm/amdgpu: refine get gpu clock counter method
Thread-Index: AQHZaHB2pgT3n8cMwEKudhxCO7lFaq8fgdOg
Date: Fri, 7 Apr 2023 08:20:28 +0000
Message-ID: <DM4PR12MB61346E6C13658A8E0E70D69A90969@DM4PR12MB6134.namprd12.prod.outlook.com>
References: <20230406101327.28310-1-Tong.Liu01@amd.com>
In-Reply-To: <20230406101327.28310-1-Tong.Liu01@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-07T08:20:25Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=02f603f2-665f-4c8a-adbe-25aa6f51b371;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-07T08:20:25Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d52a0862-7012-4697-a730-7bdd3a2ebc09
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6134:EE_|SA0PR12MB7089:EE_
x-ms-office365-filtering-correlation-id: a17b680c-cb9a-448b-7010-08db3740f283
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fbgexshaZvmEVdQc5bCg+E2FYsC+Z2ukYcz5zDLfAKoy2su96y+7GiZrubsftz5IQ9dMvw5ZYKr4zd4GGiiXS4rMHZV2joDKg1X60sCMqvk2DAKTgVzhuotJ8Al+jh083g1F54Qi55vvG40xTf1gfhXSNwUip9crqoSipn+cGb0dgR3RR5g+aGzsPvaIhw9pcQL14CE5pIsGCgzbFC8eoLipchJ4lXbSA5O/yZ4QtZrIn7GIdQtfbYfWK0DCCsAqrLKKQQy3TtO1xm7sqC5TPk4m8a37vVC7v7Whq/2kwUn1f5rlMCOdinW7vw/EUn9qsxOZm4qipBusgvsTm5xCKF00zamMqZanl+R29wMYBptBwA0PbNT5Af3G3mpQeAVawpdbWQuZqkEfeEx+2UBwlMVA6gsoQrE8GG7G1712mJAUGF6Gc0FPagB/xJdud29yQ7oLqcogksnxOjDp4qzv6ilOZs14j5t8BusiWRPiWTD0so9r9EqYvjQfyJ24nCOYLNbUqPXDbMxm/1hX+2gMMIOguy+fr3DTAkaNSRT4hVINwg6iYv9KF2QECCvyTZvoVGULibVzBcpe8J2/VnyJIZG2sL1I2XiShwZVW/b7fO+kmbH8h0JPNpYvVkB7gwEz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6134.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(86362001)(53546011)(7696005)(6506007)(71200400001)(83380400001)(33656002)(55016003)(38100700002)(38070700005)(122000001)(26005)(9686003)(110136005)(66556008)(66446008)(8676002)(66946007)(66476007)(64756008)(54906003)(316002)(52536014)(2906002)(8936002)(6636002)(4326008)(5660300002)(41300700001)(76116006)(186003)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?czlGVXY4UDFVTVB3MVVtUzdySmpIcmFxUXROdVdxdFljTFNjeEV6Mm9z?=
 =?iso-2022-jp?B?K2swa2kvYU1lcTV3V2NQTTNNd1Nnajg5Skp3Z1NjVVZKTjlSRURGRUxV?=
 =?iso-2022-jp?B?VE1zWk5pdThqSFJNMTFORlU0anYydVNRSXh3aDJKTFpUNk1qclRsZ1dz?=
 =?iso-2022-jp?B?b0ZRblNUYlBtL1RvUXR4RHlDK2FkeGVXRm5rRE54RWZEY2I3UnlweG55?=
 =?iso-2022-jp?B?MzFNM0JRd0VSbzVXMEl3NVRXM3M5aXBnczdkRU5GOHZsYzNzRkswUEpa?=
 =?iso-2022-jp?B?dURIMHF2OWdQTExaN25ZZk5weXpaWTNMVTFESzF0anEwUUNKdnRnMnZS?=
 =?iso-2022-jp?B?ZGtkYjRSVmhHL2xTYTFHRzJaWkZldjVwTkIwLzdMQ1BlTUxZcWh5b2k3?=
 =?iso-2022-jp?B?WkJldC9rV2RGOElkN2MyblNxM2ZkMGFUZmJFSnIwNGk3RFQzY0ZwNmhI?=
 =?iso-2022-jp?B?dEJza0ZyT3hYVkNaN2ZJTnloNms2RXZURXd0S3A2VWthRzdhSlA4UUZ5?=
 =?iso-2022-jp?B?V2N5UFZMZUdlaG8wVVpPVnpwMXkyMHIwZ2dRd3huMFQwdTBEMjB1Vkdh?=
 =?iso-2022-jp?B?OHhJK0ZQdXVYYzVRS25taUtpb3lxcFRnZWRibGU3bVlDSEUzRFNmeDI5?=
 =?iso-2022-jp?B?RnU4Z205MXVZLzRoaEpEbm16clliOXNqTDFLUVB0U1Y4RVc3ZWsyYi9B?=
 =?iso-2022-jp?B?N1FndnVpR1VjVTROWEJoZkEzN1kyY3JSNitDVzdWRFpSZXlvZFU4M0U3?=
 =?iso-2022-jp?B?aUlrOWJER3MwUjZkMzJzYUVPdXBjV0IvZHpqY3JkbjVsSmZuK1VUOFdh?=
 =?iso-2022-jp?B?M0RjZFRkWVBKdmJOd0l1TEg0QzFWcU94a1RYYWNZN3VOTWVGTm1qUTFj?=
 =?iso-2022-jp?B?amFLVENaYWZEOWhmS3V3aUpFcUNkTG5lM3p3R1MwQS8zZTZLa011Nzla?=
 =?iso-2022-jp?B?UzZWUFJVc0JrbHpPZWNpN1pVVXYwL3g5bW85MUdZN2tXTng1b1ZUdnpH?=
 =?iso-2022-jp?B?dXU0aVNJN0VQSy8yQnlUa01hZUl0SGFJdnpWc3dUb1lGdERkWlBEQlFs?=
 =?iso-2022-jp?B?dk5BWkxCREpkczZxQ3RXZmR0M2xJS08yZGVFQkk4ZEhDV3VRRCsvTVRm?=
 =?iso-2022-jp?B?a1JDTisyZm0ycVVWK2tERmZQVHQ4UXpxSGtoNmoyL1hBUDArZjNralVo?=
 =?iso-2022-jp?B?bVZaakJxeEU1R01tdXFjRElDeTJOUGVXdEd2L2dUcUEvRHZMTDBoeTRy?=
 =?iso-2022-jp?B?TEx2VFcvK1FHWXdCUi9DNmVMbnBBYUt0TllZQk9YbEJsYWZYbUdTUXVv?=
 =?iso-2022-jp?B?VUdaOU9GQjVZdmxOM003U0hsN1lhRW5iYkV0bHJUdEoxNG5KYWlWeHdE?=
 =?iso-2022-jp?B?Zlc3MURPSnZOeXQ4US9FR1c1SnpsSGlVZTR2YW5aS3pzTnlHNjVKdXJz?=
 =?iso-2022-jp?B?alRScTlSSzVEV3ZYT1R0dkxOWis5bko5VEVzSUFaRWhRUXFLL2FNOXpz?=
 =?iso-2022-jp?B?NytjbUZZcjhTZGxnN2g3RU1GcEU0cVdxWWhSV1BnUmV2bVQwWlN3bEhQ?=
 =?iso-2022-jp?B?am51aE5FUVErZ3NwamxabWRuQ3V3Tnc1YjJ3TVM4djByVWRFVWMwVjVG?=
 =?iso-2022-jp?B?RllZbVNlZSt2TUI5SVdaek5mcmxkTUwvWnZxd3ZWWm4ra0xWd05UL0V2?=
 =?iso-2022-jp?B?aUpDdjNGUWg1Q01Cd2F4TmV6amJPOWxHb2V2WGdwdUorNklIY1loZXR3?=
 =?iso-2022-jp?B?cU5INy9uVlkzUDJxNVk5Z1Rsd0ZDVGRHVXZWZXgxU3gwUDJ2ZGVmNFBo?=
 =?iso-2022-jp?B?YXIwTldmNCtCeUJpYjFLZHdrM0RSYVJPS3d4NDYrSEo4b09RK1gvZm5s?=
 =?iso-2022-jp?B?Smdpb1pCTElTZnVieTVyeWxpbkVJbnhmZEg5cU1nV1ExQVN4UlJ5bWl0?=
 =?iso-2022-jp?B?WHBBREhCc2s1RGd1QXd2dHVFYmlmc2hSTEVNMFh0SEx3U3l5dmdQRERJ?=
 =?iso-2022-jp?B?eGlXY0RaeHo0S3dJbitGQmM0VklzL2tJeVRFNHhnNzFnY1ZVSXd4d3RP?=
 =?iso-2022-jp?B?bnR5S25kQmpsZ1RobEdOMVdiMFZBZURvRTJxdVhibndna1BlbmlVNmxN?=
 =?iso-2022-jp?B?NTV1ZmlIajJycHhFck04dTVxOVA1Y2RvK256YnVPamRGdmRUVC9BQlJu?=
 =?iso-2022-jp?B?ajRMVnRTck5xc2RnUGw5amNYZDJnUUg2T1htNlhBcnpaVE9HTDRhSXF5?=
 =?iso-2022-jp?B?TG1sMTA0dXFQenB1cC9nOHNscFVtYUhPTT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6134.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17b680c-cb9a-448b-7010-08db3740f283
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 08:20:28.9164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Keo/lIaLMgpPhIh9eAn6cYWFRxdITCvcEF+GS4cWaOBth+q0pFlxBWXOxbEWOrfvZMriPGkLMLidkFE4uXvHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Liu,
 Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi,

Anyone can help review this patch? Thanks!

Kind regards,
Esther

-----Original Message-----
From: Tong Liu01 <Tong.Liu01@amd.com>=20
Sent: 2023=1B$BG/=1B(B4=1B$B7n=1B(B6=1B$BF|@14|;M=1B(B =1B$B2<8a=1B(B6:13
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tui=
kov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.=
com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao=
@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.=
com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd=
.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Liu01, Tong (Esther) <Tong.Liu=
01@amd.com>
Subject: [PATCH] drm/amdgpu: refine get gpu clock counter method

[why]
regGOLDEN_TSC_COUNT_LOWER/regGOLDEN_TSC_COUNT_UPPER are protected and unacc=
essible under sriov.
The clock counter high bit may update during reading process.

[How]
Replace regGOLDEN_TSC_COUNT_LOWER/regGOLDEN_TSC_COUNT_UPPER with regCP_MES_=
MTIME_LO/regCP_MES_MTIME_HI to get gpu clock under sriov.
Refine get gpu clock counter method to make the result more precise.

Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index ecf8ceb53311..107c487c0c37 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4671,11 +4671,24 @@ static int gfx_v11_0_post_soft_reset(void *handle) =
 static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev=
)  {
 	uint64_t clock;
+	uint64_t clock_counter_lo, clock_counter_hi_pre,=20
+clock_counter_hi_after;
=20
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
-	clock =3D (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER) |
-		((uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER) << 32ULL);
+	if (amdgpu_sriov_vf(adev)) {
+		clock_counter_hi_pre =3D (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_H=
I);
+		clock_counter_lo =3D (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_LO);
+		clock_counter_hi_after =3D (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME=
_HI);
+		if (clock_counter_hi_pre !=3D clock_counter_hi_after)
+			clock_counter_lo =3D (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_LO);
+	} else {
+		clock_counter_hi_pre =3D (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_=
COUNT_UPPER);
+		clock_counter_lo =3D (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUN=
T_LOWER);
+		clock_counter_hi_after =3D (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TS=
C_COUNT_UPPER);
+		if (clock_counter_hi_pre !=3D clock_counter_hi_after)
+			clock_counter_lo =3D (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COU=
NT_LOWER);
+	}
+	clock =3D clock_counter_lo | (clock_counter_hi_after << 32ULL);
 	mutex_unlock(&adev->gfx.gpu_clock_mutex);
 	amdgpu_gfx_off_ctrl(adev, true);
 	return clock;
--
2.34.1
