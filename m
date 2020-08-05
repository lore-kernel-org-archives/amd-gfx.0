Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB98C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 03:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D90207FC
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 03:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rBeOEaLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D90207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5922A6E4BB;
	Wed,  5 Aug 2020 03:14:37 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750048.outbound.protection.outlook.com [40.107.75.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E7E46E4BB
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 03:14:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewhFHoIcTYTY+Y9evVPzXmgs+F9AXVf5CaUsn7qBeSav97LJzzH1OKjrZ9xEpY2ahy4AyiW+YdEAKrGwMNyRBaL05smMaaTXVZA4pUrWlfoY/uiAvwTijYv9jJxtu/XoA8wNQxKNtxppqVlYT+MyqFGfGgwORGVCGvXp2KEvvWSrk6nXouNXM/VwdDmYzonVq8s2fYurTdPNOUXniKFSff17L6490V9orov+pJlzc2o1bBamaCP6XwhSNKsss4XuEBU4wz24Juai6CrbOXS2pTZIk+qsr5q0ICmXGUBWSYT7JCB5cPqtpE1s4x56XS5kT1V1c0MjnhsxnRQUUqc1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AxixGuHITJjrTuJMAUIiv9918MSmNu1X/MwAQSttlI=;
 b=HSlTri2EwfgukdQuLu6cnG9FvrmVwAHkltejtaCOWwlfBW5FVv7yArylZb6OMBpCrS4mP2eEemEuZ+7jnt0UTMGbfxekIbj9yBFzD2oDfPyEHHEZFqBHbunyL0Yy1PCVWBjgqD4KY9LxoV6VQ3XIbkDADwLT+KJgVRwf/HseX8ROnEdwYWHaKPn1m+SEPj2die9FavAbUtr/BV4LDDBLlubM7qoV+oEHMGJOWbomQe0xDtzt2GR24/qW7syaGvAwyY3VGAxPoNoCMMUSYv28mHMl9TEc4W6pbLKKREaSmhBZY0x4ytCQL7ka6v5mkR6cOGkc7VUBA+X73wxHS8dc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AxixGuHITJjrTuJMAUIiv9918MSmNu1X/MwAQSttlI=;
 b=rBeOEaLJ6x+To/v+FoKtvf00yqjOWCwtqAa8oxTKL8PXM0IpBNkxnKJ59t3/9Yq+J7+AWOsKP4DK8MQR+xzVx/SOWwIQABAA1auKb2N5IxX9jeNAcOs0pEo55QzNbaTBufNrzgv1CdLqjs/A4aTdhJfWMMDyuShOnjKyLmRZ0tk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.20; Wed, 5 Aug 2020 03:14:26 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.021; Wed, 5 Aug 2020
 03:14:26 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 17/17] drm/amd/powerplay: add control method to bypass
 metrics cache on Vega12
Thread-Topic: [PATCH 17/17] drm/amd/powerplay: add control method to bypass
 metrics cache on Vega12
Thread-Index: AQHWZuSbT+jxcRCUQkGJZXamRqsyM6kocZyAgABmVpA=
Date: Wed, 5 Aug 2020 03:14:26 +0000
Message-ID: <DM6PR12MB2619E44654B1DFFADCA0D21DE44B0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200731024316.28324-1-evan.quan@amd.com>
 <20200731024316.28324-17-evan.quan@amd.com>
 <CADnq5_N-mcV_d=NcrYUPY8PuPQV23f-mj-gdu-Lf5PLrHgCVKg@mail.gmail.com>
