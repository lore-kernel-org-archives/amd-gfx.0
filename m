Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6F5C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 23:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80C7D10E2A1;
	Tue, 10 Jan 2023 23:06:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29D1F10E2A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 23:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEXLXA4Xx7cI/ITlSfLCYwTa/JCUNgKyRk9e9BJEgol7UBc1aFWqpjOrvrLhmMkP9IbOzV6blmHC4Sfiyate9Kuu0i13AgQNlD504xLrscL7jVuQEC76zToPu6gPefepYj9yHRJ4lIoYf6eN+ghHLeuT7RJPiedoDtsNvmAZeNeZQRCFEOIv1CwtV/yHqjVC8KhPIc3VjPaViGe4CsCQrGnz4vAANtEuyjXTNtQcpjIxZ+xFVUwQ5svdYZMJMcFRG4tIZbbi1u+22k49/ldQjk9EOgmiVbiUUEuDqp7XhNxb6YAqslXgBNjKUS/xrzG3ZhAgKYXPNvp+HUkNI5bK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQnUOy+QUtLdXAjvvVcvHHlO5hbOfigxcMQifo2pjBg=;
 b=B+cOKzKkUJKCs1UwOU3pUQWeB7cQI7SgytdiBny2qo6FVrUe/t01/+BOfV9fvNYMEcePBTY9DwSwmmKbp0Gtb1OXMr3yFg5IJgI8wRhhPr8ZSp8YUjVzlJO1RcfOihWMGY4wgvVfnvYN2DTW/hLklUXTQSn+/sUiruD1RQJ3sDRnFeSGG6zpjtRPaDwBxtbB+6YaEtLu1kf0MONvbw+DvWcuO9fgKluVY7z4nbrPc5hp2IC27BQbt7ODdDTmHLoiur9MnX4D6I4x4UblwzMhXIvNIcoyADVvWgl9UxjW98BeSWQEE6HY2qOgb8hyklLSXnzjJG1xrRrOhwdLW4NIAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQnUOy+QUtLdXAjvvVcvHHlO5hbOfigxcMQifo2pjBg=;
 b=hpHLLHL13MBUq503LqqbpGqJIKQRr6pBfbCrEkn9uStyy3rz72uHdIn+zAlXfd0m/OxxvPBjBhh14zzGA5dG9H4ZoN3spA0MiIBzsp0dlsEzTUgLzKJ00DFD7gc2DsbnoXF6tSACurIxtypBnJ5vlD6CmX7fo/t+Y7iwwnJAl5c=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 23:06:17 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::3abd:f044:1e8e:4261]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::3abd:f044:1e8e:4261%6]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 23:06:17 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vcn4: add missing encoder cap
