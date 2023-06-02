Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37669C7EE24
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 13:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F3AA10E039;
	Fri,  2 Jun 2023 13:15:40 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F3810E039
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 13:15:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZYaB9Yl4JFM674nsmsrf+uqvmyN/7IMpRMwI2lkzN8YYXvUICwXh7DIqJyuJTxZ1bWhTNdddWilPvpLd9JpKmIHigaUlqJLKA/0P7GgYFCwIF6UrfxumQSOlOBcVRPnXu7EebrInvjTO4j1pz8fIbmYWAnfV4EGh+n/oURhVWYYvNzhSTKjsi5G/InMkYyQn5NXYOvXDn1Ygv3d2oxhZJtua3p+xXLbSTMQ0MVZpX8EqOkYcRYWpDSkKGK1Zjq0rn4Vm4okin6FOujaC3kihaW8588oe4B+ixmxhzTNklXym4+ZLbOag+hw3hS8LHoe0Bm9O2YdOKVTqg4KKdOrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqkaJWIvwX/uMSzEiS3XHSNRoEUOB5HTDwtMFAqNFT0=;
 b=OllnpXch9Ja/58F5Pfzjahfy17+4z3laZ2JVn2b2aJYOrzLPp+ONBVmMGF4KCdE16I6gYH5fPgSOY23fazsOBXvrIQi+jXv54ImH5jTt4guOJ0WqLFBW8Ps8L8xJASj822EOpBsG751yDtefmw6qnEOkInXVhW17d5a+B21SrZzK1NL369BVX0ShWbITSLBPzL0vAVaE44snGyJDxEXjL30FI/b5fQzgSCshGf8Obtdc2h8LUl6fvSYeYMhdMzP2JToPHsLJhpoy/LCNSZBDoBE5Y3iumEgWNllnBXwhlYXTq2DtuoYu4CPdim5RFGGxG7LjF47PE5YDmSqVCUVDoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqkaJWIvwX/uMSzEiS3XHSNRoEUOB5HTDwtMFAqNFT0=;
 b=uegQU0Q7vBsvX2dJ6DjxCNu/AE1I1q4fbFF7lPPMccGFmLjXMd4rXdb0XcwCTQTWs/lYL3QQOOM10wSMgEG+KNOtPt6CnegP1vFIPO322VmUuFvhr5WQQgtj7qyB6lB0KW5rzUc3SHgILxsDvd47Z1HJ08SyY43VUXg/Y8oeiPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH8PR12MB8608.namprd12.prod.outlook.com (2603:10b6:510:1bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 13:15:34 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::4666:2db3:db1e:810c]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::4666:2db3:db1e:810c%7]) with mapi id 15.20.6455.024; Fri, 2 Jun 2023
 13:15:34 +0000
