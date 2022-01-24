Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A11C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 08:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A05D510E726;
	Mon, 24 Jan 2022 08:19:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E4510E726
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 08:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxNkP5JPMd+V6ZDf1ZTmuA3gl8bpZitjGBWU17istCLHOeLZXZKlcV7gt/RKhlWKhhrzr3OxcadXlYiHOJMH1mD4G58GyBC4ptnCCuLji7lowE3E9iQXckbUk7aSuanvPsywdjVNI2aybk+xGKnH6fIdQ7iX2S9w8KsNI+1qLqitsA4StYPiyhqHmrKp+hBvppJbII8CJlYQRZBfHXWnRM0dAU9YufgBHrm3jgzyQvzlY1QFXP/sOBRRZdSWXabuJR9A7s/7K3U5iqhI5gMMLZiw8Jxe1rGYLwSLodzDUlSs+I67O/Q+NgsWfyG48OvLPWr9mFrYokSPckCJXvaxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QjyFApOroea9Q+Jd/s3ByN4sR14BuIkXRRVlrYNrY8=;
 b=H9YoQrTuxVOBJ3A9fB7ge/TCxBC37M8ZgZD6ap5LSFxr0xJGK/DYwFZXhcVaoo4vj9yAyoIj/z2eQ9BiWdb+0BLnCuQ+7lOJe3w/rsDntMJnzo+b19dTdPwaAF89eri/CZF5KfGcHgkUbvJ9V/JcXYMuEbwr2vEP4Vna6Vo2rvfhSgnWJ5eD5Bl4owAibjEzTJJuv9IPiiXIpPm99miNkbzaaj/GEqe3SciRRbF3Nf+Sp/f9LCWUnT7CF7eE/DO0QND4WK/Yok7+d4d42MOXWbYDa5u4m27OUtkr6zLDdkmHkvb1pj85FyDgNle3mL5wHvIb3/B6q06pPi4r+FQaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QjyFApOroea9Q+Jd/s3ByN4sR14BuIkXRRVlrYNrY8=;
 b=3vmRJHhWh/x/xHCMekmkgioiBvYGCDngMeKJMUVz/ZDPnRC/d/MAsTloTmNUSQAf5LE1YneuUp/m5TZrBiYz5DzMhFM7bBR54G5WycA6nK/8mK1eTsg8nCwgxekEieu7zcPhIOEjl+oO8TkCAvNb9uPVG98Uhy0VPQJhSVQGA2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 MN2PR12MB3360.namprd12.prod.outlook.com (2603:10b6:208:c7::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.10; Mon, 24 Jan 2022 08:19:04 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::989c:5eff:f1be:c7ac]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::989c:5eff:f1be:c7ac%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 08:19:04 +0000
Date: Mon, 24 Jan 2022 16:18:55 +0800
From: Lang Yu <Lang.Yu@amd.com>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: add get_dpm_ultimate_freq function for
 cyan skillfish
Message-ID: <Ye5g71hOdQZmABYO@lang-desktop>
References: <20220124064342.273055-1-Lang.Yu@amd.com>
 <88fe897a-4866-7275-62c4-bdd027789f2a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88fe897a-4866-7275-62c4-bdd027789f2a@amd.com>
