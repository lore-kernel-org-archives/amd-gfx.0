Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7085DC47DDF
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 20:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDE5810E606;
	Wed, 24 Jan 2024 20:35:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86D710E606
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 20:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPQa68GMUA1G6B/3+bHhe6wtYFvki577FNRv/33zfZRnc/izM5KUX/5AJdASRTB29ftdmfCzFMNq6x3azTymwR79uEF46LZjeIaGfpClhNtQOnQ78UkoFtbqW9S+FVOxJrk+ZgIF8SnJaoYGTuy+4duQhPmIZbm+cToAyl+JkXOh2hdCnwXCdc2TyHJmspjRZeAC/O9AwfKfcToq9TsauyfICLs7ADDccYCKzMOhA2YJJqPyAh1KyeiMgFeH4s+uVPvCwndAG6/jx1sul1rTMD806+T3DAdeHjlvCaFaTsuXEsPd32VtBnha3L1P9wdGAgFVDka14hsJTBht8hI9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHX5lSJH8+C8IBSzEfFke8ZG8Tcn0GyxLH5yjFeJk10=;
 b=oQKIDP29sjtbXklXCetJaD491S/6Kws134dZgs0xGFgLYzKHwwpBhBWB5JI2nJJ2+3hqik1mlbYUSEEAZ0srCyt68jrvyvdoRblVmVMS+rjIv+FMVoUqietZXyaGWZkJnpoZDb/IU5JgOh2ynHgdCGWLe1R/AjE5PvvnPcII7wbZpTfHlaDnRYc7twh6Vdv7r8wUmNy94MVn1dJwdLDtzjz/qLhlhJeMNg/iq1pogKznSeEEHcg42it0RWwqAyqjNp9zCpRuXyofODaq12yIyT9gcECaITPTIpySErfXo2vhUINkJIN0GNdz0ABH6eEJRJGMrn/peroWQgInaqxLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHX5lSJH8+C8IBSzEfFke8ZG8Tcn0GyxLH5yjFeJk10=;
 b=nRqGIqXtsNEanQwglgixBP6dbhEy4fRrtC0qpyjAGjVS4NW7O34TJ8XEtkQ1izNDaj5GxdGJaSq7DheH9FheySPSfaiuxa1cfeX2gNlQgDk60w9ORGI5wsS48b/mYRsVQknckS+vsAAacxU4i03h4nlkjphiTSk9KDkNl96nisk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4599.namprd12.prod.outlook.com (2603:10b6:a03:107::22)
 by SN7PR12MB8145.namprd12.prod.outlook.com (2603:10b6:806:350::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 20:35:08 +0000
Received: from BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::eab2:927a:4a27:29a5]) by BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::eab2:927a:4a27:29a5%7]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 20:35:08 +0000
Message-ID: <9fc91c67-6088-c361-3179-969f4907dfff@amd.com>
Date: Wed, 24 Jan 2024 14:35:06 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amdkfd: Use S_ENDPGM_SAVED in trap handler
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20240115190733.1483942-1-jay.cornwall@amd.com>
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <20240115190733.1483942-1-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:806:122::8) To BYAPR12MB4599.namprd12.prod.outlook.com
 (2603:10b6:a03:107::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4599:EE_|SN7PR12MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 74cfad73-f2ff-4f26-dfc3-08dc1d1bf44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: coY5mp5SrBQ25R2BLip4k4Q69ZX6edAVh2JMvcuIPuPQGvgyBGSHvar9QUJZdOL5R6zGCVsnoWM0bthai60THmeBd+nlehZYnJOKnVY3RkXI0YT64Bsp5nOF55hxyjBhSiu4TKTDB/tG7s0BTQYGX7yS7M0blMQRyOYMZFtTwMB//RlMjtYqKjnuDziIJWlqz++I7GoPV0hooN6G9NY5oXxiHWbrS8UxW/7ThjZMAKg6mJn6WJV571kGyiTe2UQAzirZAKf+6wsmWTYHMjBbnXVm75R+VHkfkqWlwdShAWAOeYKesY2JrmJf8XAXzFd2bXv37gSd5UF2UR5jMyPq5K1uQLeNWBTC/f6Qrn5oaEGVllBWSk527rw/cf/QFfvkZK+z/xhKm9o5lmopsdk/1ipHKNipwtnjriXkoxCadW/LBFH7NrFfuk65In9oX7m2WYsursGmDPqmrt3UnFeEnJchhukfmUT6UXLXjM0R23Dg5MP/Mx5DfWJ4r0324h6R2pfxrO7z0fV3rcyGIIbU3H9M112Vl93MBh5VDxcZs3zmOEcB68jRqsS/2iyzj8chuDwhVVmkgNkTqmYvqAOvJMPHQmd28L2LKoUmnKjrUMcENHEbjrkmy/F+qVv8+V7b6/k3/Q2Yc2fH2iImAt20SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(66556008)(6916009)(316002)(66476007)(66946007)(26005)(2616005)(478600001)(44832011)(6486002)(6512007)(41300700001)(36756003)(5660300002)(6506007)(2906002)(38100700002)(31696002)(53546011)(86362001)(8936002)(8676002)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWZKd3N0ekg2QVB1THpGYVNUOW1XUDhQVWoxY1N5K0NWOVl1RVI1QWFHcThl?=
 =?utf-8?B?clpPRUFFT2NkdXc2RUh4STFhM1lzOVgrOWROdWRZWkMybnNqb0xmdWQ0Yk9u?=
 =?utf-8?B?MHhjREd0anllaUZ5UWdyd3phS3dQeS9DdGQweTBuRFdsU2JRMEFmTXdOMXpV?=
 =?utf-8?B?dEY0aGlKeWN3a2pucC8wZjRWRnovTUZsQnRINUN4VldCL3ZLbEhkYzFiZEpa?=
 =?utf-8?B?ODUzN08yOVJMcFZ6OFk1WVhpOEpld0NYVmFEa1NSUHR1ZGVHYUlobHN5dWNr?=
 =?utf-8?B?ajZuWGp6S3E0WmhoTDhGYlJLRWhBWlFXSU1EWHErZzhoakR6aWJUSklsWDB1?=
 =?utf-8?B?c1ZYam8rcFhuTHI4TG9WZnVqdTNHdmhpNVZqUG1jb3BZNVBWZHhVdkFUL2tY?=
 =?utf-8?B?eWJjRFZQVFZNYlhwM0gzZDF6aDBCOGFjL2tkWldxY3NKRjllU0tJS0NWT3Na?=
 =?utf-8?B?WEluYTJURm1xSHBudEVmcktPdVUyYjAyQ05yU0lkTkVtN2hSazZ5VXdKNkNh?=
 =?utf-8?B?blB2QXhPcS9WNkhaajRlMTdYQ1AyOHI5T0R6RTI0SzNKMjVjWTZmY1dzQVV1?=
 =?utf-8?B?MzdGN0ZIUDV3OVFtYUhYV2VvTmFhejM5MUxKRXY4a1l0Nk1Ya2tkam83L3dn?=
 =?utf-8?B?WnpJTmh1OGgyaUdCb1gxV0dwRW5USlIzaHlKZkdNOXJteUE4SENCQ1FtZXF4?=
 =?utf-8?B?OTliQ1RONkRzdVd6VXB3TzFZODdEcmpxTkJFOW40ZzdzU2o4L081RDFtcnd6?=
 =?utf-8?B?RUo3ZEc1WFZLODdYL01XQkVvaUc4bzFRZk9xL1lUcEU2TG5JL0psVGQ3Q3pR?=
 =?utf-8?B?RVZXQXNCenNTUGdOcmpFRFVROFZXc3M5RkJKQ0R0TmVIdWNKK3VYczFEQ1Y1?=
 =?utf-8?B?b2Mzc2hpVk93VEV0QzJwKzF4VE1NRFBjSG0yclI2bUpEUVRJYUQ3VitldWp3?=
 =?utf-8?B?RFJyU2Y4NnJhdVdtMTJUYWtzeU9oMklCVHRUb29UdktzQ1Vzc3pPb2tlMmtF?=
 =?utf-8?B?dmZGNnVXQWdjTDQydzJ5ak01SDZyeVc5elNoWVZBejlNdDVIQnZpSm00dk5T?=
 =?utf-8?B?dDlVSVgxNzAwZDhFMjFIU1UwNHpONXpUNDlIMlRuNmx3Nkhibk53M25yd1pR?=
 =?utf-8?B?cFFrakFqWGwza3VZU2VLTVk1TkF2VXZMcWE1dTcyVFBrbFpUbGFjRXpQNGww?=
 =?utf-8?B?WENqRURFTSt2aDJtTlhUZlRJK2pzT2pPWkEwamNzQTNnYnIvRm1rdkJOWEk5?=
 =?utf-8?B?VXVkRjd3SFk3eXZMcWd4bmtCbi90OS8vUWRIVjNpcFhkZ1ZoVnpaQWVqaUdv?=
 =?utf-8?B?amJBT3lRUjZOQUxYTi9iaEdYRUxjb24xM1JCSGJKTWxiUVFDbFNwaUZjSVV5?=
 =?utf-8?B?c3FkZjVmNVdYRHdEMzZMYTdoTkxpZG8xSE1ENndlcU5TZHAyTEJkcEd6QlBD?=
 =?utf-8?B?NHlkRXpGZTBCbXhIKzRLWXZySzNzRFk4YVU1MHYvWnh6LzFVYWpFWTRpL3hZ?=
 =?utf-8?B?QW42bWhhOWxFTy9xU3JVK1RjU1NlU285ODZkMldEdHkwQ2VjMjVBL0dpRDhW?=
 =?utf-8?B?NFd0Z2w2NG0zeklibkJ5Y1kwd0NDblZkajd2OFhLUnFtZCs4ZU1LU0VtTStP?=
 =?utf-8?B?YVVnalBxdThoMktYc1Y3andwWlQ3alNYMnkyeVNrSUdlNU4rQ2ZRS2w5WUd4?=
 =?utf-8?B?Uk1BbmpwV3FZTnNPNzcwMzdIanNSM3hDbGN5Vy9yUHVjalpMcFNCTVoya0NK?=
 =?utf-8?B?N1QranNkTHQ3amhtUWlwS2MwY3l0UWwzQTY2VjBoM015UmpPOTd0T1MzcW11?=
 =?utf-8?B?K212aXljU0FDOXhkR3A5ZVl4R3FuVHF0RlZ1T0h3SXJXRXAyZDlWVFMzWTN4?=
 =?utf-8?B?TGhtWXl3NkxjSyswc1ppRHhBUzR4S2J0MUNjVUR3bGhQMGk4STFtWDBUUU95?=
 =?utf-8?B?dXk3QnRuS2ZQN25maE5VQXl1V0h3eVlQZFdJOExPT1pjYmdJYTlZUGRrdUp2?=
 =?utf-8?B?T0g1bncwT092WWF2aWFZc25oc2dYTm0yYURNcjh4V2I4c3pJSVczSm52UExv?=
 =?utf-8?B?cERSVjFTK1JKZjlySzNUUHNWVHNqeG5TTWZIWWQvYXF5NzIvVmVjWHViV3lJ?=
 =?utf-8?Q?x3YLAQS0YqzvSphnX4kqwtUzQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cfad73-f2ff-4f26-dfc3-08dc1d1bf44f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 20:35:08.1451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dasq5B5F79VDZHdFD4RYHvk4qTmi0xUdUqqEnmCqNV2F0bkIjrdXBimU9g3u+Y4ZKnbUlMr+JyIF229NECT5Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8145
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

On 1/15/2024 13:07, Jay Cornwall wrote:
> This instruction has no functional difference to S_ENDPGM
> but allows performance counters to track save events correctly.
> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     | 14 +++++++-------
>  .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm |  2 +-
>  .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm  |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> index df75863393fc..d1caaf0e6a7c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -674,7 +674,7 @@ static const uint32_t cwsr_trap_gfx9_hex[] = {
>  	0x86ea6a6a, 0x8f6e837a,
>  	0xb96ee0c2, 0xbf800002,
>  	0xb97a0002, 0xbf8a0000,
> -	0xbe801f6c, 0xbf810000,
> +	0xbe801f6c, 0xbf9b0000,
>  };
>  
>  static const uint32_t cwsr_trap_nv1x_hex[] = {
> @@ -1091,7 +1091,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] = {
>  	0xb9eef807, 0x876dff6d,
>  	0x0000ffff, 0x87fe7e7e,
>  	0x87ea6a6a, 0xb9faf802,
> -	0xbe80226c, 0xbf810000,
> +	0xbe80226c, 0xbf9b0000,
>  	0xbf9f0000, 0xbf9f0000,
>  	0xbf9f0000, 0xbf9f0000,
>  	0xbf9f0000, 0x00000000,
> @@ -1574,7 +1574,7 @@ static const uint32_t cwsr_trap_arcturus_hex[] = {
>  	0x86ea6a6a, 0x8f6e837a,
>  	0xb96ee0c2, 0xbf800002,
>  	0xb97a0002, 0xbf8a0000,
> -	0xbe801f6c, 0xbf810000,
> +	0xbe801f6c, 0xbf9b0000,
>  };
>  
>  static const uint32_t cwsr_trap_aldebaran_hex[] = {
> @@ -2065,7 +2065,7 @@ static const uint32_t cwsr_trap_aldebaran_hex[] = {
>  	0x86ea6a6a, 0x8f6e837a,
>  	0xb96ee0c2, 0xbf800002,
>  	0xb97a0002, 0xbf8a0000,
> -	0xbe801f6c, 0xbf810000,
> +	0xbe801f6c, 0xbf9b0000,
>  };
>  
>  static const uint32_t cwsr_trap_gfx10_hex[] = {
> @@ -2500,7 +2500,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] = {
>  	0x876dff6d, 0x0000ffff,
>  	0x87fe7e7e, 0x87ea6a6a,
>  	0xb9faf802, 0xbe80226c,
> -	0xbf810000, 0xbf9f0000,
> +	0xbf9b0000, 0xbf9f0000,
>  	0xbf9f0000, 0xbf9f0000,
>  	0xbf9f0000, 0xbf9f0000,
>  };
> @@ -2944,7 +2944,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] = {
>  	0xb8eef802, 0xbf0d866e,
>  	0xbfa20002, 0xb97af802,
>  	0xbe80486c, 0xb97af802,
> -	0xbe804a6c, 0xbfb00000,
> +	0xbe804a6c, 0xbfb10000,
>  	0xbf9f0000, 0xbf9f0000,
>  	0xbf9f0000, 0xbf9f0000,
>  	0xbf9f0000, 0x00000000,
> @@ -3436,5 +3436,5 @@ static const uint32_t cwsr_trap_gfx9_4_3_hex[] = {
>  	0x86ea6a6a, 0x8f6e837a,
>  	0xb96ee0c2, 0xbf800002,
>  	0xb97a0002, 0xbf8a0000,
> -	0xbe801f6c, 0xbf810000,
> +	0xbe801f6c, 0xbf9b0000,
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> index e0140df0b0ec..71b3dc0c7363 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> @@ -1104,7 +1104,7 @@ L_RETURN_WITHOUT_PRIV:
>  	s_rfe_b64	s_restore_pc_lo						//Return to the main shader program and resume execution
>  
>  L_END_PGM:
> -	s_endpgm
> +	s_endpgm_saved
>  end
>  
>  function write_hwreg_to_mem(s, s_rsrc, s_mem_offset)
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
> index e506411ad28a..bb26338204f4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm
> @@ -921,7 +921,7 @@ L_RESTORE:
>  /*			the END						  */
>  /**************************************************************************/
>  L_END_PGM:
> -    s_endpgm
> +    s_endpgm_saved
>  
>  end
>  

Ping. Patch has been tested and verified, just looking for an Ack.
