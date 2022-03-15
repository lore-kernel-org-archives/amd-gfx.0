Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952A8C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 12:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3911389DDD;
	Tue, 15 Mar 2022 12:49:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6723989C61
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 12:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtxNN+QCFjzNBaPV8D3hTt5ozuF+FxpEsXGOktnEenWlRC8zwsr6Fv6CnrzM9WrInUlrwzMqzyU5nAg0k6oezg0SEruBLSajBhxbBQiPpNZNQVFk347VhIk1Ef6vTaqt+aLqfZL8yMN/qwMZ0a54122SyzDIKNdG4LA6wTvn7d5peqYbj1hb/B9h3qb2+IgKcImL0U3ov+xUfZ5k+IK06S6CmvAE1Gyq7oK/wJf9B+YBrAuJWuMlK02E541J9noZpvgS00K8LtincUwYlv6VhCWek4p5OHs0tYCCdLE5eFFPL5RthPzGLI7/KtR6bIiYzAcHONhMVZYAPQeAINDCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev5EHxWVzNjMbov/UQsZJMRmNvTvKBJYDUJZ0AseS8c=;
 b=lGEhU7ZcuWHTVhu2ze68p1ZfaMvmzQeaUufQ5DLciuYaspO9U4cMxCPHifYKsVw824eDyC4Q37ACUgWDALw7OOVC+cNVjNxRmedzRqlXF9fhK8DCgt+DToOZo9/KZ5N2DL8huzTG2+KlTVwhUS2R8I9FmotkV7esYj19dmZbtlOBprKHuwJp2J4S1jHwlFtFvguWngHS/Z28ERgatvPkzey5PlVwbJaau+y5jkk6GznCzkImJ3bFIIF4OQDwcIaTB0Udu3ln2BkJGNkRdT7BSkgBQooe1AUZzrGDb2YBValfRnAHSCBF8RJx/C/q9p6cJnyA01sKBjhIiWvAzoojQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev5EHxWVzNjMbov/UQsZJMRmNvTvKBJYDUJZ0AseS8c=;
 b=c+n3Nva3q/kcrKFE1TmnNF2M4l7OR+T81BaNw80wZ0pd9mpQG+tnK0MuncAp0x90NneS8cKSvdkm+BpUvOycBQLm4zrBd3nAMqz2iSNuNQtuGSuJ/XNxlNQGlfOV+NKSJcKpfhscpNTl3DM9C3EomyYIgiMUmpV3ZEFPZaPGFXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by BN6PR12MB1316.namprd12.prod.outlook.com (2603:10b6:404:1c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 12:49:14 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::8d3d:32f4:7ae0:799b]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::8d3d:32f4:7ae0:799b%11]) with mapi id 15.20.5061.029; Tue, 15 Mar
 2022 12:49:14 +0000
