Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4138DC47076
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A1D2611AB
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1D2611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4DD6E53E;
	Fri, 21 May 2021 17:39:53 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2055.outbound.protection.outlook.com [40.107.101.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 073506E53E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 17:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J79BipJd9q+NIZWjRth2OSImzd0LpHvWRskecouJfS8WyUjMT0pyOQOaUGYSDvLCdZdrE7kSvt1/BEo+LpYWy8CBev691CkmYqQrBfZUJWVi36OZT45j+Y4PLhj3fMKsrMOoEJ8+C158/y6v88SRRfV2H1UWvrl4mj0A2+0uBbvXFV2r0Vm8GbmuxTx5K8RtuIvg3mQZwtYauX5+pR4ILz7h+/VErnNHRbVx1ONlsVSQJLcCRPyR4DK4mF0HpAva855MfpXyHrJSbDzv6Ub95v6LOZZA6NAemiHIRQfbYonvEfF9A1G7ugeYSAag+8x2ZYSuVCkcJZTBnvFEIGLC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZutARR02mckg5ygoO83H0f6wQ17Chd03d54EM1Xy+c=;
 b=HvmQ/w+NXcySOf4nJ/T7xI0brCfBVu1xXV3xAdtlxcu07wZeyVub1QRZsRrndpaMnRMt9KH+7sZYKkhbPQvJrFrMMTzDMLKRLtMDyQ9q3arbyD9I4GGmzaweYV4nQx9ESmkz+hLPmN5xMsrZDcDs9uo+RiQbSv7tTgcl35yiHjlg+V6ZvRyW7foiDDx7DWFCzrPszHCMks/RRO0RjgxRGxs0ZK+0wFsr2Lm03h7mAIs48DpCel63w5qIBlKfMHGfgIA1v6F/ZmxNPSsu4YlZnHifU5mShIu2GL91tjKliDGZX5cmKhSkHjkhdDYTOSiAy0iJUc72LDcFOSHhbrubKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZutARR02mckg5ygoO83H0f6wQ17Chd03d54EM1Xy+c=;
 b=u2Y78eE1FTvYsgAxFs/vfZZD6dqG7/KZCCAZ7+QctzsZzYNhP7PbjyjJym3wXGiS0afz7lWetYK1d6vv+T3hI3r6Rc9EFdIuTQLH+x3fNkw13kLpMo16x8aIBGR43RznEudS/k1nTjKJ2WO1lAO527jUa2a53fMnrVmKexRS7c8=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 21 May
 2021 17:39:50 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345%6]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 17:39:50 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation
Thread-Topic: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation
Thread-Index: AQHXTYSqhVvD5xR5YU6jGKA1xw/dbKrt/8GAgAAz2AA=
Date: Fri, 21 May 2021 17:39:49 +0000
Message-ID: <DM6PR12MB3067FD5B64C665F5E264F6EA8A299@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20210520142930.8369-1-Graham.Sider@amd.com>
 <20210520142930.8369-2-Graham.Sider@amd.com>
 <CADnq5_MnENbvZJTAr8nfmvENZoeZaWxpU=zaeGeUasgz5TfUFA@mail.gmail.com>
