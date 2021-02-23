Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3019BC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 02:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D360764E12
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 02:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D360764E12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF996E81A;
	Tue, 23 Feb 2021 02:03:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 010746E81A
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 02:03:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMXvn2y+e90PAOYpfIaEHtPEyJFto0pAWmWODyPdEl3fwphdjJ0bdzvfh2I3aL4xBJ5jjWZ23z2wpoaosNTDJ8vgmWxPgjJWSWJp0XC7WkDgPBSpBys2fnJpPX5D0bKhsxq0+r8zqnuETfhhushYgTbDkh108kcGenWbuRJX9sVOKbWbUCuwY75cKpuJi+AeAF3bzyqv9zdjDZnjz/gAUcIDOTXz8JMSOeKyupydJLEe3P2p1enJ1Iqu/Ume4hKq1zvoTFcchDDe9KIKwyAkFfPjlsClRkJfLdoPcVzJlEAz9YJIrj1fXVoh4KL9/v25RPVpHY5qDp+CkLQ0cP+n7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrJcJ3dJo0l6qCSJeueFNUBrykuycHYx/NqgYwERdkU=;
 b=FiyVEGd8BWwylFQatVc7uMy3X4BDZJMXNi6NqW6XCprpqmA04m7UZ2gb1OaQ4PQv6iEHvMHYboK265k4HMM6GprQD5Y4xNaIRDm4IER9TveHGrddrMNzlOetfIuK+BcbiJ0irUoEBPMDY0DRLToZVi9NVmPvSc/tvuTCFBqYcS41yanMUsDSgA3PA1UtH7Qjf4MlY7ueN2/4z/0JJM5WLWjCPJ0x8+haShlgvxfHwEtxi45A4jFAb4H4qPOrYHlZhsokNFFlU9ouhdG6NNGV2EylzW35bkzJZf7YruiTRMgV/hPp+Md/cVIVhHIzYOMGXyDAvpa8kA3RAK9vHijfBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrJcJ3dJo0l6qCSJeueFNUBrykuycHYx/NqgYwERdkU=;
 b=khj8ASTlhLPusXjVEhWUq1bvLYyApG9ZvTJaj0hyR6GnWxWlE2Im/zazDEvODN3+n6R46TFJoiZul1IekaEMoV+l98rBBRvywF+qKJVMRA/u4uVq3l7opXXFJGv+atVz25Vwg51hbGXrUrPZHY3LsDzmf+eoN5u069EpKQrOkiM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.31; Tue, 23 Feb 2021 02:03:37 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::11e6:53ff:8e98:31f0%3]) with mapi id 15.20.3868.032; Tue, 23 Feb 2021
 02:03:37 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/2] drm/amd/pm: optimize the link width/speed retrieving
Thread-Topic: [PATCH 2/2] drm/amd/pm: optimize the link width/speed retrieving
Thread-Index: AQHXCM+9JbU6COODvU6W9iPxMDFTlqpktxeAgABGiUA=
Date: Tue, 23 Feb 2021 02:03:36 +0000
Message-ID: <DM6PR12MB2619B7625866332A0E44EB4AE4809@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210222040329.1280956-1-evan.quan@amd.com>
 <20210222040329.1280956-2-evan.quan@amd.com>
 <CADnq5_N0=a_5wd1aLhvMPeX2_SnyTvA3+7tyt14Bx8mRo3-6PA@mail.gmail.com>
