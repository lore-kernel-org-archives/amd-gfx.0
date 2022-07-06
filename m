Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE72C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jul 2022 14:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F64911AE61;
	Wed,  6 Jul 2022 14:08:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A9911AE61
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jul 2022 14:08:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkbRutgoEmuQ9rATrB+iXwPirGFY8l6erCaYHgdWPDlPxAAYJ12LCY5yF+/bPfs6vz9mBBdG+7Nh3hoAaVjgoBM6HcmiJb/EKjiq144lprvHj9cvWDqUq9Ghb2w3lEDLNBuVxYv6xtTX+hQF1+frkYaD2mAkSfsFFBJ8fS0Y27Hyawbecc4x/17nUdap7TB20NOCD4EtaJDNZ6WfIparCNj1ANofvdLG/L9E33Rz7CpxuM4HbkXdOLSEN7eKUDQQrzEEiWSv0Jsa9fpiqm+CFzcw1S9+ZGOYow7YT213zChTq3TYteYTf6IU80OA1bBGQV49Wr6HF8a8ghvLdAAe4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bA6x1PUo1FQfDhSnJJjL5GTOWo1FusnFuc3aib1DTcg=;
 b=U0wBtqIFcZYFmzBE7YsH73VF+u7pLnRuFzmZRSF3yJJoQ36wlo1XgKHeRXxJQc29ki5JfDKrt/D1jf+Bi3S+W+75mw5EcbIhldGgvVGyx0IEFqv2OlupBN779lt2iAWYVKix9y5NLc3BBbaYWCKCzDYvZZx2Ewc7vSxBoFSCve3j5sQbroUFrNtR38y5cFiTct2JSuGbHrtOmrwan42ZiuWtR1KEZD7jWqKvyzxxrrQKWfVSno3i2lDWofL9FXed7mHEvBXuGoNjgynQQHupfq25g686o4bmbNt6/mmRdrxn/azaC0P9R7btvZmN6EWopGQ1PwBK5uW+ZknDY5KQWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bA6x1PUo1FQfDhSnJJjL5GTOWo1FusnFuc3aib1DTcg=;
 b=BG5M/xLr3S4R8hcaIPOJmRdzG4BdLBTb1dMhyOiiYp8Ay6YwvXuuxw8hX96CyeaL8nCC0h1La33EgFJgcUZdLf6mxBEy2Y80S2h3ayToXXhq3gbFsOJKs/7oKuImp7fFLuRZZVoDl+A8sjpAt6B01ZzFkgxOtsQq8T4Rkh1DnqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MWHPR12MB1949.namprd12.prod.outlook.com (2603:10b6:300:107::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Wed, 6 Jul
 2022 14:08:14 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f55b:be13:11c6:d9dc]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f55b:be13:11c6:d9dc%3]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 14:08:14 +0000
