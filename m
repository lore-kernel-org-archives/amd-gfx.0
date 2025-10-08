Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF07CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 14:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68CAC10E839;
	Wed,  8 Oct 2025 14:50:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bx+DBwHL";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D595810E839
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 14:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehV1ha6P5szCdKzAikG5Rjfex0YeZzCKHTsqCho0Rtb5bPKJzpUyu0DLxZaaIVp5cjOvR/LHl3llCMzleJhivn/0/iNHJxeJ8biC9xjz/jmBxJTQgh32a2PNYB6UOQMEzv1KZ4O8U6NXfrEbD5OUkfDnX3A+nYqjSBJh7Mi26146lwcmSQTTMg5OCm1enzXylnjiOQe/L7TbGXZWo+XhO0I9jFAqfniDhCDebECGFX3JjOtmGzGbfO0Ycnys3zsZ1BnSxLsSynFReLckjOOOJ6/Vd8nJdAJD99QJN8baWjYJPW0treHPn82QdXcSxvesV3WYVQE4E0Wnlh/8v1Qeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCOWHlEOg63WDJe6FEWCMQoYSot/ZkODASsYKDo6fUk=;
 b=BITR6To3LsU10CXCwasLc71eEZ7SZKFxwb67bo7a3Mo6bui3SdrqpYuPd14bw8JKTVo0spSH4uaCaLgqraGiSM0Ab9Jma5yqRZvaQbdiHQu9ed6VqQXL++UM4fLoUHBsAx/tVdNXGiPP7AtxwecTYWJ7M9x16EZbjKw2fg4OPlAp7nmW2GwubLpye7gWnswHYPlFsUrl+Usy4aCwNFScp9Px8a6AtCxsq1VG6mafkBI2IG+GmerNrll/mTCrGZvN+K7jsxipI1W/5qCAL1p1gDa5rcvi+9hITcna/TRQ8fv1fnYBcNKfynM8coHUb6wzJeyfdqmZeNDNcVNnIdHaAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCOWHlEOg63WDJe6FEWCMQoYSot/ZkODASsYKDo6fUk=;
 b=bx+DBwHLWkNNcLjnpstg7BruiLx7+VFajMgzSns4YO8ltA5Z6DFgr98c+tmAVoNsp1naIfO2AY0gSxjp15Dm3nWyfWYNeS+1RG0JzmhJ1yzlEYm5hRo5tx5rFb6vKZSaOaI1a0XaUORoBz50kXyEGby+Kp4q4Ke+JSagrydQrCc=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.20; Wed, 8 Oct 2025 14:50:22 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 14:50:21 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "StDenis, Tom"
 <Tom.StDenis@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix handling of harvesting for ip_discovery
 firmware
Thread-Topic: [PATCH] drm/amdgpu: fix handling of harvesting for ip_discovery
 firmware