In-Reply-To: <CADnq5_N0=a_5wd1aLhvMPeX2_SnyTvA3+7tyt14Bx8mRo3-6PA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-23T02:03:26Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=885e801e-54cb-4037-9c09-4e7c61c4e725;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09e2e3ac-bc8a-4cb8-3a05-08d8d79f3b83
x-ms-traffictypediagnostic: DM6PR12MB2988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2988C0B8E5D1541F09714B6DE4809@DM6PR12MB2988.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JY37F7l2+rJvF2egNdajhr+3sIozkinOSuKYJ4PE7zr7RW5F2P8x6Or9ZbPLNXzjCDDNOP5C6iOrbwr08ONIHKq02FV1iVTOeRhlRKWIb378/bOlyzKOgTGb0QXfLUNmrWhBxOl2tS4wQnGUUpUy4A/F/v0VleUjvi1iwLJaNXFHeZ2Nyw23q8UpGe206SP9nkvb55HqogreRr70k3gWV8Bs0f7w4My3FxeAFiV8fu7nPYAIWFlejwuV9U6ylvp/qMm731j5OF1HnOFEAbGLlz/ltDjMf93LofBBLZxLhGP2oso49GV6xYuxAl6EMbCgIR5Jy+Vg0NDkRUqnEi1f3Gi3h+5gIQzzA+R02GkMQ/NvNLJy0mttYzCZv2cZH2jHjG5ft89EIiDd2PrkqAQa5WQ08F98nPLx+VHEV/Nvjn2uVN9A66evkokI+jZCp9alK7UjURBsUC11AtR2qYvOauY+B2y02xRRNW/v4oNTdZPOQd74A6F3d66KNcun40t53qWkmsHVpyU9MaoH7Z68oC19p54CqqpB/qPhNTDpW0mTjyoiMY83bo8DDQPozJ/0hOb00V2BWfBUBwoRVq912UU9QdXM9Bqr/ZayV0iA0ow=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(4326008)(7696005)(55016002)(6916009)(9686003)(6506007)(66556008)(966005)(33656002)(52536014)(2906002)(86362001)(8676002)(71200400001)(76116006)(8936002)(64756008)(66446008)(54906003)(5660300002)(316002)(45080400002)(66946007)(186003)(83380400001)(26005)(478600001)(53546011)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mSwbHRbCMrGwtihNDYGOwb+ZOO6WQEY7Aw3IAEJfhcealyeJc7ViyARKM/Og?=
 =?us-ascii?Q?6VAQEHGcQVNTfcYgdSKETSfRkOGzcgci1evRVF3AWFv66nTxwAo89HEzAtWG?=
 =?us-ascii?Q?sxiyyeZUta/MfLHsTzXcF/c4CNJdYYEEYygmsojKLgABaB8Yh7tFyDnQ60MC?=
 =?us-ascii?Q?RwmQxfJE2ZirfaVwswT5QJ6OhXs6p92TSQ4262sj/JIg9jd9jEXdl4HTAgJi?=
 =?us-ascii?Q?EiQ2gDGaWfTcT13CkKtQoh0AoEiOedL/HFJyD6dFxZPoOwlambKkk5Vfsyw4?=
 =?us-ascii?Q?GbegqPY42rlZxlNKqpYLNzzC3ZiBFYO8PViKfOs9Uq+DakjuIiRMpFZwaaQ5?=
 =?us-ascii?Q?IcKot+hpR/NPZPsZcZfeUtTK+EaEWt8eWFeffDHWu1jvtW7dfk9tn7WJYQAk?=
 =?us-ascii?Q?tfS1yngVW2urxy2riUBHNjIPkn0zYdB6cNO3tFZ7VRzAN5+MkhSdp66p+5fp?=
 =?us-ascii?Q?z4XHH6Lwt6Iuz7GGwCdG5OjQgQwmKpr8/v/TE/nhxG2nHHAiU/RZrjDW6wN8?=
 =?us-ascii?Q?sF4ynZOFOZLrC1CpsVQK4OP59zDnXNMAnfs+pIPjQAdw6bFEae6NslVsv2c5?=
 =?us-ascii?Q?L986gTRWv2rVCkA6M2Ojvsou6+8ZgoeQ0ghKZqKLqjj4ZJ9jtYhPGFQOWg+H?=
 =?us-ascii?Q?dOIBKp662AMpoBjppToYJ3Iv7Grn2YJajhJQOEr9H29KTrCcqsl2GFy1Pd4L?=
 =?us-ascii?Q?IaitmEHFlGQagCAJLuJqBwZsirf/F7Hnd5kg8kNM3FzYv4Bo10ftFqd2Pe+7?=
 =?us-ascii?Q?eOrK9pKYY4BuAJcLQ7hcXkoWsAb/AZ3/t5hhDF/4CflpfAhlrNZifnz0XWmb?=
 =?us-ascii?Q?a/9zadNL0aKhewr4X2BYFoBr5K3ZWteWymGWNv3ekceGZW1w0uJf89LbBVI9?=
 =?us-ascii?Q?WpiSrXTWMVC3ue0oxLiHOZyrgDCaSi+SLDsjhQiwCFy69pCQxp8cN6CtfTEN?=
 =?us-ascii?Q?g8KTxW1v/UG2yTcvOnT43kzl/pgWdeaMMTjRSh6jknwNd05o/r3Rs7Nf1n2l?=
 =?us-ascii?Q?4n8SGHWYxopDxIuaQnolrMA8FvnP0XaZtkLX7sFNI4W1414ij0zPSCpTKZr+?=
 =?us-ascii?Q?nOSgwuxaF2N6HyoHppHYlVf8jqvBH7kj9Vkwb2Q0aI6blEtinOhfum8h0xGq?=
 =?us-ascii?Q?XKiSISxMUjYVPaJwUfagej9ckA4S3nSeYuC1F4GI63r4uY/Ef28wSD1OhKmJ?=
 =?us-ascii?Q?JKPRcaBZvVmo3QgO4GON1mvgCtsw15I8e/uMatp2tw7kll+R0DmYhvO0nJe3?=
 =?us-ascii?Q?/43ef87o2C/VA06pFffFiNOaL2qTefxBe6t6pV6PDelaVc9gBPt2Z2+pdDDe?=
 =?us-ascii?Q?cqo9BDWYbCmW6xes9NAVbFYy?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e2e3ac-bc8a-4cb8-3a05-08d8d79f3b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 02:03:36.9723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVrgaAViAX7V89Bo38k7/ThUBGILJr8FT9TTsBaYnrPjztUn/lK7T3SESrswyggX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

