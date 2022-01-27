Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D81C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 17:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2134D10E506;
	Thu, 27 Jan 2022 17:26:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD9C710E50E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 17:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jX/gaJlG6/mGtsLzbbWLBa6WCHVLbq/XzjX7jSFEiX2wBZ6ZhlydQHJR5qQe+Bk4fR7B8h48naru49V1+ui34J4EYGJothyzhVc36HbFEuQkN2BZcYAEkI4z4md8wOrJTy7J7fN5XP/lJl+ofpCBhUtTk4x1ROaBOGcwQtlR33Pf18b/1+wmG/WPxRGOLEhQrD4fsLzfNI1tzVy21sDpS5PyJp0whZUZxNzqhkB01dRMgfpS+dyUQ5Fc3S280ji+AwnhPjr7pQKTFwffMI3asu+1kt+uJ4TbCi6BGBjZdlCTgxVeaLSKv9NRzIYkFUa96asSnU8/REOz5jaTWdCZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX3AXtw0WP7qYRUdRqybU70txpFyG+iYbQj/IS5UElA=;
 b=TxH+1c6iTjQDHS8Fhcl6GGORabbFj9B5vUlL3Wa1bIsK7Q0cWErUFIgvuMhh0IIJEIgrICgKRIssnruustAf55+B2yL6ANMJy9ufoxbLKXZGe55T+Fs7IpyLjs4nDHtLpa2a8gL0q19eaXgj0LlhcsImtstp8krlIBKsnC+Fim+c7MBcEY1E48InPdIFMhwxTgjDLD+NCPu4WKkLuo7bOCm6c5QIJz9PkRzCnPuu9LacmT/KEFJ6sfWlG4kEf+G1oA6JajubXc2dMzbj6l1XSsxam/hosLTaRC6CCSQJD7QSSlDZHLaYi4eQUC0G/OO3N8jxMJmE+urTGRIF0GYPtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX3AXtw0WP7qYRUdRqybU70txpFyG+iYbQj/IS5UElA=;
 b=V4y/udviwJrv0hBhP4ZjyzGzgiTaDoz8qO/FrAi+A0CHgzgzvN9UVm0cNethRPnc0FDkDXjj5nSCezzwnXkTDgbFvxl/gbOp3+PS2j3S3J3pE5qIPWk26tfp/WRBY3GQ8TaDlAF6CTCQCctMBt+lXkyjWMmUcDlHDlQraDo3e+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DM4PR12MB5199.namprd12.prod.outlook.com (2603:10b6:5:396::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.18; Thu, 27 Jan 2022 17:26:17 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8%5]) with mapi id 15.20.4930.018; Thu, 27 Jan 2022
 17:26:17 +0000
Message-ID: <52fa6651-aa22-edab-432b-15028038ce15@amd.com>
Date: Thu, 27 Jan 2022 12:26:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] drm/amdgpu/swsmu/i2c: return an error if the SMU is not
 running
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220127172353.280369-1-alexander.deucher@amd.com>
 <20220127172353.280369-2-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220127172353.280369-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::6) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02956410-3cb6-4796-e112-08d9e1ba203b
