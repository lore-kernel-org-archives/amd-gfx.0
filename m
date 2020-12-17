Return-Path: <SRS0=AWwP=FV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B008C2BB48
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 03:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3AC22376F
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 03:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AC22376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F085689861;
	Thu, 17 Dec 2020 03:42:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA3289C09
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 03:42:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NposvDYrae/UZszOM6gbgWjplB2DvZKUE+GsBoosIAYe1NFUJXpWMpg2s2NZAft7QC22X28I7xN4n3KfqYXj22VcGvl95vxhrk6yXK9ts/HgyVjGerEHFBspw1C+xrV8TeWRp2/3PUmLMEdOK+gNj5+iN7zBDpw1SclXnxJTe6Q2EmxI++5hTK5XHQz964xYZN9tTm8uNdaATA1Cya2hK5/jQBNwGsS3Z7hMBmxeqJmq8u6AkfgtNWSxkw4J2XA8xx2OcHXMOQQFYlwSPfRbSGX208mk2UEx7+nF1U4mIJQ6IXAeuptBs3UHrTqVwy1g8AiL9RqgP3grZNwN3uw16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pKZgKa4FFF4Olsfn9afl3JEMzudraLGxfWALSnwUHI=;
 b=Ea0hGSUD3eqZMSQqxj2xvhXEP2Q+2KXdyjeXnuYe3lhc15zrZl0DUkuh1RWZIbqNPa8SbPgAzfx2JKK+MQNLyAPJkJFVqEPcBRUpQvc/xQZzZGzzFP1L5mjWALqtq3EjBOftcs6lw+TFK9bjL4ceCHoy/Fh28YB03Qx2fbF9RiVaYNfUPNOXCxys6WbZqS9OlbdXDMH9rKeGhXuIueVLsvSODkw9BBdSLTTDYhZ1312LpJReRu8bK03m289o1dFILv6A8l/HypVZ6KQmMOYjceTqKRXJaR6FB7AQVvkxHV5ssEUWlZHqnP7P6MQPeX3X+LH7IdkqXNnUu9AM4kGk5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pKZgKa4FFF4Olsfn9afl3JEMzudraLGxfWALSnwUHI=;
 b=sz2HeZvlY++30x4Bag4C307cuH7mG1iBYwKoEPSKpj0vvA2fvM60Wk72TNLSDCZpHAzVUc3UDSNNNX9TYBQRpUW3ezBUi7WSr0Bqc7bMIaKS+xz8ZK0wULK5dwXvNj1EN6Cb5yD9U5yXkriUDkWBpRh+DegxAdQWV1WQCwtRkKo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 17 Dec
 2020 03:42:17 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::4590:261a:f3b1:a1a2%9]) with mapi id 15.20.3654.025; Thu, 17 Dec 2020
 03:42:16 +0000
Date: Thu, 17 Dec 2020 11:42:09 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>
Subject: Re: [PATCH] drm/amd/pm: add pmfw version check before issuing
 RlcPowerNotify message
