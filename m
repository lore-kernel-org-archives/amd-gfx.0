Return-Path: <SRS0=Xhap=HJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1180AC433E0
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 08:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6989C64E33
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Feb 2021 08:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6989C64E33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E64846E063;
	Sun,  7 Feb 2021 08:34:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 140E86E063
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Feb 2021 08:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPTsFCK36Qe1gaNvOzJoqKj2oSjGj5W2aIcnx4heRbOhrXhwAEPrQuSGXEseh8sH/fAotP0yYhyV57oHDbH5xns3RinHLfCKR0XZfoPCSiGq9/HVSR2qLMaW8D9Wm+eJEUtXoMXW+nu9RG8bndFiFrdEi93TMm2V87734xulF5IChkH28Az+SMsyHQcJC0hh9Eyntz8WdvNmqAx0YdDilBXuzJ6chCOy/1ziya6311/Ii/EJvtrKnGxIfXxMoRNuxaFXj5xxcGmqbrTe4TkaPG4kLvkEUslGTQOKcpI1ll1ojwsbHMSTE8lWt6Max55WrG3w/Zh8EfAKHHEzkg/89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZdH5vi7fDuxukOW45WjJcugf7lzV20UQEhWqg73MsM=;
 b=AjBXCFwTojA+XfAsuyvpo4WWQLru66VsmIXgzdAzLJNl4XOtTGlH9ZRz0BuIU4GNqDUtE4k4N0InhTeMswHQpuOsYwDDyIKigOaR+cn7dbxhYYklRFPemMhU5TLtdwG3LiKJ3SK349riUmh6X2FwINjN4RdbWiWYYw634QA8irOibXEuZD+GnBLH6he/C2r7CHbU67t+CGSR7f4EuRd55HBNKU/gO57L2bWB9fjtbph4jN22EzZAJf/b980HUCNKRvsPCmRgSaM+/TiF6q2OiVScd2uwbiYBOyEwbnSJ6XdvBml1MJlhLTW+3CGuKfRDBlVp5xV3j14f3FE1dIkiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZdH5vi7fDuxukOW45WjJcugf7lzV20UQEhWqg73MsM=;
 b=0UXpNlc7LX8hqeo7kDA+Dk6Xf+3/32GBlAN3ordAFyN4DNQzdSZIUVXuj2tMj9rJBXhOz9VAFMJQBF2GfZLk37+yowL0uMGnbP5VuI6lCXTS6QefkGA6rbDvvyUEc8ieXP5sNBdoeVxC/V4xbfIvHY+M84JClASRpdVtn+qTh64=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1952.namprd12.prod.outlook.com (2603:10b6:300:114::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27; Sun, 7 Feb
 2021 08:34:37 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3825.022; Sun, 7 Feb 2021
 08:34:37 +0000
Date: Sun, 7 Feb 2021 16:34:24 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: add support for hwmon control of slow
 and fast PPT limit on vangogh
Message-ID: <20210207083424.GA3224316@hr-amd>
References: <20210205123924.24129-1-Xiaomeng.Hou@amd.com>
 <20210205123924.24129-2-Xiaomeng.Hou@amd.com>
Content-Disposition: inline
In-Reply-To: <20210205123924.24129-2-Xiaomeng.Hou@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:203:c8::13) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HKAPR03CA0008.apcprd03.prod.outlook.com (2603:1096:203:c8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.11 via Frontend Transport; Sun, 7 Feb 2021 08:34:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec5ff240-dabd-4a6d-6c60-08d8cb433419
X-MS-TrafficTypeDiagnostic: MWHPR12MB1952:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1952BC888A904235BDDB4E2AECB09@MWHPR12MB1952.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tNr071PW9p5Q4U0DxoVF0VwVGD2dvj1B8253xusSoJjns14fWZaPOLk9+DHGL3Rmc1bIChZ4VZ7plNoTgc36gVl0szDBA6dte1AbL85VKJtMYg0p11kGKKhR6rkgbWHiO/h//h8LELx/6Gdq4oq6K+XKHosYE+KaJq8p/yErgQaygcevRldD3Z2impKfzDhTS0svDhu0MS8OkybvQOx6r5xcXgYIHZRJegiJ3KJIZidQfIbvCVnpRzn/5L6DcvD16umlFLLyRZRQ7eoOC6Fz+T2yEKzQlOr+Zu1iKWPaqOvf7hRwevz5dLhPZ2LT6J3mH2OAPMy8Igam25FWiJJdeA/tkvhw16V5Q5mQ/qBX1LYB/lQdjgbikBiJeWYB+rPc7NMELLS5oOyoQlIZBTVDQZeJzVMU5BSOntnP2TYshURCrGdpRweidfG7kFKwiwsG6zSuaWoBQqG2XKbLdrSpl6/zSW6VjBMlBaGaCPM7vwJfSpYRsHdamTklhpprBkfIEqYFQNFsIJl+wAFvNDfXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(956004)(66556008)(66476007)(66946007)(2906002)(33656002)(478600001)(5660300002)(26005)(4326008)(1076003)(316002)(52116002)(8676002)(83380400001)(9686003)(86362001)(186003)(16526019)(6666004)(6496006)(6636002)(55016002)(33716001)(8936002)(54906003)(30864003)(6862004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Zl3Ttt3Ljj7NEb5M0kcgKM3uoJ8f8nlIcVOkG1ZqS8g003LPsg+LJstrUoet?=
 =?us-ascii?Q?o5axgwJHGcYfCQq+dvVFgf8oEayUmQGtkOGlrU1FWpw6Dur2WcvApxUUSywK?=
 =?us-ascii?Q?ZgNwUxhdkHOMK580qcGw7M9p++2JKB9rPssaSoIsiLNKAN2nCgXOrivYr4bj?=
 =?us-ascii?Q?l57OzCefza1JRAQO93dNsdmDlIiyC3i0+xj6uR+t8Xs+VXWzQjYPUHJn9PC3?=
 =?us-ascii?Q?GeAG4cXerfCYhrZtQpLQDIpNjutLNTY9lEn5FD8fWtG6PqYRvbdc3Be8mQbZ?=
 =?us-ascii?Q?s/G8wFpRkIgCY/Wx6AUdqQ1sLfNMn0HRu9HPNOep8tbdDcQlQ10KZEMKi14T?=
 =?us-ascii?Q?AUVpTtcEZvRwxLzbKg+DkXrOeuYwVLNiRA1OYOBWKfsb3vb8DFeNXFjxsNxR?=
 =?us-ascii?Q?q/npZZWYINlJo+gz/uHabh9JU/sEnwIUITqa6gagP2pJupN06KeMh8/NVjYP?=
 =?us-ascii?Q?025WcZfqlLFKzdQ7JLc3nvwX0hpXJF2RMHeNncCrgj/mV9BCAJpQSUEPxnhU?=
 =?us-ascii?Q?J9hYwbjZjGwVWiOljSaXjrFMlyMR8pCoQUvFLFfxiIySJXBiKVNH93UNSv4k?=
 =?us-ascii?Q?VIqDP5U0t//vdp7eV5lb3U/hSrScwWMyIpv5uaDC+1PRjriQnVbpq2hjcFX9?=
 =?us-ascii?Q?QC8VxuHAhCS05eo+nPUH5WIzGS528WYp2K97CNQuxP7ZPP/+JW+sVyEKW6EY?=
 =?us-ascii?Q?EyWD+h8w3/DPftnQ0KUAdZfsE59yn5B/fzmEECaWT9foGdtbhzz0wVTH1KOg?=
 =?us-ascii?Q?VClVHhbiTy/JkdnfngI5z8eP7i6zahwpfCva6c5aM1PsokuMt9BErDCYs/FC?=
 =?us-ascii?Q?7ce1p7sVhlKO6LVnq+zm0Ch0Iid+f0e/myO69YX+2iJJz4N04B7LT/YXF/pz?=
 =?us-ascii?Q?mTKcRpCsfIV7zmY5rpWFDqAtoLjIHFHG+Fm9FKpJA3xX0L6lvahuYclr2Kvu?=
 =?us-ascii?Q?6+7QTyS5sqZdyqog+NeCleB0DJtzT37fU7Bv+h/5lEt2/QsXwR20EDsomp2u?=
 =?us-ascii?Q?xMjvYvsvb4kTg2BVDUoewAQfE4y7VRcuzGZ7/1kQ6djeGBr1Ob27rMU8l8Cr?=
 =?us-ascii?Q?Gzff7hK5rXnHzOF6Fx9z1tzNB+Ft1mLFu9FGj2o22/LIcrWsyfiJrugnrBPK?=
 =?us-ascii?Q?01XRoz2vZ5L3V8UtpI9yM/XwI2HCmjwMgDSjcLEXWI6od4g8x3z40TWzfnDS?=
 =?us-ascii?Q?NlfBXKYySXRtHxLs2WSh65z1Lxbl0uZ4gKPLQzZMeZyW4913d5KeOLpos1r8?=
 =?us-ascii?Q?lIaI9opwAkdIWy5h54uo5yPYdsxufkkmeGLD98NsuXnCVpITeLzTbpMnK2Ea?=
 =?us-ascii?Q?0Ed3fq52Xc4zwbT4n8QsyQOf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec5ff240-dabd-4a6d-6c60-08d8cb433419
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2021 08:34:37.4242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iA6cS0DrQwTndot89j2TPQ1AJ1ycqUFAoZBHML0a+H5p9R6HsrwjTghc68XrCG3LCAezxhUbA1VQquE8aY49pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1952
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 05, 2021 at 08:39:24PM +0800, Hou, Xiaomeng (Matthew) wrote:
> Implement hwmon API for reading/setting slow and fast PPT limit.
> 
> APU power is managed to system-level requirements through the PPT
> (package power tracking) feature. PPT is intended to limit power to the
> requirements of the power source and could be dynamically updated to
> maximize APU performance within the system power budget.
> 
> Here FAST_PPT_LIMIT manages the ~10 ms moving average of APU power,
> while SLOW_PPT_LIMIT manages the configurable, thermally significant
> moving average of APU power (default ~5000 ms).
> 
> User could read slow/fast ppt limit using command "cat power*_cap" or
> "sensors" in the hwmon device directory. User could adjust values of
> slow/fast ppt limit as needed depending on workloads through command
> "echo ## > power*_cap".
> 
> Example:
> $ echo 15000000 > power1_cap
> $ echo 18000000 > power2_cap
> $ sensors
> amdgpu-pci-0300
> Adapter: PCI adapter
> slowPPT:     9.04W (cap = 15.00 W)
> fastPPT:     9.04W (cap = 18.00 W)
> 
> v2: align with existing interfaces for the getting/setting of PPT
>     limits. Encode the upper 8 bits of limit value to distinguish
>     slow and fast power limit type.
> 
> Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  45 ++++++-
>  drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  12 ++
>  drivers/gpu/drm/amd/pm/inc/smu_v11_0.h        |   9 ++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  35 ++++--
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   8 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 113 ++++++++++++++++++
>  6 files changed, 204 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 39899e7989a2..5fa65f191a37 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3059,7 +3059,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
>  					 char *buf)
>  {
>  	struct amdgpu_device *adev = dev_get_drvdata(dev);
> -	uint32_t limit = 0;
> +	int limit_type = to_sensor_dev_attr(attr)->index;
> +	uint32_t limit = limit_type << 24;
>  	ssize_t size;
>  	int r;
>  
> @@ -3093,7 +3094,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
>  					 char *buf)
>  {
>  	struct amdgpu_device *adev = dev_get_drvdata(dev);
> -	uint32_t limit = 0;
> +	int limit_type = to_sensor_dev_attr(attr)->index;
> +	uint32_t limit = limit_type << 24;
>  	ssize_t size;
>  	int r;
>  
> @@ -3122,6 +3124,15 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
>  	return size;
>  }
>  
> +static ssize_t amdgpu_hwmon_show_power_label(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	int limit_type = to_sensor_dev_attr(attr)->index;
> +
> +	return snprintf(buf, PAGE_SIZE, "%s\n",
> +		limit_type == SMU_FAST_PPT_LIMIT ? "fastPPT" : "slowPPT");
> +}
>  
>  static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>  		struct device_attribute *attr,
> @@ -3129,6 +3140,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>  		size_t count)
>  {
>  	struct amdgpu_device *adev = dev_get_drvdata(dev);
> +	int limit_type = to_sensor_dev_attr(attr)->index;
>  	int err;
>  	u32 value;
>  
> @@ -3143,7 +3155,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>  		return err;
>  
>  	value = value / 1000000; /* convert to Watt */
> -
> +	value |= limit_type << 24;
>  
>  	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>  	if (err < 0) {
> @@ -3355,6 +3367,12 @@ static SENSOR_DEVICE_ATTR(power1_average, S_IRUGO, amdgpu_hwmon_show_power_avg,
>  static SENSOR_DEVICE_ATTR(power1_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 0);
>  static SENSOR_DEVICE_ATTR(power1_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 0);
>  static SENSOR_DEVICE_ATTR(power1_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 0);
> +static SENSOR_DEVICE_ATTR(power1_label, S_IRUGO, amdgpu_hwmon_show_power_label, NULL, 0);
> +static SENSOR_DEVICE_ATTR(power2_average, S_IRUGO, amdgpu_hwmon_show_power_avg, NULL, 1);
> +static SENSOR_DEVICE_ATTR(power2_cap_max, S_IRUGO, amdgpu_hwmon_show_power_cap_max, NULL, 1);
> +static SENSOR_DEVICE_ATTR(power2_cap_min, S_IRUGO, amdgpu_hwmon_show_power_cap_min, NULL, 1);
> +static SENSOR_DEVICE_ATTR(power2_cap, S_IRUGO | S_IWUSR, amdgpu_hwmon_show_power_cap, amdgpu_hwmon_set_power_cap, 1);
> +static SENSOR_DEVICE_ATTR(power2_label, S_IRUGO, amdgpu_hwmon_show_power_label, NULL, 1);
>  static SENSOR_DEVICE_ATTR(freq1_input, S_IRUGO, amdgpu_hwmon_show_sclk, NULL, 0);
>  static SENSOR_DEVICE_ATTR(freq1_label, S_IRUGO, amdgpu_hwmon_show_sclk_label, NULL, 0);
>  static SENSOR_DEVICE_ATTR(freq2_input, S_IRUGO, amdgpu_hwmon_show_mclk, NULL, 0);
> @@ -3393,6 +3411,12 @@ static struct attribute *hwmon_attributes[] = {
>  	&sensor_dev_attr_power1_cap_max.dev_attr.attr,
>  	&sensor_dev_attr_power1_cap_min.dev_attr.attr,
>  	&sensor_dev_attr_power1_cap.dev_attr.attr,
> +	&sensor_dev_attr_power1_label.dev_attr.attr,
> +	&sensor_dev_attr_power2_average.dev_attr.attr,
> +	&sensor_dev_attr_power2_cap_max.dev_attr.attr,
> +	&sensor_dev_attr_power2_cap_min.dev_attr.attr,
> +	&sensor_dev_attr_power2_cap.dev_attr.attr,
> +	&sensor_dev_attr_power2_label.dev_attr.attr,
>  	&sensor_dev_attr_freq1_input.dev_attr.attr,
>  	&sensor_dev_attr_freq1_label.dev_attr.attr,
>  	&sensor_dev_attr_freq2_input.dev_attr.attr,
> @@ -3485,8 +3509,9 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>  			effective_mode &= ~S_IWUSR;
>  	}
>  
> -	if (((adev->flags & AMD_IS_APU) ||
> -	     adev->family == AMDGPU_FAMILY_SI) &&	/* not implemented yet */
> +	if (((adev->family == AMDGPU_FAMILY_SI) ||
> +		 ((adev->flags & AMD_IS_APU) &&
> +	      (adev->asic_type != CHIP_VANGOGH))) &&	/* not implemented yet */
>  	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
>  	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr||
>  	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr))
> @@ -3549,6 +3574,16 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>  	     attr == &sensor_dev_attr_temp3_label.dev_attr.attr))
>  		return 0;
>  
> +	/* only Vangogh has fast PPT limit and power labels */
> +	if (!(adev->asic_type == CHIP_VANGOGH) &&
> +	    (attr == &sensor_dev_attr_power2_average.dev_attr.attr ||
> +		 attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
> +	     attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
> +		 attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
> +		 attr == &sensor_dev_attr_power2_label.dev_attr.attr ||
> +		 attr == &sensor_dev_attr_power1_label.dev_attr.attr))
> +		return 0;
> +
>  	return effective_mode;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 82a5f4a4faf5..10b0624ade65 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -161,6 +161,12 @@ enum smu_power_src_type
>  	SMU_POWER_SOURCE_COUNT,
>  };
>  
> +enum smu_ppt_limit_type
> +{
> +	SMU_DEFAULT_PPT_LIMIT = 0,
> +	SMU_FAST_PPT_LIMIT,
> +};
> +
>  enum smu_ppt_limit_level
>  {
>  	SMU_PPT_LIMIT_MIN = -1,
> @@ -708,6 +714,12 @@ struct pptable_funcs {
>  	 */
>  	int (*get_power_limit)(struct smu_context *smu);
>  
> +	/**
> +	 * @get_ppt_limit: Get the device's ppt limits.
> +	 */
> +	int (*get_ppt_limit)(struct smu_context *smu, uint32_t *ppt_limit,
> +			enum smu_ppt_limit_type limit_type, enum smu_ppt_limit_level limit_level);
> +
>  	/**
>  	 * @set_df_cstate: Set data fabric cstate.
>  	 */
> diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> index e49c2d08a983..d4cddd2390a2 100644
> --- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
> @@ -129,6 +129,15 @@ struct smu_11_0_power_context {
>  	enum smu_11_0_power_state power_state;
>  };
>  
> +struct smu_11_5_power_context {
> +	uint32_t	power_source;
> +	uint8_t		in_power_limit_boost_mode;
> +	enum smu_11_0_power_state power_state;
> +
> +	uint32_t	current_fast_ppt_limit;
> +	uint32_t	max_fast_ppt_limit;
> +};
> +
>  enum smu_v11_0_baco_seq {
>  	BACO_SEQ_BACO = 0,
>  	BACO_SEQ_MSR,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 9017024642bb..d143ef1b460b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2046,29 +2046,38 @@ int smu_get_power_limit(struct smu_context *smu,
>  			uint32_t *limit,
>  			enum smu_ppt_limit_level limit_level)
>  {
> +	uint32_t limit_type = *limit >> 24;
> +	int ret = 0;
> +
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>  		return -EOPNOTSUPP;
>  
>  	mutex_lock(&smu->mutex);
>  
> -	switch (limit_level) {
> -	case SMU_PPT_LIMIT_CURRENT:
> -		*limit = smu->current_power_limit;
> -		break;
> -	case SMU_PPT_LIMIT_MAX:
> -		*limit = smu->max_power_limit;
> -		break;
> -	default:
> -		break;
> +	if (limit_type != SMU_DEFAULT_PPT_LIMIT) {
> +		if (smu->ppt_funcs->get_ppt_limit)
> +			ret = smu->ppt_funcs->get_ppt_limit(smu, limit, limit_type, limit_level);
> +	} else {
> +		switch (limit_level) {
> +		case SMU_PPT_LIMIT_CURRENT:
> +			*limit = smu->current_power_limit;
> +			break;
> +		case SMU_PPT_LIMIT_MAX:
> +			*limit = smu->max_power_limit;
> +			break;
> +		default:
> +			break;
> +		}
>  	}
>  
>  	mutex_unlock(&smu->mutex);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
>  {
> +	uint32_t limit_type = limit >> 24;
>  	int ret = 0;
>  
>  	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> @@ -2076,6 +2085,12 @@ int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
>  
>  	mutex_lock(&smu->mutex);
>  
> +	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
> +		if (smu->ppt_funcs->set_power_limit) {
> +			ret = smu->ppt_funcs->set_power_limit(smu, limit);
> +			goto out;
> +		}
> +
>  	if (limit > smu->max_power_limit) {
>  		dev_err(smu->adev->dev,
>  			"New power limit (%d) is over the max allowed %d\n",
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 36d651342a76..90585461a56e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -474,12 +474,14 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
>  int smu_v11_0_init_power(struct smu_context *smu)
>  {
>  	struct smu_power_context *smu_power = &smu->smu_power;
> +	size_t size = smu->adev->asic_type == CHIP_VANGOGH ?
> +			sizeof(struct smu_11_5_power_context) :
> +			sizeof(struct smu_11_0_power_context);
>  
> -	smu_power->power_context = kzalloc(sizeof(struct smu_11_0_power_context),
> -					   GFP_KERNEL);
> +	smu_power->power_context = kzalloc(size, GFP_KERNEL);
>  	if (!smu_power->power_context)
>  		return -ENOMEM;
> -	smu_power->power_context_size = sizeof(struct smu_11_0_power_context);
> +	smu_power->power_context_size = size;
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 42271e80c0b4..3277014b5881 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -122,6 +122,10 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
>  	MSG_MAP(SetSoftMinCclk,                     PPSMC_MSG_SetSoftMinCclk,						0),
>  	MSG_MAP(SetSoftMaxCclk,                     PPSMC_MSG_SetSoftMaxCclk,						0),
>  	MSG_MAP(RequestActiveWgp,                   PPSMC_MSG_RequestActiveWgp,                     0),
> +	MSG_MAP(SetFastPPTLimit,                    PPSMC_MSG_SetFastPPTLimit,						0),
> +	MSG_MAP(SetSlowPPTLimit,                    PPSMC_MSG_SetSlowPPTLimit,						0),
> +	MSG_MAP(GetFastPPTLimit,                    PPSMC_MSG_GetFastPPTLimit,						0),
> +	MSG_MAP(GetSlowPPTLimit,                    PPSMC_MSG_GetSlowPPTLimit,						0),
>  };
>  
>  static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
> @@ -1773,6 +1777,112 @@ static int vangogh_mode2_reset(struct smu_context *smu)
>  	return vangogh_mode_reset(smu, SMU_RESET_MODE_2);
>  }
>  
> +static int vangogh_get_power_limit(struct smu_context *smu)
> +{
> +	struct smu_11_5_power_context *power_context =
> +								smu->smu_power.power_context;
> +	uint32_t ppt_limit;
> +	int ret = 0;
> +
> +	if (smu->adev->pm.fw_version < 0x43f1e00)
> +		return ret;
> +
> +	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetSlowPPTLimit, &ppt_limit);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "Get slow PPT limit failed!\n");
> +		return ret;
> +	}
> +	/* convert from milliwatt to watt */
> +	smu->current_power_limit = ppt_limit / 1000;
> +	smu->max_power_limit = 29;
> +
> +	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPPTLimit, &ppt_limit);
> +	if (ret) {
> +		dev_err(smu->adev->dev, "Get fast PPT limit failed!\n");
> +		return ret;
> +	}
> +	/* convert from milliwatt to watt */
> +	power_context->current_fast_ppt_limit = ppt_limit / 1000;
> +	power_context->max_fast_ppt_limit = 30;
> +
> +	return ret;
> +}
> +
> +static int vangogh_get_ppt_limit(struct smu_context *smu,
> +								uint32_t *ppt_limit,
> +								enum smu_ppt_limit_type type,
> +								enum smu_ppt_limit_level level)
> +{
> +	struct smu_11_5_power_context *power_context =
> +							smu->smu_power.power_context;
> +
> +	if (!power_context)
> +		return -EOPNOTSUPP;
> +
> +	if (type == SMU_FAST_PPT_LIMIT) {
> +		switch (level) {
> +		case SMU_PPT_LIMIT_MAX:
> +			*ppt_limit = power_context->max_fast_ppt_limit;
> +			break;
> +		case SMU_PPT_LIMIT_CURRENT:
> +			*ppt_limit = power_context->current_fast_ppt_limit;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int vangogh_set_power_limit(struct smu_context *smu, uint32_t ppt_limit)
> +{
> +	struct smu_11_5_power_context *power_context =
> +							smu->smu_power.power_context;
> +	uint32_t limit_type = ppt_limit >> 24;
> +	int ret = 0;
> +
> +	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
> +		dev_err(smu->adev->dev, "Setting new power limit is not supported!\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	switch (limit_type) {
> +	case SMU_DEFAULT_PPT_LIMIT:
> +		ret = smu_cmn_send_smc_msg_with_param(smu,
> +				SMU_MSG_SetSlowPPTLimit,
> +				ppt_limit * 1000, /* convert from watt to milliwatt */
> +				NULL);
> +		if (ret)
> +			return ret;
> +
> +		smu->current_power_limit = ppt_limit;
> +		break;
> +	case SMU_FAST_PPT_LIMIT:
> +		ppt_limit &= ~(SMU_FAST_PPT_LIMIT << 24);
> +		if (ppt_limit > power_context->max_fast_ppt_limit) {
> +			dev_err(smu->adev->dev,
> +				"New power limit (%d) is over the max allowed %d\n",
> +				ppt_limit, power_context->max_fast_ppt_limit);
> +			return ret;
> +		}
> +
> +		ret = smu_cmn_send_smc_msg_with_param(smu,
> +				SMU_MSG_SetFastPPTLimit,
> +				ppt_limit * 1000, /* convert from watt to milliwatt */
> +				NULL);
> +		if (ret)
> +			return ret;
> +
> +		power_context->current_fast_ppt_limit = ppt_limit;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
>  static const struct pptable_funcs vangogh_ppt_funcs = {
>  
>  	.check_fw_status = smu_v11_0_check_fw_status,
> @@ -1809,6 +1919,9 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
>  	.post_init = vangogh_post_smu_init,
>  	.mode2_reset = vangogh_mode2_reset,
>  	.gfx_off_control = smu_v11_0_gfx_off_control,
> +	.get_ppt_limit = vangogh_get_ppt_limit,
> +	.get_power_limit = vangogh_get_power_limit,
> +	.set_power_limit = vangogh_set_power_limit,
>  };
>  
>  void vangogh_set_ppt_funcs(struct smu_context *smu)
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