X-ClientProxiedBy: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To DM6PR12MB4250.namprd12.prod.outlook.com
 (2603:10b6:5:21a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54102e38-25b5-4d47-80bb-08d9df122ed8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3360:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB336019747E7D0BA13649CF92FB5E9@MN2PR12MB3360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eB1JOoMZhWqNmphELtAvUU9svnSn6c4/4p1uteOF/x7PWvIbBr1u4GITzFVqjP7g6Wj5XNY5oTW88x4bcKZf51ro3UkQ8kQjt3ecm3z5KVyuVT4O9qkoQsuNpORnhy0DbJTKWo0yn2OIpm7cu+Q+1Z114Lxi8QlQqqqHj1PPo+fgefDOI/UuC/+3klZQZ0/zuR4T6whposc2fGqGfngjVIirNV5bRYf0mSxBFCB+9KpoxLknnRLTMBwON2Q/KRxLbauvH0C7D3bDkuAyccRnrTgFPd5LxQdIKvNlGsXcCFwlCJQcIroE++XiQ6LW1cXKuR2yMuCIzkzu8n9SsSGnW4CGa9maHhpv/ktUan62U9HcLsvkV+VPpAuhHotsQ3Hrjg6/aWAia9Uzn4wijRkVSY0CCGZi6rYdyiBZ2XT2pl3FQeLKf6651jK7v1uRTlh/21BS3/eaSC2utkq5z0pUHA5HpnyHEPIdtTmYRqfGIinA/t7fOlgKB2pANKRla0qqZYXOVNL3AXoti52lCKUPzm8S0BG+M9LR7yPY9upQjk4SagdfIhOf2jhFu4gRnN5QHsbAP3CM10YWrJ+7RwH65Tkdm9UPGLYIbOpSXYK/gm7T7Fbgs+Ru/smxIi2MNQDG0S/TDpB1sK9pDK+E8Z79Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(7916004)(4636009)(366004)(86362001)(6862004)(6636002)(54906003)(186003)(6512007)(6506007)(53546011)(6666004)(33716001)(8936002)(9686003)(2906002)(26005)(316002)(66946007)(66556008)(5660300002)(66476007)(508600001)(83380400001)(4326008)(6486002)(38100700002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mdnx48Ph/Ra1yvfBWcW+lCldmaMfN5jo7hUHsIQSki+/+zGm0gHh7mTqgDm8?=
 =?us-ascii?Q?pxx0EVlQoxCo0PgZ6I4qe8J5yUzb0ombuM4m44DJCvcCZjgfspxYjbMti1Pz?=
 =?us-ascii?Q?3b366j+CTTJ4Ttyxh08vNTn8vJ9SXrgy+LGdQD7Zu8V2xnao3mfV1eH/wrFF?=
 =?us-ascii?Q?HVMOPmd6JqVaN8kEG7nWki5yHdEliTRakhPsdBrRxds9XoG5NjS/F2w4D4Bf?=
 =?us-ascii?Q?aK74f7fjpdguUOYA9DtEX0a4ZdqPfwgWZEiAMvCcarJeRfyhjgLDk2KZRVXt?=
 =?us-ascii?Q?XL5v9ved8MS10FDVPaHhtT2Xo1KRP1e4dQefRm18J7xr9GCUrQvuoIodI41Z?=
 =?us-ascii?Q?RlnK9FkqEZRydk3k0X9Y4Qoqyo/z8tofzkmET5FETpcKmJ/obUxzM7vTNVKF?=
 =?us-ascii?Q?MRXmtK7gYk+w5okBLnyycQJsMChZygX4r0K5+WeofCm1nasn0s/eyyf3ZtrT?=
 =?us-ascii?Q?9hLfxSYscysK9d+w0CFYJWRqt1NWwdHPDUgPP5BkysbaCUguTG3TrthjosBQ?=
 =?us-ascii?Q?uJezdgbnGtvjpjQzR2AuJyYW/+4Cl0cSeUh3mDv2J3NvJMpF6qz8sIUAodEM?=
 =?us-ascii?Q?DzOmVht4CUdpJEWPLnwoAu5E5t9FeCMyLjunkW3H+yx801TlsxVJ0XwM7mUR?=
 =?us-ascii?Q?tXxQ5E6aHTI97mDKMiZnVOKlL+sz5GB58NvBaVA3S3dNgQQZeyMy163oTDaT?=
 =?us-ascii?Q?HYyrCZlqea8DLNlBrVYSW7rYuQv/GnMqsoERoafv27Q4qZvqRnJeyDpldYs3?=
 =?us-ascii?Q?QSi+dF5e53Fk3vTnTPngnf13jWu8q9DVGH3USChhrAzwOVrCnanSElwjn7+7?=
 =?us-ascii?Q?ld6TO3qPdugs9g/iAYeduFq4n8AgitP5FJvjBraVzirAHPa4S8A6wtVcDAOl?=
 =?us-ascii?Q?vkY4Y+6qqIxMMhYavg6vrzz3mZnHBAtf2+C7V3BGUVMdLTkt7wPG3V4LkY63?=
 =?us-ascii?Q?YgqrDzSxoz5G5Ks325q86ySq70uk5GW3NaTsLJVPsZwR7QT0zRfaEpPQRPLu?=
 =?us-ascii?Q?n5tlYVHPtPapJ89d9IbVXO6MQYNgIJnNztF8wsR1MzNDZr6Q6q6Ha70/yh3I?=
 =?us-ascii?Q?SI5J6XMr4Yx0WxpwzhkCF13UIB73X7AriF2/i8ZWJcjTBE58OxX0GKBfDZd0?=
 =?us-ascii?Q?1m9huPSEyIEoxkHXR3Y7hCL/7kQ3IXtvFoPhYi222YX4nQUOEZKzBBLZ/bBl?=
 =?us-ascii?Q?UIzpL4VYo6ugm0wqRxi2N8hyE38IL7ymYgkzILlwtzm9ed8ZmvFVGtGwvzl3?=
 =?us-ascii?Q?TsoQqEqhlddpIrCoC0meBwdYqNheApzr+OKE1dNUFJ1nZkg2B04IcLMGSIP2?=
 =?us-ascii?Q?rl041Kjsy01Ejj4mNvkvW9wYkrYl4Mfx7xV8BD2LUV1M5vKPThm+Ga1qqsiA?=
 =?us-ascii?Q?l1Oix954OVyNPH529AtfK98TQHa93dHItk6kWbLfnqaoihMrsL4ps1cjEYLj?=
 =?us-ascii?Q?HK+2TKSOKQPQ5/PiLidmBnCy/zAuFKtldXiJWC76k70iBBxvjn+vzMKE1ULw?=
 =?us-ascii?Q?nNX4gv16j3vAqgNPY2bL0i/SfJ+5duKJpzgDTn+BaWtpo2VkUHVskXyKtJ/L?=
 =?us-ascii?Q?ZvvbwCICVYANJijuO/g+TqVo5am42qW3ETnhTiVAiM2PjGWZdJvCSj+8ytmj?=
 =?us-ascii?Q?5mUP/NBfLAGU7qGjQA7K7Xg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54102e38-25b5-4d47-80bb-08d9df122ed8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 08:19:04.1262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHGCTbT3A4nys0OqtdBw+k01avizkq4VEtYIZUt1IaqgpP6T9frqfm50e8jWe4+iRTQgK9U0TuSl0QfdgICdag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3360
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 01/24/ , Lazar, Lijo wrote:
> 
> 
> On 1/24/2022 12:13 PM, Lang Yu wrote:
> > Some clients(e.g., kfd) query sclk/mclk through this function.
> > 
> > Before this patch:
> >   # /opt/rocm/opencl/bin/clinfo
> > 
> >   Max clock frequency:                           0Mhz
> > 
> > After this patch:
> >   # /opt/rocm/opencl/bin/clinfo
> > 
> >   Max clock frequency:                           1500Mhz
> > 
> > Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> > index 2238ee19c222..665905a568eb 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> > @@ -552,6 +552,14 @@ static int cyan_skillfish_od_edit_dpm_table(struct smu_context *smu,
> >   	return ret;
> >   }
> > +static int cyan_skillfish_get_dpm_ultimate_freq(struct smu_context *smu,
> > +						enum smu_clk_type clk_type,
> > +						uint32_t *min,
> > +						uint32_t *max)
> > +{
> > +	return cyan_skillfish_get_current_clk_freq(smu, clk_type, min ? min : max);
> > +}
> > +
> 
> I see the below logic already there and this patch doesn't match with that.
> 
>         case SMU_GFXCLK:
>                 ret = cyan_skillfish_get_current_clk_freq(smu, clk_type,
> &cur_value);
>                 if (ret)
>                         return ret;
>                 if (cur_value  == CYAN_SKILLFISH_SCLK_MAX)
>                         i = 2;
>                 else if (cur_value == CYAN_SKILLFISH_SCLK_MIN)
>                         i = 0;
>                 else
>                         i = 1;
>                 size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
> CYAN_SKILLFISH_SCLK_MIN,
>                                 i == 0 ? "*" : "");
>                 size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
>                                 i == 1 ? cur_value :
> cyan_skillfish_sclk_default,
>                                 i == 1 ? "*" : "");
>                 size += sysfs_emit_at(buf, size, "2: %uMhz %s\n",
> CYAN_SKILLFISH_SCLK_MAX,
>                                 i == 2 ? "*" : "");
>                 break;

Thanks for your comments. To maintain the logic, for sclk,
just set min/max to CYAN_SKILLFISH_SCLK_MIN/CYAN_SKILLFISH_SCLK_MAX.
For others, set min=max=current. What do you think? Thanks!

Regards,
Lang

> 
> Thanks,
> Lijo
> 
> >   static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
> >   	.check_fw_status = smu_v11_0_check_fw_status,
> > @@ -565,6 +573,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
> >   	.is_dpm_running = cyan_skillfish_is_dpm_running,
> >   	.get_gpu_metrics = cyan_skillfish_get_gpu_metrics,
> >   	.od_edit_dpm_table = cyan_skillfish_od_edit_dpm_table,
> > +	.get_dpm_ultimate_freq = cyan_skillfish_get_dpm_ultimate_freq,
> >   	.register_irq_handler = smu_v11_0_register_irq_handler,
> >   	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
> >   	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
> > 