Message-ID: <20201217034209.GA1849373@hr-amd>
References: <20201217025701.22622-1-Xiaomeng.Hou@amd.com>
Content-Disposition: inline
In-Reply-To: <20201217025701.22622-1-Xiaomeng.Hou@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HKAPR03CA0021.apcprd03.prod.outlook.com
 (2603:1096:203:c9::8) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HKAPR03CA0021.apcprd03.prod.outlook.com (2603:1096:203:c9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.12 via Frontend Transport; Thu, 17 Dec 2020 03:42:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd6893fc-3935-4245-7b71-08d8a23dbfef
X-MS-TrafficTypeDiagnostic: MW3PR12MB4426:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4426C58B8159D0124E8BF90EECC40@MW3PR12MB4426.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TiPdVJv42CWAD6ErJggF245wTflz/jfa2OSA+ooZhoCHBrxsgsRrXCxU1/5Oxa6bJs+JZihe0vAXpBL2WXZYZpKs2/O7yy9RNYKD/GDN3JkEwiUdobs+mpsWx3svkMbuwVDWP9y+JWxoYqhXNnls1IYZawACsHVkgcW6qMnT6OuYfpeYqPqjzAELbcUVSuIZ8RFqhONW6cJ8GROq6TWs4pBh+/2bpLPQ3zvSZXwPFnTj22GISNG9F5cLm0ihqBQxjBq8DO64QHyZTqJVPwEznbpf8bQPJg0AASQOb8Zm0oZPBD6YRMwmBcbo9H0VeLeXCRDWZIBhoWrOeSMAJSt4wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(66476007)(52116002)(8936002)(6862004)(5660300002)(86362001)(16526019)(186003)(8676002)(33656002)(26005)(1076003)(55016002)(9686003)(2906002)(6496006)(33716001)(6666004)(66946007)(15650500001)(66556008)(316002)(4326008)(6636002)(83380400001)(478600001)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aTPhUnrSYqpYsM8ysXgfP7NseQm5HCh6I03B7yaMXXmEKA1z2PYjxP7vy6wb?=
 =?us-ascii?Q?fvxmFADZEB+T2Y4eIIiJ2653jEeFBl7YE2P0xgQsEZR9eBD/X20t//zTKzKJ?=
 =?us-ascii?Q?aeXHqp7bY0xz2eq7BsGgg/ZVllE+9nVIo/IxZh66Lv7Zwqr3X9XOCALu74Uc?=
 =?us-ascii?Q?dC6IZfUl6+Xs0L46fCrskWm5wRuDBCW1xVkpK24uvyYquI6uPNv7UoDT6inw?=
 =?us-ascii?Q?daehDRTQ2Vys1uaPhEJlIALQhEqXWD+X/wYtdX3Amf1qXf2Y2zcYw3LvTSgS?=
 =?us-ascii?Q?hvEILrEu1GbDoBKrPr544KWnkCiEaoclweW2GF0N7a5ExYtL/N+kWk9lBTI0?=
 =?us-ascii?Q?c+QiPXA7IX/tH7xBHLWJgg6l8ZVq7zBo6DCw4SObq9iiM2/70esZVSMErCut?=
 =?us-ascii?Q?lDAe3HAX4JGdtqrYFwzjAbTDtmSYZ41ovTSOf9DpO8jAX087BViHNY7O5+uz?=
 =?us-ascii?Q?8cPDPCjRlhn7vDKp6yu6FvzWM0d5QYt8gONLUdz91X60eT0IzhwmhoikqaHL?=
 =?us-ascii?Q?up6ublqFKtyWyDQQJX7Js6VWk4sbAmTVGn00cCSJ3wbybAWBW9B+J58QokZU?=
 =?us-ascii?Q?xx3zf37O3pEguf4a7I8/RgF6FE85NV2os1GFwZKnvXSUezAkwoSYUg2TlFVH?=
 =?us-ascii?Q?s0SgzUk5AzA64viuCKZliv+02bfrcGL7eYo0ck/mSv6K3FkTopQy74i0a05M?=
 =?us-ascii?Q?LaiNgH8FH6T9LE6eoHwq8Pm8QojYFGZoVEOLOHXgZStdtpLq38+bfktrbKqA?=
 =?us-ascii?Q?EY/IKxKtsyPa4nDnejobNp/T7HuOBuHk1zrLShL0mw9UDYcKwYGHchsk8Ayu?=
 =?us-ascii?Q?Tg4JIJHPW6ZLA00PwlQwokhzCOkDsUZz5N2uMVt22JmJoDv311O1PhEWujsE?=
 =?us-ascii?Q?J9LbTVqlko4WDagAmKoWaNNSD3AzmL85PyyGtZv5cseSO9/sJfn/V53TskjX?=
 =?us-ascii?Q?2Iio6aXO/Gd2/33BULcBmjaC3Zf11LOA2xsM7j6u6QJInlXVJaTPPQU9l3Ks?=
 =?us-ascii?Q?YlBc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 03:42:16.8743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6893fc-3935-4245-7b71-08d8a23dbfef
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ly1oki1tHNjfxWOFkgpZBj7Qa8+/ZiWT6uS3pkHrGL+2OvJDLaOHHu9qHAaiQ5BfaoTw1DF+sYDlVwNuvw7dBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
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

On Thu, Dec 17, 2020 at 10:57:01AM +0800, Hou, Xiaomeng (Matthew) wrote:
> Only pmfw version behind v4.63.23.00 could support this message.
> 
> Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 9bccf2ad038c..8cb4fcee9a2c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -724,8 +724,13 @@ static int vangogh_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
>  
>  static int vangogh_system_features_control(struct smu_context *smu, bool en)
>  {
> -	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
> -					en ? RLC_STATUS_NORMAL : RLC_STATUS_OFF, NULL);
> +	struct amdgpu_device *adev = smu->adev;
> +
> +	if (adev->pm.fw_version >= 0x43f1700)
> +		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_RlcPowerNotify,
> +						en ? RLC_STATUS_NORMAL : RLC_STATUS_OFF, NULL);
> +	else
> +		return 0;
>  }
>  
>  static const struct pptable_funcs vangogh_ppt_funcs = {
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