Message-ID: <fe028a29-1d8a-6a2a-1fe5-fe7f25d6df13@amd.com>
Date: Wed, 6 Jul 2022 10:08:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amd/display: Add missing header
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>
References: <20220706140525.907320-1-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220706140525.907320-1-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0201.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::7) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 954e3057-cf7d-464e-ad0d-08da5f58f776
X-MS-TrafficTypeDiagnostic: MWHPR12MB1949:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ucnsz/olPxdn/3iEREoCD3js2EnXGh9aYZwFE+3dOcxngKBhZPb2vvJXiyW9CfX2Jg93Iy+aQUjFMdtw2Pcsi5seMBq6ZkB+THNtAAvPtJqwb4ssTtUKpsz3YkC8VB1YR1cAAe7bdEIZIkXzmScEnkxoXm/510qlN77P5+u+yt0SF0wI80VqZ/gGjdOsDMrgIkRwitDcgkZfaKZY8Oh+obWLXIiM+MMAGpvuh25vg+zdRJmCDMXDIXE4crDqUcXRTklCfH8zT8bk7addGvqUjhhD6hRoTy6pvjggn7zz9qlYeCvmYOUWsUey+TGS/Jy/1TjZk49KQiUQ6rclVuDUW3fgvfdCvQ/I6dPngeBmHC8k1NVlPN1xa9qsut2wwSJTbKub90lRmBfKdSlPe3yGwE07ciQ7V3aRLFuIXTfvAR0sEZlkvg6hMfUpZ4ZHyA1MBlU9dGiZxZ8nqitTD+Ohdj/EbelvmpEZL5OauVVUrYtBF/2uUsr8G71oiqMUTX8SRjN+9s8EkgOs+ObOiDTwmZGl+J46eSRp4myECqaIhl90XrV3ZyTLBQos3ETGKj8AlIPOy25SyzCGWrr/zS9cdWf6zThsdaw9V5hMeMgRFphO2f0eR8IbnMuT5qIsLKO0EHHv3kUZuebwKZ10fJMYphmy1MVHkmlyQ8J1fNp4GbNJcN5jqOJo9Lhl5p7eYhhRLsWC9Gieuun7Cb+Eq4xmRCUkqe+fbOfuQ/dlmpZO8BgDCemDJyiiYRrn9Uq3xABLreeU7klM4ShStPQQzho8qb7yyuzAfc3Unz7AhYX6JkLhfcRM1IyXss+nDL8znWTB5WVJeNM5HSyM0m6k+XDewgdweEtBil3aRI3gsb4BcHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(186003)(2616005)(38100700002)(36756003)(316002)(6636002)(31686004)(8676002)(4326008)(83380400001)(110136005)(66946007)(66556008)(66476007)(6486002)(53546011)(5660300002)(8936002)(31696002)(86362001)(6506007)(44832011)(478600001)(26005)(6512007)(41300700001)(2906002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TCtzUUN6WmYvS3d3ZDQ4MVNvbkFBN0R3SThJRm1XbUl4WlZEQS9mTFpBUmNK?=
 =?utf-8?B?Uk91V3phTzhkUWgyUHZtcXRTczB6Uy85M0M2YzgvYmtPZ0hrMzl1NTBWb3ly?=
 =?utf-8?B?RHhBSDBPTHh2bXRXRVZNV3c2aStISnlrdUxjSDl5ZEt2UjVDeTl0ditwclc2?=
 =?utf-8?B?UzFxZ205aE00TDAzZDVKNHZ3SEdUVDQ3RkFyTnlka2cxVk1kOGpoSHIwdmND?=
 =?utf-8?B?R2U3bUh0WGhTZTdCejhsd2N1YTdGcGErL3ZJbWhiN3BZeWZNeXBQZU5sL3Z3?=
 =?utf-8?B?d3E3bDduREdDbWZ6YzhCZHJ0Wi9wbHp5RS9CSUE1U0lWWHJxb1NYZU5FOFRM?=
 =?utf-8?B?enRXWHhTK0JYdG9zRFI0YTBNZlExUENwS0VQdHV0ekJBTWsvcDAzbHV3cGRp?=
 =?utf-8?B?TGlVamZSdy9iQWMraDloVUQwK0ovaWtrMVY2MGFyN3VFZEd1eWJwV2xyeXd6?=
 =?utf-8?B?WlBvUkVQSC83RjZac2FXejhiSlhLWkQwTDU2NkdYMkt4eldveEIyaXh1Q2l6?=
 =?utf-8?B?NEhjTis1WEJaSWZtTzZqUmhkSEFXTUZhNWFOcXNyVlVHRWJtYllVNlZnVUpz?=
 =?utf-8?B?dDhZWmQrem90Zm9xZXFrMW1DZWg1MkpZNUhHMHRmUlRnUUdzMVZDbURMV1FM?=
 =?utf-8?B?bmdLcHgzY1BCNFZoMkhGMzVMU0w3RE1OSkdMSDZQVHJvQTJFckoyYzAzTU1R?=
 =?utf-8?B?a3ExalJNYnBwUVR2Y2paL21KanEwdFFWT0Q1THB3M2lrenJKbGRWM1liTmhu?=
 =?utf-8?B?ck5iUDVURlo3MGJzR1lqL1BWMENSbEZKZ2hNdFd0ZGUwbHJHS3ZURGRiSE1o?=
 =?utf-8?B?MG1rN09yVWNTeTJOZnlEcG5ZOURualNrM29La1VGOVdtbDlVMSt2aCt0bTFE?=
 =?utf-8?B?SFBkbDBIU1FrS0Y3VkJQSE03SnFtV3hPT2F3NUZicFpHNzFUOGNDSlhLYk9S?=
 =?utf-8?B?T3VQU0lhbHNtdDdyUXRLM0w5bDZ5M3Vkem03Vzk0M1Z1NlptbjRhNzQwMUpp?=
 =?utf-8?B?dktyN0ZqM244MjlvWDVpM3MwY2tDK3VFVFBWRkt3TXU3Rm5zcXJzb29aQXBL?=
 =?utf-8?B?VGFMOXlBR2pSWVhQKzVBaEZQYWlqdnlDK2dKWEF1Y1ZHc1crdEsrTnpCSFkr?=
 =?utf-8?B?Wi81disycGd4bmtmUmNUUGN6RU9EWno3U2JVeTZSMmo3Qy85ZktYTGU3REl4?=
 =?utf-8?B?cEJLRmpnRXJBZG9Tb0VXc2dBK1dkS0NrRG9sRmU4Z2Z2cHRBU0ExRTQ4eFFN?=
 =?utf-8?B?cU0raGFqN3JvSHZtNHpuTUU0cUZDR2VlR1RYTm9RaXRpT3dkWWQvd2huRkFV?=
 =?utf-8?B?Y1BPQU1ZOG03YTFDQjA1UHVjTTJDVCtTL1J2VjllQk8yaEJBQXJPZDRUdXBT?=
 =?utf-8?B?S3dsdGVvZjVDalV5elk0cDliWlA4c1JhK2xhbHpJYVdMMDNGS3dMaVJwOWpv?=
 =?utf-8?B?UkRFODRvTDRITjgxek9WQ2Q3aFJZUkVwZVp3dmR6Nng2UGxMeEdpT2twaGR4?=
 =?utf-8?B?R21VOTdna0lyT0RFcmE1emhjY3JLcnNjQU9sQVhCVFB5Q2dlcHhQam5Cbks0?=
 =?utf-8?B?WVk5emFsaUxJT0hveGhxcVZkVE04RHFJTndWL3dTQTBSY1FXS2MyTnptR3VE?=
 =?utf-8?B?OVMvcXY5ZnljbVlselMwbUFoeU1JMllGSVg5elhiTlpncGNjMXFuOUFjcVpv?=
 =?utf-8?B?bDU1MTRYMnJ4a0c1UDIwd0R4cTVZZ0pyWmM2dGU4OVhjbHh5QWk1V2QyRVF4?=
 =?utf-8?B?WUdxY0ExNjkxOGUwTEZvSG5KbUFyeUVVaUtPMEJTeXF4ZlR0VzVjN2tmZmNa?=
 =?utf-8?B?OXViVU0yS2s4cy9iUlZMMTY5Rm5sb1Q1N0R0b3J4U2Via3lLYktNMUVzS1FF?=
 =?utf-8?B?WDdaSy9Ycm5TdU5SMVlja212Z3BrQ0dOeldNWXhLSHQyMU1PNU9kVjlkUmFz?=
 =?utf-8?B?TTRYbWU3aDRsRjBTcExQcHNXNTNkTHNGMHJmODNtQnhyL1o2dnFSeWZQVFlx?=
 =?utf-8?B?N0dvYVBUYk5xYjRseFpKSEl3OXpONXlVck5vTkZCODQ2MGY0N0FuRzBEdkFl?=
 =?utf-8?B?QjUya0pkVTB6WENHbkE0dUF6RjE0aGE3Z2tEMnNVbGErUk8wTUxJVXpTUFR0?=
 =?utf-8?Q?ZUehDj/JD4OIxlGYLUKRkAI0H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954e3057-cf7d-464e-ad0d-08da5f58f776
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 14:08:14.1730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEd3C5ioKSMOCpCT4pB055qvKdq0Bap0yvjkzzHOy/RCdOju6QFzrvoqqzzXGsnARCJhtnusd55WKEHc00T+8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1949
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
Cc: kernel test robot <lkp@intel.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

nit: "Add missing function definition"

On 2022-07-06 10:05, Rodrigo Siqueira wrote:
> Kernel test robot reported this GCC error:
> 
> warning: no previous prototype for 'dc_reset_state' [-Wmissing-prototypes]
>     2720 | void dc_reset_state(struct dc *dc, struct dc_state *context)
> 
> This commit adds the missing prototype.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index 02bbc90a2c80..7586500ec87f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -1209,6 +1209,7 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context);
>  
>  struct dc_state *dc_create_state(struct dc *dc);
>  struct dc_state *dc_copy_state(struct dc_state *src_ctx);
> +void dc_reset_state(struct dc *dc, struct dc_state *context);
>  void dc_retain_state(struct dc_state *context);
>  void dc_release_state(struct dc_state *context);
>  

