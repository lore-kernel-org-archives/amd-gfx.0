Return-Path: <SRS0=VJnr=GY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AEBC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 02:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7017823787
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 02:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7017823787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C21036E49C;
	Thu, 21 Jan 2021 02:25:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0CB6E49C
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jan 2021 02:25:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIY/CxGbiBlCgP3RPilEbHJXjymqXD6E7DfziuBk6n4L4ERaaJpDx9tPEpcjLQAP12waJCRMVXY76aYPiTQDKvq3SweCLIdrl6+xriBWPvq59sjXt/qFQpUvfryuVqZAnr2VmAe0sooQiTbV9m+7cY1ODRKho4gU7jcoDd06ufVXOt/RMgYEYXn2P0Px1cg+93ztSJWIH0B2kIley4h2E5fHtv1Cp9Lxq/q6ndws51Xr+jtOE7MLipBqV31FCS2So5CtFS8rkrzw43MwJbIQ7Iz6mFCAQgTntprU7rQc712tkdsps0Balc8qjzbuWOEg9tGH89cXyRh+wxMsm8IEvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ+iJgLeJbwnrUKK2PyljLrIPpqt+S/zjCsqERviUdE=;
 b=gK99RuvCardjGdcU3JdU5hzAyPWZZwn68zDb3e+7RGX5r0hVQPDa8vXKd5eFGep6yf1I08z6oeB086Zj+pukGtDyD9qH5P1kBtz5X3z0HY9+y9PT6phzsw9k727QteIQoxpCMTQTcq8HiCgqYz7KxTSEedyTRUxThVHhPBzKjYAcruh/kXzAxYfy710crFetjeNpWocq1/N+YCC5MvTFEYCN5Ts+lj1XG5fhRHppTGTmHaLBr4QUmbAYjN4mlgPeX2kD4CYhuqpemIism8khzEykLpen+/bNx1MshzSaJbNBmPRKmQFKRZKGWQ0NBwYgtTMH8/lEUshZqKkf9FjKbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZ+iJgLeJbwnrUKK2PyljLrIPpqt+S/zjCsqERviUdE=;
 b=tw8BkApeZ4+W4ugo4Qqh9ZAVVuXikC7gagQDBRRLu4Bosyt5R7urEBqFA99Ya77X0wXsGYoAaPDempDOqrp4EH9zaeGFAqkg7abTUPuVpB8ugXkbRte2ZPk635G+QgWfhRxa2VbMR4JucmMAupqsvw86+rJwBFIMwRtR49cPVRw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0096.namprd12.prod.outlook.com (2603:10b6:301:55::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Thu, 21 Jan
 2021 02:25:33 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 02:25:33 +0000
Date: Thu, 21 Jan 2021 10:25:24 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Allow GfxOff on Vangogh as default
Message-ID: <20210121022524.GA666971@hr-amd>
References: <20210121021340.19062-1-Jinzhou.Su@amd.com>
Content-Disposition: inline
In-Reply-To: <20210121021340.19062-1-Jinzhou.Su@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:202:2e::15) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK2PR06CA0003.apcprd06.prod.outlook.com (2603:1096:202:2e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 02:25:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7d3bb25-78b1-472a-2f9a-08d8bdb3d474
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0096D15CB59CEC7179ADADD3ECA10@MWHPR1201MB0096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:321;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLbDLjG/luq511ZIlTwWZ2KQ7WaCN6eNuvEjoCyUNwPSQmMqTmqJpv6u6UN5bZU8lrmJYBGg2GmQqjt60/+jxTn+FNvKcYn16J/vd37sL0T9aPefCXt5zwCyKuO14Qx4Wik4MdBKI2luWh7AewkFEaKjhiyR3BSzCA/FOFuknwvFW6Xpq629Yu0l6M8NqwVXwgJiAl2CLA0yE3yGoC50jOIY9NL6+BikmNvZcM9QwvMWEn4nC3oxPwZpAD4YJY3GoDq5a+N3LEkHp4BCKiqHT+/A8QlwXtNe8+76z4QbIK76bovYZzfuHk3R7hoYi9G9cNV7I+JXWJ+NDBQ1bKUIL5dqH30AbCtwr81tI7rnvB9uq81tYye8DD1XCvinDktrGjvwHQikuq0hAygDVgOyEZNhkviZeGdQXklNXnBTqsREm+NtpOg2Fz0G5RwMoQDEUmsuL94/1r2WkI2SouqsH/lY/DRAZ8DjNE4DX91I71uv+k7zpVCuRCoNfjkq88LVI96NpBNRCJXkZbDeyxSI0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(1076003)(6666004)(6636002)(4744005)(55016002)(52116002)(86362001)(956004)(186003)(5660300002)(66476007)(66556008)(9686003)(16526019)(66946007)(33716001)(6862004)(2906002)(8676002)(478600001)(4326008)(8936002)(33656002)(83380400001)(26005)(316002)(6496006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7AllS+r49nQ4rsuGl4l7QL1O6SgfUQp+/PYZhT4obLa9wKrOH2a6ehgUNmvm?=
 =?us-ascii?Q?GSAPLXMzrRZ5Knuuq/hegioS+6vQmPb9pBKPVPRrJfgpYnooes8EKcNIfhub?=
 =?us-ascii?Q?GkEXVwFDY93lCM0Z+60RpTd9hWjLyt4J0MIQFu84PDcBtA8T8wEycrcdUxPR?=
 =?us-ascii?Q?TI96LIqcHggIAX6VLOrWcYZ+qNoXjtXtE8lmJnQTse2NZ21kLWMl7dwPQ4GT?=
 =?us-ascii?Q?RSVMKp2lOlaZhqluOxW0Ul+tTK+O6WIOPZ4bBKSdyDiQKgtC9GElf01DcM+o?=
 =?us-ascii?Q?eZq2xUURHPyAgLozVkGw4FWKrQiypdbRO3NM7yy0ej6PyhjnGQUAze8IGG3m?=
 =?us-ascii?Q?0WBDMQgUU/kIYYl1RKfP9QzFUwo1YmKEGa77Q+imwmy1ZZxLRlTr/fsCoHdk?=
 =?us-ascii?Q?+jkuY3g+HHdjFEvAKaBg5zpL8snugX0TMsgWFzLRcQ0liMJWH4XD6OieObRK?=
 =?us-ascii?Q?OGbM3HYUI1EOzUQjbhFnrrC2HAulcRtpxORbSuMsh1Pi9wnfKrFPKQr+X8O1?=
 =?us-ascii?Q?hwnFsiCIpxV3g1DbOoTuV6bWbA9X+RYrfGBiXLB5l2pblt7Dol8ZriFPJklP?=
 =?us-ascii?Q?2265kCDmoI26GhgYafMBOkYoDNULMe0I3jHPvoR0IY3BEmsXeWSDV8hlwU2U?=
 =?us-ascii?Q?/ZzyDrEod6hnBirjDxHxtJCiD6peIC1hqvkCz+xXKf1/GkIGZH4QN9buKGkU?=
 =?us-ascii?Q?blxDE4wMPjHyEsPF5PkGq97axvJwph/Z5dlTyO7s9LED78AF1Wi0DntIIL/+?=
 =?us-ascii?Q?eKf/qVxzPPG18XWqbNx89zW2z7pYVpQp9fwNyCt9f9X3aRh1qcL3vGtXgla1?=
 =?us-ascii?Q?3ooHWf5aQilznZgE4CNqrxkZESP4G/Qct1UurGcE0dxXxJfR9oeqDlDsBDe3?=
 =?us-ascii?Q?0tmHj07/JEEA2o4uYd2/db0FhD15UrrrEIm2EWJqtN+VrGjn+FChQsXSkACg?=
 =?us-ascii?Q?AirSZ4VwIUTHCH+3IcWO9ocMzC72qYk5zdUsef91V2mrKVQLUmVweDXMDFTk?=
 =?us-ascii?Q?Cp3d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7d3bb25-78b1-472a-2f9a-08d8bdb3d474
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 02:25:33.6883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BvNjuelMEIZGIkSpIb5+Lk/AOoMeLDmjBBdE3+Q2/nksYc9i6olHZL6kb6od2Q69CkyHOgAyyFz8+CIjJuDkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0096
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 21, 2021 at 10:13:40AM +0800, Su, Jinzhou (Joe) wrote:
> Send allow GfxOff message to SMU to enter GfxOff
> mode as default.
> 
> Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index dd102cc2516a..426a217ce83f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7905,6 +7905,7 @@ static int gfx_v10_0_set_powergating_state(void *handle,
>  		break;
>  	case CHIP_VANGOGH:
>  		gfx_v10_cntl_pg(adev, enable);
> +		amdgpu_gfx_off_ctrl(adev, enable);
>  		break;
>  	default:
>  		break;
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