Thread-Index: AQHcLzohcaWsP3FK00m2m9LwQyZSlbS4Y0Eg
Date: Wed, 8 Oct 2025 14:50:21 +0000
Message-ID: <DS0PR12MB7804991C02AB82307ECEBF9997E1A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20250926230535.5632-1-alexander.deucher@amd.com>
In-Reply-To: <20250926230535.5632-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-08T14:36:01.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|CY8PR12MB7514:EE_
x-ms-office365-filtering-correlation-id: 25b86e5b-abb1-4896-4091-08de067a0178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Kr4BP69DQ/p9FcNaN/iE3kGv+B+IF3LRxpdCoR8zjKA2vvZmNLd304hP8omS?=
 =?us-ascii?Q?HRpImLWjad4+rZJoQkhR4lQ34LosdGyfs/O3dKPXTohZ64aGN4Z42YqNUyWd?=
 =?us-ascii?Q?akYOP/7YK8l5tH2Kg603ct5xUgWfgx+fH+wuYoKvnSf9+OhZZL/5o4tEaucM?=
 =?us-ascii?Q?w8E9d7WOncnZnbPIHSfG096GpwYoVMsGuKsOdgRDPsfieRN7gkCUkM3DuH4j?=
 =?us-ascii?Q?KL5/5yp4XIGakIDklUPkgnzCPKUSDPaXEEyMl7jX8p4TMqwtUH/IEp+gjexh?=
 =?us-ascii?Q?aLWMXaFnXoPSGAmx3lwsz+dWUQ8KK6LOshxCrk2H6pEnfsecd33JnJsoQF3Z?=
 =?us-ascii?Q?TACToss96hCxkiWVERlEy/n4sljl52K8AAgrcGMGOEgrLExUza28aoNfzoVM?=
 =?us-ascii?Q?RGPnHtiBfaUQmJ2NDm/kiqqGKSphz2Kd+G+Rr5w/NNkOqfbxyV3ro+GM6Mlx?=
 =?us-ascii?Q?pZ3yOWcDSPLDSRHyzxYQsOKfl5eArAd6pX2zATw4D0DR4QLkCGSvcnz1Wcr6?=
 =?us-ascii?Q?uOW3s/vRPWPhD5VxLslFf6j4eXBC65P9zo91f2UT6bXp8iWnyrWz7jB3v6zT?=
 =?us-ascii?Q?kZjH7N+wPHWUP2SsEZsZ59c1EUJQmRelrqDgw/Qu0PutDFz2YQoDFghrinAN?=
 =?us-ascii?Q?9ePS+FGyUm5+ygmxjTgEpifKw06qltjKc1lFG0Pp8EJpGMu/EkoSGYZwIhdF?=
 =?us-ascii?Q?LruGo+edvOSr/gb1UicD1ezkykXR7xOK28IIIiOGPLyKa6jQUjqrELnYHn7D?=
 =?us-ascii?Q?Igb4PEGV51vk9HdaHoCgPDsR0gq549lPippWshiaitgniLzYI0uwG6Yf1gcS?=
 =?us-ascii?Q?BXbZSD9ctZZ4uVrxOrrMSs5mpKpHFi5ApOlBYhRdZCjeRyee5hahTz4Jxpw7?=
 =?us-ascii?Q?e/PekOf5v8JhujlEKbAy4eMfzo7OuCf7KDh0fwRM7mfLnKnE08p6cN5HCZsY?=
 =?us-ascii?Q?W8Av0OJ01KxLD7xQ8km8lUqnRDsU4NKzH+rDwn/djp3Kph5e4E+HbWepe2MX?=
 =?us-ascii?Q?8t23N9XgL0fKajbIseEGur/z1YziH+ehQBdx0TFdw5ruAkx/A/XqTnKG4OX6?=
 =?us-ascii?Q?CpUS9cHAc3TwDQSlC7ddTFwHUWKviHusokrdNiHiMB2klPcquB+Kl9IOhGf6?=
 =?us-ascii?Q?TmI795NazMPVt5jX0Qnu+lBF93zkkQqsPeOktgrjA9BpqR9+QsqAT0Q4r5XM?=
 =?us-ascii?Q?Ko82WXYNxZ3bAlaq9pZzjhtEThtqJ2f6VvxuT7pRsKKaUBLpWKVGoejlY7mx?=
 =?us-ascii?Q?8Lx8dj0rANSRr89NFAyaHU0adS/RpFRgaCkGYiMc0q1k7yCThtCkbsHygYW0?=
 =?us-ascii?Q?RMjTxfzKJAu+ZY87WXuSeT/+DMB6nFdll1AVmfpx6CXwUdqx8h8hKgcHoYW+?=
 =?us-ascii?Q?8+JGy3hObuubOw+ePE8SFQR7JxcCnZnje2xS9863tk5IZdi7DJTBstE5jU7v?=
 =?us-ascii?Q?77VxYCqj5T0HnrEMDYeEzLXcudzReHU7Avl6IUm6fkqx4dIb2AueuMmpMior?=
 =?us-ascii?Q?cqEDKfQi2b6lm8q39EuwvpYBGq3T3DY2lBLv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EMD+gMCAdUkPEkR6VdvJj/BkiT3qyO1SE9hFjBbpWe8W1JtwbVoQWlsbfJg9?=
 =?us-ascii?Q?9/1kXWFzCvTjKbt2k4aw8VocNTu1yM/9NNVlBXbxrkJ2uUVW6xgjm951x8Ns?=
 =?us-ascii?Q?deRtQ90ALip7QcdhP8zNTsAXLMCHk/uKBFOZZ6Kd6cpXXEm5gBnrVH8wnJD6?=
 =?us-ascii?Q?5jwmcwaYmH9R22uzpXah2BWztf6rf8lurThZysdx1OiE37Fwe0bv+NSC4nPd?=
 =?us-ascii?Q?TNQbDq6ZOaXCgm7/BErOiaIHgRWJwCIawhDKe5uhQGKON5GRQlJ2c+Rqywwu?=
 =?us-ascii?Q?lnaxk2bfx4CJOPVocy43/H9dnbPqawgpLPAviEahF75vx8jNSTQfV8a6toRu?=
 =?us-ascii?Q?UKGTyakjxt9cK0sr12NMb7t7yS9WOoUsCJrOCWuqQDn5gABC3s0R/wkrjgg/?=
 =?us-ascii?Q?YydX6svUBvjcvTyiA2OrD6vzCX9jif68VoEms7l9BQPREbYerYwlTKXAYatW?=
 =?us-ascii?Q?babC8Uu1c+fkg6HJmQAY+3ycrqy/mquXz4PYWyD3FqeH5W2iogTcMld/0hMB?=
 =?us-ascii?Q?xW23mvwBcJycTX9EHNRiHYC5Gx9GB2cAvX1RQZhU12aYBdZFGGsaToJIf2EU?=
 =?us-ascii?Q?SGbXKJcug65BkJzbH9tc6gRWCm+ffnxS9IMQCHjcsZTJ72+tsGA+Ec1+W3Kv?=
 =?us-ascii?Q?UED0B9F+Xt+iS4fqF37XXl5W0sfMqHMITGj0SaDqj79s725TcW5MB8AhEtur?=
 =?us-ascii?Q?/qxwiCQecU7MFU3H1XQdZyg3CoG+kLm8U7Pm5qw7d1m11a/S6DhjwWCzG7my?=
 =?us-ascii?Q?tW3sv9VvI6vrsxUekVxSKHfS1+T5PbcwFuhuLSsbyyFUQhAMWrMz8Yc4xhZy?=
 =?us-ascii?Q?MXU3Wr+MfbGVu3C19nuMbn7aVnbwS3423Zhbx5ZY0MAcc2pZYQJSi+lAjCfb?=
 =?us-ascii?Q?ptKj+iTk/dZzcIkmrIozqxGhy4XP+jVUOiyZ6XzlVi8cRSWUUk9UGbHCg0Q9?=
 =?us-ascii?Q?hN0WN7Hvvl66O2QLOLkg8n0L/wv/C2ubY0+96pvDHKKIQuOKaDpZ6JJgzmBy?=
 =?us-ascii?Q?jdXrohhRFfYRbPC8bNV5324E5JJ+gZYOengPj72Vm8qqqfdrnqCGbCliu0t4?=
 =?us-ascii?Q?XhhdhdVX/8qhkoGA9UUbPTeatmtINO/NR5kO76HwlLkyJAFgWPBXJ7bqpuLs?=
 =?us-ascii?Q?DgYSWlkqyc2r10pW+5jC6siQaeE7ptE13/+g9HK3A64KvOuuitd2UPS7YDKC?=
 =?us-ascii?Q?0s5vpi+xP4jvWZvyzuWCvmDfBH4cC5UVtTcX0NXGeqj1OpI0+ZLqxviODOuf?=
 =?us-ascii?Q?7JaApFmfeCwhWC91vYRYvMvZYp9tpIiSiHzo4dFFuRyHws8BG5GCbp2qjZwl?=
 =?us-ascii?Q?lopNvqTBHQ9AzsXthEdkxT6yz3ESxWyq15iXYFo70ElEHKrcfLm+QiNZGdxO?=
 =?us-ascii?Q?5BJF9obL30ZsuDcRJ15GP/J+Qn9ZeJkqF6/1yTWUvqTgykV2yA8pBf+J6MI5?=
 =?us-ascii?Q?uvXNNLPEuVcS5/KhS0/xz7D2tl/rkndnwM4CzOMcpdk9DYbR3oMObLpKOt6L?=
 =?us-ascii?Q?LV8RKQO3lCPT5UUTHegkOGcOcIkZWYYB8KlXzV+iPWSu+57RYmgVooACliBK?=
 =?us-ascii?Q?RJgxBFsjXps7MdaVcG4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b86e5b-abb1-4896-4091-08de067a0178
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 14:50:21.3468 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Im2wnr/RgvFeH3dHxv35b6C28J5ZpG/Ul9DLewO7zAcAz8hopfScSJ8GRj6iy8K1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Will it be better to handle at a single place?