Message-ID: <8e18afb8-497d-8ce5-5636-498e7b8d45ea@amd.com>
Date: Tue, 15 Mar 2022 08:49:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/amdgpu: Use ternary operator in `vcn_v1_0_start()`
Content-Language: en-CA
To: amd-gfx@lists.freedesktop.org
References: <20220315092937.141380-1-pmenzel@molgen.mpg.de>
From: James Zhu <jamesz@amd.com>
In-Reply-To: <20220315092937.141380-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:610:58::33) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1be020e0-7fa6-4348-5267-08da068235cf
X-MS-TrafficTypeDiagnostic: BN6PR12MB1316:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1316006FD1BFDDEF98A1E03DE4109@BN6PR12MB1316.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0z+fA3cuaa0oFr49hrtaXlwdU4MCZIXBTPeJW7zni3fhJmK3HqVhZrebSBZX2caBxDbDBg+ApDNqbH+3olCf83+7BPRl76Jq3MnGscm5zavTaqaQ4jz1r2yMZ9CRa0XjlgShO42TeY/A4dCMYJqccm2EYZAEW6If2h2x+0a3aprPOPh/ONx4XTsaJLuMV4Gg833A6q4I4SzxCASOpSLc1hyk3pmsdFQzSxf9T2T5xnTPu12AsecnTO0kCjSsK8j+3eaw1R2DnbABCadlOgK7QEnx7mKFDdiejFDzT17o8K947Nz0BtTaRIZneYpIUrMJ4+dbpyixSdoTx5R4DU3pLaiw+n8wduiHj7VAmC2me9uUsx5ikuioTUWthb9WacD/g16DwgQZQUp1pwW2itV2aEJIYwdNtgySXGKl0hzklVLShNdwhannVdkC7POb1HUm5ekBOaeqI0w9FcWDdw0BmOZQrhVe716f6pNshk96nERczIavZJUeImJSjXpzNAX2LKWQ03u/bRR+l9DKHgzOq189GCY66qMcYk7FMshMQUKHDohqEUa4ORjRCDCRE2I9MuLKReSerpYlwC2f0llmWLPhPdq8DYstY58QkIuTIkqc8s6GqkWdQ9+ifNlAZNvPSfP849jNMXBnFfLr+Qy75GLFngwvHELbOYJC/DGQPra9+svDWvAuxUZhxv9YAUaXIqeVo3JQ1kzglbDWkGXVIGGeTAKYvfq4/CZ/LcTSlApGHx0X+6k3s+vvyS1WTS9pEmg18z7kmjvgvcuFyH1oeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(6916009)(66556008)(66476007)(66946007)(316002)(508600001)(6486002)(36756003)(38100700002)(31686004)(31696002)(2906002)(53546011)(26005)(186003)(2616005)(6512007)(6506007)(5660300002)(8936002)(83380400001)(81973001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUVGMEZZNWhLeDdlN2habmlXK1lXTHZKUlk1Mit5ZlcwM0xNVTZZL2hZTS9p?=
 =?utf-8?B?YnAxOExQUjdtUkNpUUJ0bUZGdWloS1B2WHBRc3JoVFVLQndwZ2VGRDlKWlRs?=
 =?utf-8?B?ZWNwbjRiUklucDFkeEMralp1SFFRdW5wYWpQMkRQdkw3VUlySGNPWXdDLzlx?=
 =?utf-8?B?OWIxL3c3b0tTYlJaTU9SRXUyMDB1bU1NaVhHdVFpdXJBKy9JMThCYmdET21o?=
 =?utf-8?B?ZHBEckJEK3UrSEhjaC91bWg4cWh5UGF5Z1MzMC9ZWnh0R0p1ZjFucTRVVTV3?=
 =?utf-8?B?bUpvaXVFem96bU02aXppUG91NkxOQlhpMXNYVHdkUmFyNW82aWh4cTV2eEto?=
 =?utf-8?B?c3YxdklVSHNDQTZsdWVYQXBZclR5RGVMUXJiS3dnMnZ2SElhNWIrdTJJN1lm?=
 =?utf-8?B?UmNyNzFudm1kVWpwSmtvSURJdFRJd0drU3B1MzZGNnJSbHVDM3U1am9LeG5I?=
 =?utf-8?B?Z3FhZG9WOHAvbXZ3cFRndDFOelhyRXNlK1BlT21VSGN6dGNtNzRWcjRZaGdi?=
 =?utf-8?B?YjNLUkRHNGpFMGZaL1phVkpUV3lUOEhxWlVIZXBobEp4cW04UEloK1J1Skdq?=
 =?utf-8?B?dFFNVjQrYUxzN0lzaHdDNE05TlUwcUtqVjYxR0Y2SXgyQ2UxY21GdURSNXpR?=
 =?utf-8?B?UjAvNDIyQzFLUmNPRFRVZDA4MDBIUURFZkJ5NVVJdWpKNW41M0hPajNMSXRM?=
 =?utf-8?B?a1BzUDd2YStQSkNwZk5IMVplU1h1VzNHRmpRVUxYdE9NTFJQUjMva09WWnN0?=
 =?utf-8?B?YlNxdkgxaXNXL1FiOXFnOEhxQnlnWGo1Sk9YdHY2Q2JXeXE1VGpUWE5JU29L?=
 =?utf-8?B?eEVIV1NFM2JRTU1wY3NwaHAxM2o1K1dUSVRuc3VWbnFQd1dKTW5GV2NxcDVq?=
 =?utf-8?B?WXlJYmpXaitMR0dTMUlUZ1c3MHl1RnF5NjgzTWE2V0h4VXUwYlp4WUcxdjhs?=
 =?utf-8?B?VGlWOUswemhoU0h2RnM0Vm00bUpRdWg3M0hpZ2dGSDI2RUh0NGtjTndEeHR0?=
 =?utf-8?B?SW5Gam5jUmJDbnBncHhYYXN2bXEvTG1YV3J1QzNhK0pTeXhobEZ5L1F6cU5l?=
 =?utf-8?B?QndPbWxuSDJUeDBtckoydzVZOEdRZURMSnZLT2pBa1lEODRrZmhKakc5MHk5?=
 =?utf-8?B?ZE5NWDgxTzl0OHI0Q2RIS3lzS1d3eCtTYk9WZnZHdllQRGY2WlBHZDB1eXZM?=
 =?utf-8?B?T0d6NmZPSTNiVVlpSW1hamhiVjVrYnp3Q2JramVxbnZ4MjVYS0ZNUWFvNEtM?=
 =?utf-8?B?dzRTZ0dsVzdmNFREelFNUUd1eFN5NWpVMlNOZlF6R3UvUnRrc2lSZkZWME9j?=
 =?utf-8?B?TTVwdllOaWlySCtKL2Z2NmhTd1JZQjlaZXliV1V2OXlzOWZtREhyQjAwc2Z3?=
 =?utf-8?B?MkMyTXMxdFdYYTVlb2p0SXgxZ1FQaDFxMUE2aFVXeURsY2EvTWgwRis3WkdP?=
 =?utf-8?B?MVdieGp3NWdGbFFBbFBOaXIwNjZ1alA5NTNMNVdFS0UyNThxUkpYdGQwNE41?=
 =?utf-8?B?TktnbGpnTWszb1psNWdyYzRDNXZwSFVhS1ZTMENCMHlhTXFVbURFQTFqclRh?=
 =?utf-8?B?NVMvSUNFRUtxMmhsSXAwUXVUbzd0UC9kbXAzMDBDUGNsQmRxcHo2NzF6WFB3?=
 =?utf-8?B?dHNqOWtBSlBCY2FkT1lFSHdVNEw3dEQyUGY5RHZ3SXZRRUlQWnBvSE1yWXVV?=
 =?utf-8?B?dFZMSEpaWE5EMDJIL1FrdHlmTVpadHBwVi9xcy9XTytMcFdsL3VRNFF5VjR5?=
 =?utf-8?B?azV3MTVONjdhTkJyYWpnTlhrSnQ5aUZNR01oVWlQUmNVVUUzeFJRM010Um1u?=
 =?utf-8?B?K1l2OWpqKzQzOUJGc3dKL3JvV051V2dpVW1QM0VUYzE3YmV6MGFPVjlncXF5?=
 =?utf-8?B?MkJGM0NKenRGQWlYYVplQkxCNnA3Q2JnczZRYWJIcXd5bk5DRjFzdDFCSkwv?=
 =?utf-8?Q?o4icGGGuH12JK+Luvc0xoK70Zvp/5B60?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be020e0-7fa6-4348-5267-08da068235cf
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 12:49:14.6203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPOSwIp1q6h3GToppWypbeiFmruAq1iyCV5qhikRutF/BCStzczJMLmGdQsNltSj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1316
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>

On 2022-03-15 5:29 a.m., Paul Menzel wrote:
> Remove the boilerplate of declaring a variable and using an if else
> statement by using the ternary operator.
>
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 3799226defc0..78ad85fdc769 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1095,13 +1095,8 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
>   
>   static int vcn_v1_0_start(struct amdgpu_device *adev)
>   {
> -	int r;
> -
> -	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		r = vcn_v1_0_start_dpg_mode(adev);
> -	else
> -		r = vcn_v1_0_start_spg_mode(adev);
> -	return r;
> +	return (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ?
> +		vcn_v1_0_start_dpg_mode(adev) : vcn_v1_0_start_spg_mode(adev);
>   }
>   
>   /**