Message-ID: <f2196cda-dee1-c124-d60c-9851754d7b22@amd.com>
Date: Fri, 2 Jun 2023 09:15:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] drm/amd/display: Fix dc/dcn20/dcn20_optc.c kdoc
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20230602095346.1603786-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230602095346.1603786-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::36)
 To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH8PR12MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8f5f75-c65e-4010-c6a8-08db636b72b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqIwq9J1Em4LF42bq960n2cQgT365hcZcmvQC1l9WYvICgtKzFe/F5yagKrWyfTOUaJbXV/VM5nQopVHG/YHIM9G2B+FsV2J/porNkuV95hyJgqU+xTpwyTbmtRRV8ZJ6k6gFjCWJJwbXyu+86VcWDDvnPaPlSr2b06POzj7alRTAbrXBHUTvJfM5+3roodIefO4Wec+98Ym6Zb0/s+zthnrUaPKozwihsptm/yCHCBAcLArD6O0Wa4VX0vZ2+bDa3TaKSyzNXjkkesAHjndZxIiaFB2NKmZbUCA8HZ/qdbcsw3keGJUo3K5zyDp9QqRA/1nvSmQXD6INE3UbJ2mWC9nRiXjt+elsCdcFfTGqFtDfZV3izEqNbCf/nUQXvOB+JUQvwTdpbTuC4gyjXgEy3IUyqShNHilOYwYbB1g9AqCC7xTQ+IWHIUqUoDTO+0eGvxkPM/c3/aStqeZ+HGV4B7ToihGzmd5xz/tf48pOIFWiyUwWiW+TA5aZmQtzFgNaqu+d3H/EmrsOUipZT9jZkWqlyXT0fB7oY/5+NWhKa/RhbQBCmhDFvhzc/AVBCzAQsyJ5fdco8NqW9bAHZtxR0JwLAQmyzxH1wkp2cJyhw6IQx7n9Tq0MR3tVT0dJ9yA2cF3jDZLZxxRZLbUPhpyGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199021)(8936002)(83380400001)(186003)(2906002)(6666004)(4326008)(6636002)(66556008)(66476007)(110136005)(478600001)(2616005)(66946007)(316002)(44832011)(5660300002)(6512007)(53546011)(26005)(8676002)(6506007)(41300700001)(6486002)(38100700002)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVpJajh3cVpybjh4ZXlYeDdKaTFiTk5QOWk4OXRMc2MvVGFjeGFTdnZ5UnE5?=
 =?utf-8?B?VFFWZjlud1EyZ3JTUHV4QkZ5TlFJU2FTNk9oMmRkZnhYNjhhMFh5VUtyeDd3?=
 =?utf-8?B?TFdXVWNDY3pISzhCclRoL1BUTVU5aittNHlTa0ZXT3oyOCtpeWE4ZlUyTXRh?=
 =?utf-8?B?eEhQRnF0OFFIejVrY3FLSGY0Y2w4N0RITTI4WmdrZmJXbTYyMXVFZ29CNVQw?=
 =?utf-8?B?SVZwQ2M0SkVONm1xZlpXUTEzQkV3cmNzTTFJRlgvTlRrNFRLeDFMR2hHS2Fa?=
 =?utf-8?B?dVVtVldvb1p4dFhxUWRnVURWQ3NNUUl3RnIyTGdidzgrRjQ1WWcwOXprZDgx?=
 =?utf-8?B?SFZaTDZTU3dpbmMwZTI4d3lPZFlCMXV5LzJBUUtFdE9oTU0wTmdWaFJyZ05D?=
 =?utf-8?B?NlBvMUNBYlltZktObVJEc2dhM0J3WVJreHFWSllNYXpMVGV4akQ4cVZ2Q1Fr?=
 =?utf-8?B?akFoUGhCNUFTcU5CSHhTWTBkeEdpTkhMT1RYVlFqUGtiN3QwdDBrNklGeGlX?=
 =?utf-8?B?UFlSYk91RWlNcW5Kb08xZHNPSDI2QXJUSzBreUM1dUF0NEN3aFFVZ0gvKzBX?=
 =?utf-8?B?dDlPZWhHM00vTGQycVFrN3Exbm44bDc1ZEF5M0Y2QlVOeGlVZys4YUJlUW1N?=
 =?utf-8?B?QjlDY21JVzk1NUVjSWJOWlp4dUs0TUdmQWxrbWl1eEdiRXdNNmtZdEtPcldy?=
 =?utf-8?B?WHhiMXN3S28vRUt0VktLRFZ5L1FRdFk0eXpURHhrTlZldmtiYk1rRmJCeFkv?=
 =?utf-8?B?eitCcVBxaGMwR3F5ZkdwUFNkbmk0ZWo2V0hXcko5c2hUd1hxaloyczgxc2dm?=
 =?utf-8?B?STQwdloydWVab0h5WW5TSUVROGZ6LzVwUng4SXRpOUErUEFRcmkxSW4vT3hu?=
 =?utf-8?B?ZDJSWTg2d3ZhTkN2UUFCN29KbXdTRU5KTWdsTWZDQWtjbDN0c3paa0ZpcmlN?=
 =?utf-8?B?LzNJeXkwNjljYlpLN09PRUF2SE9VbFFzaW9JNk1JbEFwOUpjK1JOMVIwUy9X?=
 =?utf-8?B?WmsyRXdlMXBJZ2paRmZySFRGbStyZ1EwbmRUUCtRYVY2S3ZPTDdxR081cXVC?=
 =?utf-8?B?TDRDcTRCTys1aHlwbGdMOWg2a2dMUXFrUFV2K1U0Vk9QWGExaFJLWlp0UUpw?=
 =?utf-8?B?N09WNUZQWlFlNTh5NTJXclNialZvcnNBS0ZDY0JZU3IxVzk5SEc2U056NXAv?=
 =?utf-8?B?aHlvQXZweU45bkdFMmYyR3JMQ3RZbmJ1MVBsVko5UFg1aDNUL2kxUjM0eFJo?=
 =?utf-8?B?aEo3djBtNm8yeS9xMGZqNTloWitSVFJ6Y0hyRWtLS1lHSmJMRXQ4RWNYRGhS?=
 =?utf-8?B?b2VNOVZPR0lvMXNlYlNVVURjdng5azBTVlZxWjNWL09JekRldDByV0Vyelkz?=
 =?utf-8?B?eTBVUG0wN3p1QjJ3VDUxQUx5U1U4Z0J5M05SSk5WOCtOelgvWitUV2JpTTBi?=
 =?utf-8?B?MVd5K01pYk9ybmxKekJIYTZWRUtBSTFWSk9tVG5QTzloVVprM1JxTWZTOHlP?=
 =?utf-8?B?MmFIZk9UQ1lwVEFiRWs2djY2KzRVL2JUVnZEUEt4WnFoVFZhODIvd3oxdi9n?=
 =?utf-8?B?VHhLMHBUdTVldEh4dE5JSVBLRFNzTmJnRWl3dUMwT2pGZVNBNDRBdnhWanEz?=
 =?utf-8?B?WmhvSEpkbk1XTCtJZVlmdTBVMlNYQkRic3RIdEtMOTZtditNVERaVHZxWmRh?=
 =?utf-8?B?MzNlblI1dEFBMm9Dd1BtazZzbDg0N2Y1Y1c4ZUFIZHBXQ0VORlpaazY1bWd4?=
 =?utf-8?B?aTY5aVZ4c2lZbml4WStXMHlFZWxXOG85Tjd1bC95QTdFc3MyRTBQWmhBejZ4?=
 =?utf-8?B?K3dvQUM0ZUVCMDRISmprTzZRQ05NTFl4eEhVTkNrbVN0QnZFVkpiV3I0SGh3?=
 =?utf-8?B?N2ZqbkNncWNvcjFIVXNsdHhNMCt4QzVBVEFNQTRSdW1yeWliQ2Vvb3BRQ1Qv?=
 =?utf-8?B?RGN3VVptd3RsZksyOGsvZXhpUS94cWNMd1o3d0VYNW1VRDZZNHRCWDZTMEtv?=
 =?utf-8?B?R1B4VWpnWDdpcnd0UnhTa1JZZGxxMEhxTTRuRlZtajBad0FDTzRvTlpodzhQ?=
 =?utf-8?B?SHpaaGtrWWVtU1g0VVF5TTV0MGtiSHFGbUUzcjY3bm5XNERZUXRYTFRXcUJI?=
 =?utf-8?Q?QGWwlhj35SUFbZGR8MzhFji6m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8f5f75-c65e-4010-c6a8-08db636b72b1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 13:15:34.3249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QajFB7BudSJuRQZ27yZbB5k52AjZbi/US55zRSTz9Fz5AUsvVLAkW5jqDjgRC/+5LiiwINlQe8HbhmJ+DQk2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8608
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/2/23 05:53, Srinivasan Shanmugam wrote:
> Fix all kdoc warnings in dc/dcn20/dcn20_optc.c:
> 
> display/dc/dcn20/dcn20_optc.c:41: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Enable CRTC
> display/dc/dcn20/dcn20_optc.c:76: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  *For the below, I'm not sure how your GSL parameters are stored in your
>   env,
> display/dc/dcn20/dcn20_optc.c:85: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * There are (MAX_OPTC+1)/2 gsl groups available for use.
> 
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c   | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
> index e0edc163d767..d6f095b4555d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
> @@ -38,8 +38,12 @@
>  	optc1->tg_shift->field_name, optc1->tg_mask->field_name
>  
>  /**
> - * Enable CRTC
> - * Enable CRTC - call ASIC Control Object to enable Timing generator.
> + * optc2_enable_crtc() - Enable CRTC - call ASIC Control Object to enable Timing generator.
> + *
> + * @optc: timing_generator instance.
> + *
> + * Return: If CRTC is enabled, return true.
> + *
>   */
>  bool optc2_enable_crtc(struct timing_generator *optc)
>  {
> @@ -73,15 +77,18 @@ bool optc2_enable_crtc(struct timing_generator *optc)
>  }
>  
>  /**
> - *For the below, I'm not sure how your GSL parameters are stored in your env,
> - * so I will assume a gsl_params struct for now
> + * optc2_set_gsl() - Assign OTG to GSL groups,
> + *                   set one of the OTGs to be master & rest are slaves
> + *
> + * @optc: timing_generator instance.
> + * @params: pointer to gsl_params
>   */
>  void optc2_set_gsl(struct timing_generator *optc,
>  		   const struct gsl_params *params)
>  {
>  	struct optc *optc1 = DCN10TG_FROM_TG(optc);
>  
> -/**
> +/*
>   * There are (MAX_OPTC+1)/2 gsl groups available for use.
>   * In each group (assign an OTG to a group by setting OTG_GSLX_EN = 1,
>   * set one of the OTGs to be the master (OTG_GSL_MASTER_EN = 1) and the rest are slaves.