PMFW of Arcturus does not expose us those information.
So, we have to stick to current implementation(smu_v11_0_get_current_pcie_link_width/speed) for Arcturus.

Regards
Evan
-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Tuesday, February 23, 2021 5:48 AM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: optimize the link width/speed retrieving

On Sun, Feb 21, 2021 at 11:04 PM Evan Quan <evan.quan@amd.com> wrote:
>
> By using the information provided by PMFW when available.
>
> Change-Id: I1afec4cd07ac9608861ee07c449e320e3f36a932
> Signed-off-by: Evan Quan <evan.quan@amd.com>

What about arcturus?
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 17 ++++++++++----
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 22 +++++++++++++++----
>  2 files changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c 
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 29e04f33f276..7fe2876c99fe 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -72,6 +72,8 @@
>
>  #define SMU_11_0_GFX_BUSY_THRESHOLD 15
>
> +static uint16_t link_speed[] = {25, 50, 80, 160};
> +
>  static struct cmn2asic_msg_mapping navi10_message_map[SMU_MSG_MAX_COUNT] = {
>         MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,                  1),
>         MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,                1),
> @@ -2391,10 +2393,17 @@ static ssize_t navi10_get_gpu_metrics(struct 
> smu_context *smu,
>
>         gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
>
> -       gpu_metrics->pcie_link_width =
> -                       smu_v11_0_get_current_pcie_link_width(smu);
> -       gpu_metrics->pcie_link_speed =
> -                       smu_v11_0_get_current_pcie_link_speed(smu);
> +       if (((adev->asic_type == CHIP_NAVI14) && smu_version > 0x00351F00) ||
> +             ((adev->asic_type == CHIP_NAVI12) && smu_version > 0x00341C00) ||
> +             ((adev->asic_type == CHIP_NAVI10) && smu_version > 0x002A3B00)) {
> +               gpu_metrics->pcie_link_width = (uint16_t)metrics.PcieWidth;
> +               gpu_metrics->pcie_link_speed = link_speed[metrics.PcieRate];
> +       } else {
> +               gpu_metrics->pcie_link_width =
> +                               smu_v11_0_get_current_pcie_link_width(smu);
> +               gpu_metrics->pcie_link_speed =
> +                               smu_v11_0_get_current_pcie_link_speed(smu);
> +       }
>
>         gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c 
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index e74299da1739..6fd95764c952 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -73,6 +73,8 @@
>
>  #define SMU_11_0_7_GFX_BUSY_THRESHOLD 15
>
> +static uint16_t link_speed[] = {25, 50, 80, 160};
> +
>  static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT] = {
>         MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,                 1),
>         MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,               1),
> @@ -3124,6 +3126,8 @@ static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>         SmuMetricsExternal_t metrics_external;
>         SmuMetrics_t *metrics =
>                 &(metrics_external.SmuMetrics);
> +       struct amdgpu_device *adev = smu->adev;
> +       uint32_t smu_version;
>         int ret = 0;
>
>         ret = smu_cmn_get_metrics_table(smu, @@ -3170,10 +3174,20 @@ 
> static ssize_t sienna_cichlid_get_gpu_metrics(struct smu_context *smu,
>
>         gpu_metrics->current_fan_speed = metrics->CurrFanSpeed;
>
> -       gpu_metrics->pcie_link_width =
> -                       smu_v11_0_get_current_pcie_link_width(smu);
> -       gpu_metrics->pcie_link_speed =
> -                       smu_v11_0_get_current_pcie_link_speed(smu);
> +       ret = smu_cmn_get_smc_version(smu, NULL, &smu_version);
> +       if (ret)
> +               return ret;
> +
> +       if (((adev->asic_type == CHIP_SIENNA_CICHLID) && smu_version > 0x003A1E00) ||
> +             ((adev->asic_type == CHIP_NAVY_FLOUNDER) && smu_version > 0x00410400)) {
> +               gpu_metrics->pcie_link_width = (uint16_t)metrics->PcieWidth;
> +               gpu_metrics->pcie_link_speed = link_speed[metrics->PcieRate];
> +       } else {
> +               gpu_metrics->pcie_link_width =
> +                               smu_v11_0_get_current_pcie_link_width(smu);
> +               gpu_metrics->pcie_link_speed =
> +                               smu_v11_0_get_current_pcie_link_speed(smu);
> +       }
>
>         gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>
> --
> 2.29.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cev
> an.quan%40amd.com%7Cdbf961954f9c4ef66b1308d8d77b8592%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637496272809706224%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 1000&amp;sdata=29zqelJSqHdhHVMPUqag5i1Sv9mrUhHSGysA52YYQXs%3D&amp;rese
> rved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