In-Reply-To: <CADnq5_N-mcV_d=NcrYUPY8PuPQV23f-mj-gdu-Lf5PLrHgCVKg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=63663d2a-b756-44a6-81e9-6aee3914a0a1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-05T02:48:16Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c6a03e78-0911-4ea2-cfbe-08d838eda8d5
x-ms-traffictypediagnostic: DM6PR12MB2986:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2986A8FA0A20987D37C7971DE44B0@DM6PR12MB2986.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GlA6mOEDI7RVJ4TlEkPehigywqOuujUfXj5dAoORJmpr8/aLlsXKIo2fmaIKvtwqJI5n8HQaSYFB9Qgnv+eYy+aG24nKVxRwNghxwQk/Dqo3XMWRcBpHitb0P5Bun9FdVntU1oKVEvBfF9bDiK3hnxET3UWplrslZVO2k+a53EEe1WW8n18ZBTVPZV8dQbLkb/uLEDkZJ/nxmpizY4weY+uhKv5/dMiTQEbCYhuGdeDL9TUUHHsbUiefdN1wTqan8MUyyadvoO/Xg8cmzpK4ioGBPy0fVKkCsws0+P4X8UcYeTP45ff5U4D7tYVh0cq/4XOrX8GifC2D0dpw+SELyz1gAd6qdUnVU0OzoedBxsNJd+lSiYr832V+0FqiGbTTuNhppsvtA4df6aul/mMsfw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(478600001)(186003)(26005)(55016002)(9686003)(66556008)(64756008)(966005)(7696005)(6506007)(53546011)(52536014)(66946007)(66446008)(66476007)(71200400001)(76116006)(8936002)(8676002)(86362001)(316002)(45080400002)(4326008)(83080400001)(54906003)(33656002)(83380400001)(5660300002)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: b+ngo3m9o1VK3aGdEHVS3/yNq9qgz8dMBpFAra3C+BnspLMrqDCDka1OkTi5hrVWzbUnxRuUUxW0qYrh/M5TpqHoQTnotHMVThlDCOO6cfcnuIAQxqZFuOENKRmL45n+JxVN1jV4OfN7rqOGWpFCz5Bb5Ta7+VM+nLAlwgwDXaUabtvJDk4lJbnL7jaHG1BZFY5Q/jBZINjaAHlK1CWos+8035FHwYLTrPEaee/sqZTl4G0BEXlEaESra+jvq8SHzZ1pZLlxVXs5r1EDx/4eGvPt/U5kBAA0DPk0TUKuUsnB/e4b9ZUJ+XagdwVKXFFlOU0neUgGQKaYK4XHgCc3N+jKj5LJxZfDOTfP+JT7v0CGEoE8OIkhl7hVhFeqim6c1AAvJnYOfbn0xiCN/rMDRvySKTIe4ML7UyKazg7H/x8pgaqQMrJa9JUbPhazmW70XQltDsJceSD2BjLH+fditZyEwhxxSOTYSIyb+qPTGrnKaMVHsDL9IB52AXWc3CRGOX/AIqIcQNOxxk99yxjPyBymSlTrRlMMnK8BT2WJn4Od0gqi2XGHYy4e2uZVNKbNWIoTV7+q3kK7eGfS2O52BRdWvvXdSP4ZjWRVBW/Cz2JgN7eCqH/ibP6jDj+y6sdY3QVdiCC5gtpybbe0QluY6w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a03e78-0911-4ea2-cfbe-08d838eda8d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 03:14:26.3534 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r2mbFAuTbTF4C7RDYx7hf2HdUfCxWb06hUN4LblT8mgiolySmsf7W3jVT+f5B6Ek
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Das, Nirmoy" <Nirmoy.Das@amd.com>,
 "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

The cache is useful for the case like sysfs "amdgpu_pm_info". Which inquires many metrics data in a very short period.
Without the cache, there will be multiple table transfers triggered(unnecessary as the PMFW sample interval is 1ms).

The unreasonable setting in our driver is the cache interval. For this special ASIC(vega12), 0.5S is used which is too big I think.
It should not be bigger than the PMFW sample internal setting(1ms). Otherwise we may get outdated data.

BR
Evan
-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Wednesday, August 5, 2020 4:42 AM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
Subject: Re: [PATCH 17/17] drm/amd/powerplay: add control method to bypass metrics cache on Vega12