X-MS-TrafficTypeDiagnostic: DM4PR12MB5199:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB519973720150462278D0633999219@DM4PR12MB5199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oImbMr5XZjI2Nc7Nek6XkAh3YcVGFl2tje7JDbpLnnbHUbSLPixkbqsPEMUQrabkMzo8ol4U3c8Q5kzyYv1DVIiENY7+ODtY1GMtHVCaRLs9ank4EqGR3NOVuikZ9gZS54QuJik/WSLAy8mK+5FLtWYeZiA1KksXFw8V8y8ltB43jm/tHLciP8jH2jnfqg2EUG1fOLDONBkjh/LO7E4M/rJ2XIogDAJW45uCwz4IGs4PIorg4DBLbq28X82JcfcN4/+ePgkalyCBksTkQ0Qa4fANIWAib3m3ZfYpGUoOcGQdxstAKqf9Lzzuias73Sqs9C0VA+GAk9lJBRAvSExXTZFWJBCUteEYvfL4Wmsb7mWCvSV6fn76ISNYOeLn78av8I95GnPQrTYc8+puGFFr47TQR7MawgfGcz8N1oSuWfT3mJEEk0S56XgTLpUOKJI2zsq1n8PWPIgw0YUgKsMyyTU3pA90NOnxWT4aPDZ1GLdAiXq1eLkItLjxflCmXcNVAIRYF2BlRktT09FIdpnlWV6rdXDYVJlbN83yXDDsZuq4a8NLN0Kc24gZAQ43eZriJ9mj4dzcbIHMAgD1QzdXvxhmQrvN7Aw0FPnKBMoyBL5K1Y/uL63gNHTriEf6k8nkT1um7cpqa7b5ynuIGHl7VfBN6R5DTWqqvQKk7eTcbEhKSxRjSo7WFdYMohBUbyeaxm+R9iF5gMsTsGRirBAnw0O5YsF8Fvnnnw7wmlVpIOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(6512007)(6506007)(31696002)(86362001)(316002)(508600001)(6666004)(66946007)(66476007)(6486002)(8676002)(8936002)(66556008)(44832011)(5660300002)(2906002)(31686004)(38100700002)(2616005)(26005)(186003)(36756003)(45980500001)(43740500002)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SExvdTk5a1dNL0FGUFpzNHN4VlZmNWtsZXVMMmhXbEdIa2QrSElTWUYzNlZB?=
 =?utf-8?B?WUdieUtXSUF1T0dyZVlWZnFwc0Z4OUR4QnpvL0xhQ1NqaHBEbmhqcTh4YURw?=
 =?utf-8?B?UzJacjY0RFFKWlZHMWFVT0wySXdjR0xTMy8vWVp3bmJmei9OVFBoZ292VFJV?=
 =?utf-8?B?d05tWVNqVnUvUHNGOTVtRnRGMWEzWGdLUDYzS0JySndaMW5vU2l2b1ZrdUxV?=
 =?utf-8?B?YzZ1Kytrb1lVaDNKcEVVUWpkWHFGL1lKVGZIblR1S2NpcXhIMXpmRVJKSWNz?=
 =?utf-8?B?Q0xLN09aYlJqV1Z0WlVHY0MyeHAxeWNPd1NHMmNrWGd2bkdYUlpiOE85bE9S?=
 =?utf-8?B?bCs1MFBSSElRU2Q4VFZoWkp6ZlRnN3JHQ2RJRFY1TDcyMStqKzVmNUc2eFRP?=
 =?utf-8?B?ZTJtZzRiYldMcmJoOFdnYVMyWGo3clZ3R0N5TFVBbzljaWQ3WjBYQ0FwZzNT?=
 =?utf-8?B?V3lGNzJDWFZzSmFNdmJiMFh0N21YYnQrcndhYTd3WURQVUc2elZCR2Y5aThB?=
 =?utf-8?B?Qm9McHo0c2hUSm4vTDdpVmIzekFqRUV2TGR4ZTcyQ3dvT0ZDRXNmUTF3VUl4?=
 =?utf-8?B?OUpuMVY4dDM1ajNkaXlNQ1pSUkZiTGQvSHVKMHovcUtLdVJPNk5OYmswcVNV?=
 =?utf-8?B?Y3o5dTdGVSs3c24zKzBacWpGUmpZYnMyZWhsbVE2VGp1dndybzZVWG01dlFI?=
 =?utf-8?B?SjY0dWJCeEl5eE5wQWFpVHVVeUwwd0ppQ2pidysyMmM3cGI2QjZ0KzYxdktI?=
 =?utf-8?B?c0hLWlpnYVpCMU9pMXg1Z0RrNzAyT1VjVmhoT0I4RjlEYjlYVkNNbmVMay8r?=
 =?utf-8?B?YklYZjY2N0NCaFFZcVdCMlBJUktTd1k2YmJFT0hORWE5TGZKYlNRRFVKdCsz?=
 =?utf-8?B?OGVGckowWmVyYThHdENDRzBuOGxhU2ZuNGU0cENENEM3SG8rWS85bFNPK3Nr?=
 =?utf-8?B?RWpXTnR2TVVDVi9WSTV1clpoczBPa1pWaHFwblRiVFVwdGY1YzQvUUhJRk5n?=
 =?utf-8?B?OWZROTB1QUJ2Y0NEUWtydUhkM0w5b3FGcXNxRDZaNHdVY2pqald6ZnYwZzRF?=
 =?utf-8?B?VTFNbERyV040LzFiOXdHdUVTb0FYcitrdUhza2NKYW5sUVQ1RVd6T2xnckJi?=
 =?utf-8?B?N3lCS3p3RVM2Z0NhbXR5MGMzZ3ZxTVlLbHdGdlB2SXBGSjF0UFNKQ2s4TS9F?=
 =?utf-8?B?UnpMN2dmdUxzbUQ4NlRUU200US9jdnIzdmdLMFZ1T0ZzT2ZOanJEVGdSZ2JU?=
 =?utf-8?B?eGRiR2pBeitTWm9KQ1k0RVJmWlRrTWtzbzQ1bEMwTGJVUC8vaFkzZlB1STc0?=
 =?utf-8?B?QjVmaU9QWno2UHYwdWd4RnNlZWhzYTRzcm9TZVJiZDVCQ1lqejJYUjdvVnlB?=
 =?utf-8?B?dmt0NkU1YWhrUHRtRCtQN1liMDR6TWkvNUhucTFDeDZHQnBBMEJRcEp5MDJP?=
 =?utf-8?B?emNPWGZiQlc4UlFiSklyR0dCNnh1MCtNZVFMZThQbjBQWHpjSktDQ0V3QUlq?=
 =?utf-8?B?N3U4eDV0MXBNSytYS1BVQTlsNTdRR2JKa0cwalFQbk5icVB1SmFoRUtCOHln?=
 =?utf-8?B?QWdocFZYNTdLa3lMZE1qNFBzS2lvL3ZHT2VTWTVtRER2Z0tFU1loWkU4djFE?=
 =?utf-8?B?T0psOG15c1ZudXJSYzVGdG5FZkJERVREK3M2WE1NT3lCYm85ZmExc0RNWHY3?=
 =?utf-8?B?NkxVT1JSSE1idGZVTElXdnFaRmltU29ZMml2dzNtYVBtWkZSWGJqOUVTYmZw?=
 =?utf-8?B?SFhMSlc2dmFoZ0ZJYlREN1ZYVXpodlRjUisvSU8xa3p1ODhWa0tBYXF3b2lk?=
 =?utf-8?B?dnZKUXA3bkJTQU5hZHgxRndIc3hzK1h2NjA5TVYrZDdnQzh6dGs5ZHRobjJK?=
 =?utf-8?B?ZmdvK3loY2RjR0dzUEY3Q3pxbDViUUtXelRqZUowd2xwcXFZMUI4K1hKVlRG?=
 =?utf-8?B?Qk5qMWVKeER1akRETDhKRmxzeUlzS0swYWhmOGNFYURkeGIvaFZrWEQvTUR3?=
 =?utf-8?B?SnNYOTdmRVJKZ3E3S0YwNUlqZmhNeHRMdFd4SU1zTmY0UDdxekhUcWxsVUtz?=
 =?utf-8?B?UDJQd3BDZkc0Z3ViR1VpQVh2UEdZQWhRRzBpRDVaNjRJcHllU3d1R0drVHFI?=
 =?utf-8?Q?yFog=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02956410-3cb6-4796-e112-08d9e1ba203b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:26:17.2472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AI6QDilTP/fRlQypSSvqMZ8dwkrax2b7ejFsBM/HjUDv2DHVj9wYC+Qw8T1iTlub
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5199
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

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 1/27/22 12:23, Alex Deucher wrote:
> Return an error if someone tries to use the i2c bus when the
> SMU is not running.  Otherwise we can end up sending commands
> to the SMU which will either get ignored or could cause other
> issues depending on what state the GPU and SMU are in.
>
> Cc: Luben.Tuikov@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 3 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 3 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 3 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c      | 3 +++
>  4 files changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 2c78d04d5611..bc20d0da4393 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -2070,6 +2070,9 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
>  	int i, j, r, c;
>  	u16 dir;
>  
> +	if (!adev->pm.dpm_enabled)
> +		return -EBUSY;
> +
>  	req = kzalloc(sizeof(*req), GFP_KERNEL);
>  	if (!req)
>  		return -ENOMEM;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 84834c24a7e9..47a75f9c453e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2754,6 +2754,9 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
>  	int i, j, r, c;
>  	u16 dir;
>  
> +	if (!adev->pm.dpm_enabled)
> +		return -EBUSY;
> +
>  	req = kzalloc(sizeof(*req), GFP_KERNEL);
>  	if (!req)
>  		return -ENOMEM;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 651fe748e423..bca622ca9af4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3449,6 +3449,9 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
>  	int i, j, r, c;
>  	u16 dir;
>  
> +	if (!adev->pm.dpm_enabled)
> +		return -EBUSY;
> +
>  	req = kzalloc(sizeof(*req), GFP_KERNEL);
>  	if (!req)
>  		return -ENOMEM;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 8c02adbf446a..08415de45e16 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1473,6 +1473,9 @@ static int aldebaran_i2c_xfer(struct i2c_adapter *i2c_adap,
>  	int i, j, r, c;
>  	u16 dir;
>  
> +	if (!adev->pm.dpm_enabled)
> +		return -EBUSY;
> +
>  	req = kzalloc(sizeof(*req), GFP_KERNEL);
>  	if (!req)
>  		return -ENOMEM;

Regards,
-- 
Luben