Thread-Topic: [PATCH] drm/amdgpu/vcn4: add missing encoder cap
Thread-Index: AQHZJUWup8yEkn4ZC02UGsMT4X2ZEq6YRZ4w
Date: Tue, 10 Jan 2023 23:06:17 +0000
Message-ID: <DM8PR12MB5399ED8251EFDC7AE719F903E5FF9@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20230110224805.2381416-1-alexander.deucher@amd.com>
In-Reply-To: <20230110224805.2381416-1-alexander.deucher@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=09e68169-ecac-46d6-b49a-7d43f4ce7654;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-10T23:05:50Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|BL0PR12MB5506:EE_
x-ms-office365-filtering-correlation-id: 6834c89b-481d-4ab3-ce47-08daf35f47be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5OW2jKR6gZ84gxs5+MoCAk5gBk/RpPW9I1hJviojm9hB2wW8xEk/1YU6q54UbvkCffylo+5fpGTWCCBMwrUVHF0jDnFpt2NIob7+ibQNKJ5l2cKumfv73Uvfp3SDfl0+Ui/1pKp3GrL/KQOsnztyNsJUL6bxNFYh0LJDCMB2GHA6YZd9oNc4nxAHimsfXUvVCOu1AiqiKwviaEQxgVANzXinPkmmTQvOzoAYwNkvnUB3IsvSjUc43A8vRRrMGsEEuL8G5cWOQP/5P0ym4hicnMZCqBq6Z86s2SJZ0UFc0720eiA8JozlfXCxUwMjt5aUcgwbF1BHoxvMN1t6SYfM1j8TrwFCYONiOQFh0huGdAHt9DW6GHjXkqKsvseJ8iPvovILdh4xSjiiw5uFmbPoNYIalFO+wOcFzNWDk+pkwGps7NarTa8Eos5bGBGF8B2so+oc/fPeRj88jJp2KdEgiqDGM7fkC8QBbvpaP6QtapqXqGhpylWEhBeoUl9B8elQTfV9Fx6l2KM3bZ0bia5y2mpNmPh2STs4D1OjaeS17jtQDExc8LyyWH2cBaJ1MjtKDuEQFsKJEwpdfxnzlN08dksTQQthXunETMjUs6FNOPP/DcycihdsnZ3Kj5lLPsfb6+eHLq0ZhpiCfrp7BjuHkgER/2TP1m/i89SmhbV32g/v3t46E/kFFrSU97EoFDgU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199015)(33656002)(2906002)(8936002)(5660300002)(52536014)(41300700001)(83380400001)(122000001)(110136005)(66946007)(71200400001)(7696005)(76116006)(66556008)(86362001)(38070700005)(8676002)(6506007)(38100700002)(53546011)(55016003)(186003)(478600001)(316002)(4326008)(26005)(66446008)(64756008)(9686003)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UjtNW/BBbNYeq1dPHwZ6VfJ0/rDojiqarLHYzgHeMk/UNbUWLIggqmNY6Hoy?=
 =?us-ascii?Q?DrgU+0obtiULz1VYinkGS7tuzOQYh3/pumr8J6cf9LtQafUoxO7k9sW8gcBI?=
 =?us-ascii?Q?iPjygJAyH+aReYYW+rkLLjURo9PDQrDUllDbFXvLVYuOpMUjphfEqJGWa1D3?=
 =?us-ascii?Q?l4e89VUBkCFEshQnxdFo5viZigk4zTrzb/gbiLfngS/ZWa4PL9RhhEhFHA/2?=
 =?us-ascii?Q?sKGuRACoFeU8XIlJAPZoY2QeRswYeYLw2NK5VVYfs7WGJkPB0jGHVbhLGo3c?=
 =?us-ascii?Q?I6mbylgHKMK7X3XNvmlXYPLY2AAcJobNQdmM9ylRcK3xH6byG9mQAV/HhurG?=
 =?us-ascii?Q?oeMhlsYy3qlhNwQeXYyfYTGUVH5X28vGXREYB4rvfHVV22664rtBBFemicIV?=
 =?us-ascii?Q?bk3OPr8Bi928pIe9et2o5dgQREtfSLG9mNKMKAjWmiKXiIgaDHmRYeBKVckr?=
 =?us-ascii?Q?UHVhaIt+3BQy6jGUczEXIstykhBHGM1Y5gKfnYR061h2IouGWt5NTw/r83QY?=
 =?us-ascii?Q?IdSm22oEbbDJtMWWWiLZccq2HW9ab6DL8oxRdoxD3OjtLVYF2QpsPZksfYYa?=
 =?us-ascii?Q?BwZDGuB/tj8f57l6k8oK+R/TOMx8ijF/XT6fzP1qLpkPd+evTZhgmkK3kutd?=
 =?us-ascii?Q?Q60H/0fWCFLRqrMxlG6FMtQKp52/DzDGbaT+0gDmsJwqXDmcSfdXWjJLmuLq?=
 =?us-ascii?Q?VtMctNGuQ5DgKbS/j4DmodnPAuzdn5t4QZXXomg81n4zOf3sKIkKQlvaxRZZ?=
 =?us-ascii?Q?h0qcJyCHL6L1jkkHPfSzu4G9zgDAnxEwrPKlWsR5eT1qREeiMdPmI5/uhkvn?=
 =?us-ascii?Q?00XiYT+e/Q6HY0D0i2Cl6dDBdJ60h5bVn9mX3zn76tn3dFNR2yRLobX5awim?=
 =?us-ascii?Q?hW1tn7ON1alyGeLIy9qqjeHLNULUr4T0H9StFY5U6gOKgCLpYZjsF4QdXUHX?=
 =?us-ascii?Q?KYDR0/HMWBdM8VJvV6aXRpbFysX3dQVGboyAmeSGmK2Mq8Fhe09X1GGQf1IH?=
 =?us-ascii?Q?D1Nac5ebCBVJt3DCuYlwZyirhhW1ENlGSs0pzluNk1WS/8/4sggp7/V4gLgC?=
 =?us-ascii?Q?/knsfnfLcQUXrKfIePirKHi/xHjjTseNO3vku53Z+jbA5yAOWbRBLSdnXgm+?=
 =?us-ascii?Q?FX3aJrVbLkIYKCf7CfkxwdEExFPgnVh7yrXmx6vdjPdv1/8Ac/MYn7DGKcJs?=
 =?us-ascii?Q?Zj9yVPoFbsutPytH7xjkPiWTMhkyFH8tqZ1X46eKWX5qAMnYePAOB1AJMbG2?=
 =?us-ascii?Q?wP6bjyvlByoZF+fjLU74R41DDuLgQph/dDbLGNfju/vYCGh/7o4kIBYY0a6s?=
 =?us-ascii?Q?Ijh5CZSgb6rlvng08oTCHbMCm4/aBvTrFHhqk4iMGHNMqiQw7WIitz6LDqGy?=
 =?us-ascii?Q?ugawvtlJED7bvSRsKOGKe+0ulsFTzWvmeblsE/Llb6vQae6IvwlkDWmX6qNg?=
 =?us-ascii?Q?DDM+bUKT31SsAtb2UDBW7gB8YyP/RbdJCR369oMnKILktnxsLkoKGaUAaBbj?=
 =?us-ascii?Q?Q8R3L/1gfuGjmo40HxGlNeU7kcQCr24d7rFqS3Y5jc37lz2vNEQGSew4GpBf?=
 =?us-ascii?Q?K26DkEtHsxCXx4owhZ8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6834c89b-481d-4ab3-ce47-08daf35f47be
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 23:06:17.7319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irQpyttF7r+u+Svk2rpuL27ldnM1zqIy216JpFF07Rw80KC/UGqeRjcGLLktS/V/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Leo Liu <leo.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: January 10, 2023 5:48 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/vcn4: add missing encoder cap

VCN4.x supports AV1 encode.

Fixes: 9ac0edaa0f8323 ("drm/amdgpu: add vcn_4_0_0 video codec query")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 5562670b7b52..bea6b499568a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -52,6 +52,7 @@ static const struct amdgpu_video_codec_info vcn_4_0_0_vid=
eo_codecs_encode_array[
 {
        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096,=
 2304, 0)},
        {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 2304=
, 0)},
+       {codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_AV1, 8192, 4352,=
 0)},
 };

 static const struct amdgpu_video_codecs vcn_4_0_0_video_codecs_encode =3D
--
2.39.0