In-Reply-To: <CADnq5_MnENbvZJTAr8nfmvENZoeZaWxpU=zaeGeUasgz5TfUFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [72.141.145.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9515d698-246c-43cd-61ef-08d91c7f6f2d
x-ms-traffictypediagnostic: DM6PR12MB3916:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB39167C384575135E9220773C8A299@DM6PR12MB3916.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v/49B8lwVR2QfO9GESgGz9ZfO8KIKdlQ7VLduW1Vi6uiESYrQNZWabZSt2KswM7sfc+pnq7GYBoPCNxedi7smJYlaKYexKQhTcN+pYagRZNQ71+Y2+6lCtX4ao/I6HJZXlNhshTeUyJk6DYFxH1mRd/4m/UBuoz8HnfSW9YopUwhdPCpIdHptn7gUwLOu7S7z1lAI7ly+KDF0uS1o/DS6jxj0oNzuoBE6N6cQ0WBVJ9ao+ZcDLzeXPXCZdwA97Uoy0E2zvsnlpV4RkEiOXfRxRng4kqKZZsQUHpt+PPo2ueP0pD53u5kcZ0Cj90soNwX7zcc4BJBpKrDnXC59HfD900TJN+/506Nmr8ka9RZOmTyUob73bCfhKvb6PWYmZj10pEEFEtghzL0KhMEW7TXJwK5XvW7l9Rx5S1JYv0lF1QJEMzbR7FT6tjQniKLpAPTtNK7qmfwfOXjGHKe5NGw7h1tzr6yeVDjtvS0Z/pXV08ZO0B5a2s1rvbzusnsv/Q1tNuAVdMVk91yWjPNmM3qETo0788Dk4aJNih9zkeKQ5X5hrgWZ6qPkrDd5iSsv3wsYGU4j1kBDfnATvHqszdlHbXnivfElt4lxbWtVlmlDSADrjqxjCcQoHUgrjJYZml+G/OkBn2CkHBwDVCl+DGXfqjN/xw4xH1u5c5rURBKb5qHw+ZzI3vz+DgTAMrgdhweve86EOVa8j9BgF2+50AFJHAbYjwEuSHobNbDNCGaL+LBUzZSNONcfBsWJ2XSbUU0zV7RLOdGzG0Y7/sROEmFGg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(6916009)(122000001)(26005)(4326008)(966005)(33656002)(86362001)(316002)(186003)(478600001)(53546011)(45080400002)(38100700002)(6506007)(54906003)(66556008)(9686003)(8936002)(52536014)(5660300002)(83380400001)(76116006)(66946007)(71200400001)(55016002)(66476007)(64756008)(66446008)(2906002)(7696005)(8676002)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?csDCXHKxo+MLTA7uyeYaZQH2nNxjDJA7NLUjc+ssgEvGGgWcejSxlQAy6Gwc?=
 =?us-ascii?Q?HSxfyayuCK7Db90CggtQypl1+0f3gPFw1gGE7TcEuYen0BmICsOl960VPBls?=
 =?us-ascii?Q?LdxW4EvGgiQaWUdJJuXY3QmnINcJfvlId4ZouoOskjQ+MYYXPUXZd7vECTWW?=
 =?us-ascii?Q?AVEPdp3jqGTyz8HHicv+3z0DAcATH9z+dVYg0+Gi57Wbn4j0ggPZE+oFsARH?=
 =?us-ascii?Q?IfKTYkxD7gMmGelSeI0bNXAHT8Dkhu8zYS77jowoB4IX97tEz7sEA2qzlI/H?=
 =?us-ascii?Q?IMKjZstjvWkp5cYi4POZg+opFv0yPK7kP3UUDPozPLc1OrHzY8Vviv3mILZg?=
 =?us-ascii?Q?5h0WkN+w4vPyAaoknq8va5D+RVoKr49SyO8ohBSQ9MJUZySrgH7SEbsPTH5Z?=
 =?us-ascii?Q?VQvVWW7NRVQ+Gi8MVu+mOn8G7JILdHzNTqyjKRGD4UQI2AHIiQrCBkJtNf8f?=
 =?us-ascii?Q?+0IU7dwVOPuuoFJSHgcg1YeONP5r45ptZfHWcCN5oEqJMqD3d4AmZ9uTXuXz?=
 =?us-ascii?Q?jBF2IICoq8m+l2g4TNAgam1axxxZPcChLsSZL50VnmwaW/dtLrPHAFX/ZrP5?=
 =?us-ascii?Q?7eFC61RTHtI+vfr19DY9rdmzYcvXgZix88Zq4SHJ1kWaQgO32hjDQ+pH77dP?=
 =?us-ascii?Q?rUjK+f39i5F+AC9oBEbbruQGCaK1gZkUJAVMN8ANQCZEa1mBIM3sbkhEGYbn?=
 =?us-ascii?Q?tPc+A4h25jJ+a0OpbC71L0zp6jIY6y3Uizp6se2mMF2asLmm1gYLek5gO9h0?=
 =?us-ascii?Q?svo534vA0u18gNvZZCLUlAUMDQWuB1ItHQPbmLD59Ok/NFDN7BcAxC9g4TIs?=
 =?us-ascii?Q?sJzC1ronthdL50U1je5JH9ZF077Qcs6AxM9uh+5oPfMoQnRLptLQ3dikX1nY?=
 =?us-ascii?Q?RJzejG9BZitdXZsdxUDNbHgfK9Cbu2tJ6yCvGBcd+DepIU97hAFMQUiXCang?=
 =?us-ascii?Q?jvPotF0oUkTUFHkuruyfVmRFG3Brh9Be8MlYQMVH5KhrtMo9bM9yKILVgSim?=
 =?us-ascii?Q?KH0YsRHEs5CHidIM1EGcsR3fRRhtteIJmQumrMf4Md3zO23NcnVQUwGah/Lk?=
 =?us-ascii?Q?UoBggHoBwJffPpl60So4CEYY3yFokPT7BIde73E13YqgJwhDjLhXG1mCHLIx?=
 =?us-ascii?Q?RPsJDHMZwpvtUXaVStEC5goMqtFdYf+rG6YDYUQkVfF+05Jkdok0Kqe2nUgx?=
 =?us-ascii?Q?HESMoecbTY1Frp56cPo478uoPFqQvhGOkOzM1ienSPazNu2flp4hsnA8Ahg9?=
 =?us-ascii?Q?utWisYxCkLGcCnUsFyp1rufieoHqV/glytTg9FGFfZmHQS0kQs6Ek+L60SvT?=
 =?us-ascii?Q?GAc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9515d698-246c-43cd-61ef-08d91c7f6f2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:39:49.9946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N9U4wMowrR8edzWF+9FGrRIEBBQA4be4HEjkEreABXv4L5VYakZ/9C4RLkN5ZOb793c1mtSyKBMRhAFcrXJGAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3916
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Sakhnovitch,
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

Are you referring to bumping the gpu_metrics_vX_Y version number? Different ASICs are currently using different version numbers already, so I'm not sure how feasible this might be (e.g. arcturus ==  gpu_metrics_v1_1, navi1x == gpu_metrics_v1_3, vangogh == gpu_metrics_v2_1).

Technically speaking no new fields have been added to any of the gpu_metrics versions, just a change in representation in the throttle_status field. Let me know your thoughts on this.

Best,
Graham

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Friday, May 21, 2021 10:27 AM
To: Sider, Graham <Graham.Sider@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: Re: [PATCH 2/6] drm/amd/pm: Add arcturus throttler translation

[CAUTION: External Email]

General comment on the patch series, do you want to bump the metrics table version since the meaning of the throttler status has changed?

Alex

On Thu, May 20, 2021 at 10:30 AM Graham Sider <Graham.Sider@amd.com> wrote:
>
> Perform dependent to independent throttle status translation for 
> arcturus.
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 62 
> ++++++++++++++++---
>  1 file changed, 53 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c 
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 1735a96dd307..7c01c0bf2073 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -540,6 +540,49 @@ static int arcturus_freqs_in_same_level(int32_t frequency1,
>         return (abs(frequency1 - frequency2) <= EPSILON);  }
>
> +static uint32_t arcturus_get_indep_throttler_status(
> +                                       unsigned long 
> +dep_throttler_status) {
> +       unsigned long indep_throttler_status = 0;
> +
> +       __assign_bit(INDEP_THROTTLER_TEMP_EDGE_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_TEMP_EDGE_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_TEMP_HOTSPOT_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_TEMP_HOTSPOT_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_TEMP_MEM_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_TEMP_MEM_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_TEMP_VR_GFX_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_TEMP_VR_GFX_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_TEMP_VR_MEM_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_TEMP_VR_MEM_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_TEMP_VR_SOC_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_TEMP_VR_SOC_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_TDC_GFX_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_TDC_GFX_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_TDC_SOC_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_TDC_SOC_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_PPT0_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_PPT0_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_PPT1_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_PPT1_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_PPT2_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_PPT2_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_PPT3_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_PPT3_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_PPM_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_PPM_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_FIT_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_FIT_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_APCC_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_APCC_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_VRHOT0_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_VRHOT0_BIT, &dep_throttler_status));
> +       __assign_bit(INDEP_THROTTLER_VRHOT1_BIT, &indep_throttler_status,
> +                 test_bit(THROTTLER_VRHOT1_BIT, 
> + &dep_throttler_status));
> +
> +       return (uint32_t)indep_throttler_status; }
> +
>  static int arcturus_get_smu_metrics_data(struct smu_context *smu,
>                                          MetricsMember_t member,
>                                          uint32_t *value) @@ -629,7 
> +672,7 @@ static int arcturus_get_smu_metrics_data(struct smu_context *smu,
>                         SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
>                 break;
>         case METRICS_THROTTLER_STATUS:
> -               *value = metrics->ThrottlerStatus;
> +               *value = 
> + arcturus_get_indep_throttler_status(metrics->ThrottlerStatus);
>                 break;
>         case METRICS_CURR_FANSPEED:
>                 *value = metrics->CurrFanSpeed; @@ -2213,13 +2256,13 
> @@ static const struct throttling_logging_label {
>         uint32_t feature_mask;
>         const char *label;
>  } logging_label[] = {
> -       {(1U << THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
> -       {(1U << THROTTLER_TEMP_MEM_BIT), "HBM"},
> -       {(1U << THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
> -       {(1U << THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
> -       {(1U << THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
> -       {(1U << THROTTLER_VRHOT0_BIT), "VR0 HOT"},
> -       {(1U << THROTTLER_VRHOT1_BIT), "VR1 HOT"},
> +       {(1U << INDEP_THROTTLER_TEMP_HOTSPOT_BIT), "GPU"},
> +       {(1U << INDEP_THROTTLER_TEMP_MEM_BIT), "HBM"},
> +       {(1U << INDEP_THROTTLER_TEMP_VR_GFX_BIT), "VR of GFX rail"},
> +       {(1U << INDEP_THROTTLER_TEMP_VR_MEM_BIT), "VR of HBM rail"},
> +       {(1U << INDEP_THROTTLER_TEMP_VR_SOC_BIT), "VR of SOC rail"},
> +       {(1U << INDEP_THROTTLER_VRHOT0_BIT), "VR0 HOT"},
> +       {(1U << INDEP_THROTTLER_VRHOT1_BIT), "VR1 HOT"},
>  };
>  static void arcturus_log_thermal_throttling_event(struct smu_context 
> *smu)  { @@ -2314,7 +2357,8 @@ static ssize_t 
> arcturus_get_gpu_metrics(struct smu_context *smu,
>         gpu_metrics->current_vclk0 = metrics.CurrClock[PPCLK_VCLK];
>         gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
>
> -       gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +       gpu_metrics->throttle_status =
> +                       
> + arcturus_get_indep_throttler_status(metrics.ThrottlerStatus);
>
>         gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CGr
> aham.Sider%40amd.com%7Ca3ca9a6b0576479e545808d91c648f50%7C3dd8961fe488
> 4e608e11a82d994e183d%7C0%7C0%7C637572040495495758%7CUnknown%7CTWFpbGZs
> b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C1000&amp;sdata=YxUx7BrsQKBauKE3fHpNrkWMAG4dBy11fV9xnJdMHns%3D&amp;r
> eserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