Like :
        If (!xcc_mask)
                xcc_mask =3D 1;
        if (!sdma_mask)
                sdma_mask =3D MASK(sdma.num_instances)
Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Saturday, September 27, 2025 4:36 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; StDenis, Tom <Tom.StDen=
is@amd.com>
Subject: [PATCH] drm/amdgpu: fix handling of harvesting for ip_discovery fi=
rmware

Chips which use the IP discovery firmware loaded by the driver reported inc=
orrect harvesting information in the ip discovery table in sysfs because th=
e driver only uses the ip discovery firmware for populating sysfs and not f=
or direct parsing for the driver itself as such, the fields that are used t=
o print the harvesting info in sysfs report incorrect data for some IPs.  P=
opulate the relevant fields for this case as well.

Fixes: 514678da56da ("drm/amdgpu/discovery: fix fw based ip discovery")
Cc: Tom St Denis <tom.stdenis@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 73401f0aeb346..dd7b2b796427c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1033,7 +1033,9 @@ static uint8_t amdgpu_discovery_get_harvest_info(stru=
ct amdgpu_device *adev,
        /* Until a uniform way is figured, get mask based on hwid */
        switch (hw_id) {
        case VCN_HWID:
-               harvest =3D ((1 << inst) & adev->vcn.inst_mask) =3D=3D 0;
+               /* VCN vs UVD+VCE */
+               if (!amdgpu_ip_version(adev, VCE_HWIP, 0))
+                       harvest =3D ((1 << inst) & adev->vcn.inst_mask) =3D=
=3D 0;
                break;
        case DMU_HWID:
                if (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK) @@ -25=
65,7 +2567,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *ad=
ev)
                amdgpu_discovery_init(adev);
                vega10_reg_base_init(adev);
                adev->sdma.num_instances =3D 2;
+               adev->sdma.sdma_mask =3D 3;
                adev->gmc.num_umc =3D 4;
+               adev->gfx.xcc_mask =3D 1;
                adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 0, 0);
                adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 0, 0);
                adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 0, 0); =