Do we want the metrics cache at all? I can see arguments both ways.
Patches 12-17 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jul 30, 2020 at 10:45 PM Evan Quan <evan.quan@amd.com> wrote:
>
> As for the gpu metric export, metrics cache makes no sense. It's up to
> user to decide how often the metrics should be retrieved.
>
> Change-Id: Ic2a27ebc90f0a7cf581d0697c121b6d7df030f3b
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  .../drm/amd/powerplay/hwmgr/vega12_hwmgr.c    | 29 ++++++++++++-------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> index 40bb0c2e4e8c..c70c30175801 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega12_hwmgr.c
> @@ -1262,22 +1262,29 @@ static uint32_t vega12_dpm_get_mclk(struct pp_hwmgr *hwmgr, bool low)
>         return (mem_clk * 100);
>  }
>
> -static int vega12_get_metrics_table(struct pp_hwmgr *hwmgr,
> SmuMetrics_t *metrics_table)
> +static int vega12_get_metrics_table(struct pp_hwmgr *hwmgr,
> +                                   SmuMetrics_t *metrics_table,
> +                                   bool bypass_cache)
>  {
>         struct vega12_hwmgr *data =
>                         (struct vega12_hwmgr *)(hwmgr->backend);
>         int ret = 0;
>
> -       if (!data->metrics_time || time_after(jiffies, data->metrics_time + HZ / 2)) {
> -               ret = smum_smc_table_manager(hwmgr, (uint8_t *)metrics_table,
> -                               TABLE_SMU_METRICS, true);
> +       if (bypass_cache ||
> +           !data->metrics_time ||
> +           time_after(jiffies, data->metrics_time + HZ / 2)) {
> +               ret = smum_smc_table_manager(hwmgr,
> +                                            (uint8_t *)(&data->metrics_table),
> +                                            TABLE_SMU_METRICS,
> +                                            true);
>                 if (ret) {
>                         pr_info("Failed to export SMU metrics table!\n");
>                         return ret;
>                 }
> -               memcpy(&data->metrics_table, metrics_table, sizeof(SmuMetrics_t));
>                 data->metrics_time = jiffies;
> -       } else
> +       }
> +
> +       if (metrics_table)
>                 memcpy(metrics_table, &data->metrics_table,
> sizeof(SmuMetrics_t));
>
>         return ret;
> @@ -1288,7 +1295,7 @@ static int vega12_get_gpu_power(struct pp_hwmgr *hwmgr, uint32_t *query)
>         SmuMetrics_t metrics_table;
>         int ret = 0;
>
> -       ret = vega12_get_metrics_table(hwmgr, &metrics_table);
> +       ret = vega12_get_metrics_table(hwmgr, &metrics_table, false);
>         if (ret)
>                 return ret;
>
> @@ -1339,7 +1346,7 @@ static int vega12_get_current_activity_percent(
>         SmuMetrics_t metrics_table;
>         int ret = 0;
>
> -       ret = vega12_get_metrics_table(hwmgr, &metrics_table);
> +       ret = vega12_get_metrics_table(hwmgr, &metrics_table, false);
>         if (ret)
>                 return ret;
>
> @@ -1387,7 +1394,7 @@ static int vega12_read_sensor(struct pp_hwmgr *hwmgr, int idx,
>                 *size = 4;
>                 break;
>         case AMDGPU_PP_SENSOR_HOTSPOT_TEMP:
> -               ret = vega12_get_metrics_table(hwmgr, &metrics_table);
> +               ret = vega12_get_metrics_table(hwmgr, &metrics_table,
> + false);
>                 if (ret)
>                         return ret;
>
> @@ -1396,7 +1403,7 @@ static int vega12_read_sensor(struct pp_hwmgr *hwmgr, int idx,
>                 *size = 4;
>                 break;
>         case AMDGPU_PP_SENSOR_MEM_TEMP:
> -               ret = vega12_get_metrics_table(hwmgr, &metrics_table);
> +               ret = vega12_get_metrics_table(hwmgr, &metrics_table,
> + false);
>                 if (ret)
>                         return ret;
>
> @@ -2752,7 +2759,7 @@ static ssize_t vega12_get_gpu_metrics(struct pp_hwmgr *hwmgr,
>         uint32_t fan_speed_rpm;
>         int ret;
>
> -       ret = vega12_get_metrics_table(hwmgr, &metrics);
> +       ret = vega12_get_metrics_table(hwmgr, &metrics, true);
>         if (ret)
>                 return ret;
>
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cev
> an.quan%40amd.com%7C1bca63d3f90048d72d9808d838b6dd64%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637321705333790290&amp;sdata=b%2FJEpeIXuqH
> H%2BkiBxqIYMGVyirYGsCs5RiUq%2Bqp64oE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