@@ -2592,7 +2596,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)
                amdgpu_discovery_init(adev);
                vega10_reg_base_init(adev);
                adev->sdma.num_instances =3D 2;
+               adev->sdma.sdma_mask =3D 3;
                adev->gmc.num_umc =3D 4;
+               adev->gfx.xcc_mask =3D 1;
                adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 3, 0);
                adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 3, 0);
                adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 0, 1); =
@@ -2619,8 +2625,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_dev=
ice *adev)
                amdgpu_discovery_init(adev);
                vega10_reg_base_init(adev);
                adev->sdma.num_instances =3D 1;
+               adev->sdma.sdma_mask =3D 1;
                adev->vcn.num_vcn_inst =3D 1;
                adev->gmc.num_umc =3D 2;
+               adev->gfx.xcc_mask =3D 1;
                if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
                        adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, =
2, 0);
                        adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, =
2, 0); @@ -2665,7 +2673,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdg=
pu_device *adev)
                amdgpu_discovery_init(adev);
                vega20_reg_base_init(adev);
                adev->sdma.num_instances =3D 2;
+               adev->sdma.sdma_mask =3D 3;
                adev->gmc.num_umc =3D 8;
+               adev->gfx.xcc_mask =3D 1;
                adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 4, 0);
                adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 4, 0);
                adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 2, 0); =
@@ -2693,8 +2703,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_dev=
ice *adev)
                amdgpu_discovery_init(adev);
                arct_reg_base_init(adev);
                adev->sdma.num_instances =3D 8;
+               adev->sdma.sdma_mask =3D 0xff;
                adev->vcn.num_vcn_inst =3D 2;
                adev->gmc.num_umc =3D 8;
+               adev->gfx.xcc_mask =3D 1;
                adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 4, 1);
                adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 4, 1);
                adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 2, 1); =
@@ -2726,8 +2738,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_dev=
ice *adev)
                amdgpu_discovery_init(adev);
                aldebaran_reg_base_init(adev);
                adev->sdma.num_instances =3D 5;
+               adev->sdma.sdma_mask =3D 0x1f;
                adev->vcn.num_vcn_inst =3D 2;
                adev->gmc.num_umc =3D 4;
+               adev->gfx.xcc_mask =3D 1;
                adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(9, 4, 2);
                adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(9, 4, 2);
                adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(4, 4, 0); =
@@ -2762,6 +2776,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_devi=
ce *adev)
                } else {
                        cyan_skillfish_reg_base_init(adev);
                        adev->sdma.num_instances =3D 2;
+                       adev->sdma.sdma_mask =3D 3;
+                       adev->gfx.xcc_mask =3D 1;
                        adev->ip_versions[MMHUB_HWIP][0] =3D IP_VERSION(2, =
0, 3);
                        adev->ip_versions[ATHUB_HWIP][0] =3D IP_VERSION(2, =
0, 3);
                        adev->ip_versions[OSSSYS_HWIP][0] =3D IP_VERSION(5,=
 0, 1);
--
2.51.0

