Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C57BC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 088C3113913;
	Wed, 24 Apr 2024 08:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PQR/hOMk";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F0DA113913
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbWv1AWPHBFmlyE9KJZW3kLJpaxNAK18Uh3osQ100O7Pi/jZ3cVx4Hx8KTVx7o/mdPvnWMOYyxEBZzKSa7Jzb4GwBLyb67UOIAJ8ywptMTJJCxt5tyZaqysESpaOCa6CoI4w7tkOF3kDBajPV1bobxIRfwPGIpK1Gw1Tll5ijr5eJlL0XuOzJtXIv1t32g2J+Smwy25XXSnVUGJAPW5CQzYgmFZqXrif+ImynLsKFQRmwfoA8xvI8cbTAZTGjkkxHB21LEyX5VmlDqoln4uF2tgFPQbBeJR85O3CTV3bfXTirSuu39MisXC3JK7qXflrJWG6otZiBSsUWYe3e29ZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOV/4vq3c8xeIIBcX8BKCe8EQ5xOnlAKnVdfNmrn0F0=;
 b=fk4OzVsJP3tIwVHtNWzGLkrPOWU6FUwTx4sWwyRwPD2UZQxwrFU6LAopW9egahRyw67M7Z5mEoH4odq8Xt28tWiNDvRk7cIxJZTeLVbBxbdMckP+eEwBrv5iGF+V/xdrYWLqKMiZKqq3J3UgF+Uk6UEFGdUPJm691wz7n6gLRIa9Xxk239XoBW9SkZwzvS4DZHeuhOxdvZTPcHphLsCq6uhb+aiiD44POoEGEh3LmZ1V/iKOeZYx8VjWO0LabpP+sZTxFIL6U/my9M8FTHT9ryAo0OO9IazqM5c7oB0CA2ew9/EnE/WmSfydFOhuig22WnsEb4pPVatFA7aQOdUooQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOV/4vq3c8xeIIBcX8BKCe8EQ5xOnlAKnVdfNmrn0F0=;
 b=PQR/hOMkl30igX+1pEJMO90LZ+8EL4Z07+iDVEQQglDQ/JKAYL3HlZElahYcRRBjmyleI+5GS5FXob67lzjhZza4x3UEp4Oj6M46NpMVl3YJR+Gsn0uQazZYxLhLBgkowh3MnLMGscAwbP+Rv1jen+u1EYIT81midXm61B30Dk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 08:38:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 08:38:14 +0000
Message-ID: <5c3e3649-0d8f-4cee-a06b-90658d50ff3b@amd.com>
Date: Wed, 24 Apr 2024 10:38:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add return result for
 amdgpu_i2c_{get/put}_byte
To: Bob Zhou <bob.zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
References: <20240424075241.49101-1-bob.zhou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240424075241.49101-1-bob.zhou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: efd27bf9-20f6-460f-22ae-08dc6439e1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkFoMlhybUhmc251L2M2cUNVZVpEUFNqRmNWTU41OGJaTjE5U1JpMHE3WVJH?=
 =?utf-8?B?OGFBYks5TjUxZjhEZTNadGZEb3lmWDlHaU1meVVNaXdDaFdaSENsQmdxdGpq?=
 =?utf-8?B?MmVzL1g2TWRJOVkzSnJ0WmFMS0piUmx2U092ZHI3eHlCNXU2VU11bUJja2hS?=
 =?utf-8?B?S28vOHJUdUxkaHcra3V3ODJibHJhN3Z2WHVTQ3U5Y2djbUxqQUQwQ3lOblU1?=
 =?utf-8?B?aG9BRkdQUWRQQUtmNEtoREJBbzQxTFBZWHF3eitkYnFhdDQrRXZqU3EyVjRJ?=
 =?utf-8?B?Mk5MMUh2Q3N1UCtvcHk3eUpKNk9UM1dxU3d0bjd5ZEFsalAyUDlHQ0V5cWdI?=
 =?utf-8?B?Y1RQR3NtSFVRVTQ3K3A0cDBibFA4bGlpNzk2NmlCOUNtQUNHM0tHcXFDUkcw?=
 =?utf-8?B?SElScWhScWFUSzBGL203WHhEOHZiSUdXL3JHNE5XenRBc01SRGxxTDFLQ3RF?=
 =?utf-8?B?TlBLRG00akxWMUJZdS9kWUc3ZzY2UVE3ZGhWd29BS3FUQjVOM3c5YVlER2xl?=
 =?utf-8?B?Mkh0eThkUEcxNmpxUUFVcm5aOGFIWTJ4OGxkY1lDQnFCMDg2alIyeW56Q2FW?=
 =?utf-8?B?MmtrL2xkVGpJSHVnR3dhNVdyUEt0b3BoTWlIY2oxZDNBMEY4YjhIYTFpTHho?=
 =?utf-8?B?T3VwaXI4bVdYVFdqVlNBdDgwRmxkNmhTZGEzT0hQMTVrRlpLWnUvMjBNM1g0?=
 =?utf-8?B?Y0pHTmxndTlvTEUrOXd0elU4UTFjUnFxVFQybzZ3Z21ORXE3Q3A0QnovalRk?=
 =?utf-8?B?YlFlY3RuSGluQjJ0cXV0MzBETm8zMU1BSTJ1Q0RhVk5XQTNkZ2JiTWJCbURC?=
 =?utf-8?B?U2xGNDE0Nk5pMk5pSW02ekU3R1JDVGFXak5XS1RqZ3Jpdk9Sc2VzR3lZcnhT?=
 =?utf-8?B?RmVWM2txZm9uSzBxdG5UdUQxM2VSMThsVXpETDR6T0dBeTVHb1NETWJHdC96?=
 =?utf-8?B?L3JBVkd5VjVaV3Y3ajRuVEw4V09KSldjclZYNW5OQU9qaVRuYUd0UHFwNEFo?=
 =?utf-8?B?cDRONzJ5OEtkT25wR0N0bkVNUkhzVnpXUkpzc1Q1bnFISTJXbVhrbkZSYjR0?=
 =?utf-8?B?Tmh6WTVyR2E0TkgwV3M2Tkg5c3JDYkVKWUExWk9rdVZjMnlMMWpVN0FxVjBq?=
 =?utf-8?B?bUFNUHBiYm9ERDUxaG4vSUZJNDZaN00xYVVhMkVBMlJ0MklUV0FGY3N5RUsr?=
 =?utf-8?B?YkN6V3ROZmJLMlkzUlV6U2piZzhqRHdjZXZNOHU5RFFCTk5rVlQydWJRN3dH?=
 =?utf-8?B?UjZwY0xicUVEdVhwa1cvS1REbExlRFU1VDZSeWErSWJhR29GNG5Idm5MdHJI?=
 =?utf-8?B?L2xlT3ZRZ2x1d2dMVUhXYkxmQ1RRaFg2V1QwdEE3MFQxL3NFVUgwdU5Jb3Bw?=
 =?utf-8?B?RDFrK04vVkNRTjlub0pXZmd0bDN4UnNkZEhoaVUyV2kxUGZyNmVwQ1IyVG01?=
 =?utf-8?B?NnJLK1BOWXlKcW5pR3loc2UzV3o1Z1hTNXNGQi9LZUM0VWhKWlZhY3pwU2Zk?=
 =?utf-8?B?aUZUS1ZVL2t4bTJtb2hyWjNYSzUrU25hNkUxeC95RFhjNFpGQ0VOSFNUdnFI?=
 =?utf-8?B?S1p3M2g3T0p4elp2dXlIbWphR2sxd0puaG9rNnRFdnVYVmFKcDhBVEg5Vmd3?=
 =?utf-8?B?UEl4dFNtdzV6QS9XTExIcE5lR2lXVUVrd3BaMFdVTjJ0a2VWV3ZZazNrbFps?=
 =?utf-8?B?S3J2Wnc1V0MwcHBYdGs3Q0tpend1STllMFhjS3hEYW9YZDRKQ3Q4MXdnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2wyOHVRT1daQU5IQS9VdzRsS0NhWXEwZW5lU2xZOTZJQXpFaWhuREQ4cFlj?=
 =?utf-8?B?NndGT0xhZGU2U1YrVE8vdkhrWThNQy9tbkJpSTBrWUs2RWpBYWh5aWQ3SDdL?=
 =?utf-8?B?bU0zM01BSGxUSURoVGVBb3lpWFZ5VVlWR2o2SzV3R01oQ3k2Y20rSmMyZ0dV?=
 =?utf-8?B?eEZGcVVqcWpKWjZ1ek56ZHlJdTBjUDdUZ1VCdTJPTC83R253RW9FV3FZa2h3?=
 =?utf-8?B?RGhaT0QzYzUyQ1FvUTAyZUN6SHc4VmNYUzBEMmd6K29idDlFUjI2WkFKeVp3?=
 =?utf-8?B?d2MrR0hiUSt5SWU5VWo4T0p1UlNDRkRZZGc1NXlvTFFsb2NIbXRGSUt0eFlX?=
 =?utf-8?B?aUdIM3RBbmNvbzE1VUZNVnZ0U3FXd09rSysyYmRhYTJrbWdnaXd6dGV6aTJF?=
 =?utf-8?B?TnVjTFJWaUx1RzdnY0UrMHJDSW5kcURUeGVHWFpkVkFMa0hsbys4YkkxM2hQ?=
 =?utf-8?B?aVVzVjRRVXRqSGs1ci9KbWlZYW9zS0VCYWJQR1N3ZVc2QU8zL285NUVMd21S?=
 =?utf-8?B?Yy8xZFNEeHcyK0dJdTRUSU00NmtrVy9IcWdzK3lzWWpOK3V2QUZuRmNYR1BT?=
 =?utf-8?B?NFdwNUYvN2JidUVIbUs4L0huZ3FGOEw0Y1lXVnAxMEtqTXMxSi9PNHorcGgr?=
 =?utf-8?B?eGJrTWdGL1NMU0VKMmN1cWdKY25rTzh4bm9RTzM5WXF0VjdaUk9iY1EyTkZT?=
 =?utf-8?B?b1kwNUhFTlg3T1RFKzQvMTJ2UVRKRXZyZ0lRUkJRT1BTam5UdjNNQVhwZk9W?=
 =?utf-8?B?WjJoamtYVU04WXRpR2ZQZkh3QmYrUXAycTZNUnVTS2hWUE16ZlNQNW1vdHRh?=
 =?utf-8?B?VEZMZldZR3E1dFpvZFB4d0tad1VEVkZySnVGWUVPMXZuYWlFUzVqREVKUjVG?=
 =?utf-8?B?aDBDNDFZeGR1bVhLU29aK0dwMWlmL0hrNWJQT3A0MlFDRmF0VVJFVUcvNzFs?=
 =?utf-8?B?TC9mUzhNdnVRNldiZThJdGY1ZjN1dVJGYzRCdy9SNzZCWWg1YlA5SDF2MDlC?=
 =?utf-8?B?Njh1bCtpYStNTWhvZkc5S0JKN1AwYW5PRlZzc1BBSHlkR3F0c1A1OGo2b3ZU?=
 =?utf-8?B?SHlvbVZlRHhTVFNnZUpGVkU4OUVxVEdoOWhkdWlpWlQwWmo5SDREQjM1NnZ2?=
 =?utf-8?B?WHp1U3RLS3RGelVieXBLZ3RLNnFWY0M5K1VkZWdReGdMUUpsL2o4QTRMNHJy?=
 =?utf-8?B?UjBLNHhZTjJBWXJqYkplWWVwVVdMMi83VHhzWVZ6RmxZd2ZrWEdock5Uc1Js?=
 =?utf-8?B?YUdIS2hzUjRXWTJna3laSEFkZlhOeGQxYTl5alc1YlJLY05vZ3FmVlh6ejl5?=
 =?utf-8?B?My9ZdzBCR082ZlNiaTg5dDhzNTYzQ3pvR1Z1WDdrVHJJL2xxWURETmFPOS92?=
 =?utf-8?B?UkZOZjVQL2VsWW1wYk1BRCtIdXNoUGRGd29XYlpUb25lNFNxMEZMSWtyUCtY?=
 =?utf-8?B?VzllbExGaGxyNGpBcXVFUGd5YVlycEVkYkhONzlxMFJYRmR0WlpZY2tKUFZL?=
 =?utf-8?B?a21RSEZqY0dZU1RZN0FEakRxcUU2MkZlNGd5bHU4NDVuVGhsOFR4U0prcEoy?=
 =?utf-8?B?WmFTVER0cTZpZnVYaVBKOEt3UU1ncTVnNk5UcXdZVkd5b0JscmNSaWFwZ2NP?=
 =?utf-8?B?WEVxaWdGdWoyaFA3N0t0QzhHMCtQa1RmSEIwUkVlYzQyVmwxeUc0MGtCRW5p?=
 =?utf-8?B?VXFxU3oxRTRBVlhjL0VlZDRHcFU2Smk1WStTVFkzRVkyRVNMdHVDdEdwcU5i?=
 =?utf-8?B?Rk1jTW5pdXNMZlBGU0Z3eC9WVzFnZnlnbTBWb3UyQVpFaEdRMjI2a2lxOGZS?=
 =?utf-8?B?WTN6KzFvcEhpUFJQck8zVE5aSEVlQTlTYWxFem85MENraUdtNjYwRHV4TEVD?=
 =?utf-8?B?Y1lseldsV0FxWmNnQmZCSFQ2TkpvdElXUzR0RTRML2lncXp0VzdLd0xhQ29T?=
 =?utf-8?B?VkZTSGVicEZCK1MweGxxYStzN0ZpQUhJUXdLb3pvL0h6YzBlQ0c3UDJhQW43?=
 =?utf-8?B?MjFCaFZGUldaL2crbXNZSmxCQzMvVWxVbFVNcU9TTzJuL003Z1daYjFiUnQx?=
 =?utf-8?B?TlVMUlFvTzdCVTRUeVNUaDN0M09DSFpvclBnbVczakRrTUlVRmR0NUtMNFpt?=
 =?utf-8?Q?V011+8yvPWgZHFhf5rNhIyHhh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd27bf9-20f6-460f-22ae-08dc6439e1ef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:38:14.7561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRADZUE0HbTi45Br+HhL0tSWXC7IfEg/EVVXqbfqeklDSqZi/x12Q+DKdUXtbqQk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
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

Am 24.04.24 um 09:52 schrieb Bob Zhou:
> After amdgpu_i2c_get_byte fail, amdgpu_i2c_put_byte shouldn't be
> conducted to put wrong value.
> So return and check the i2c transfer result.
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>

Looks good in general, just some coding style comments below.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c | 42 +++++++++++++++----------
>   1 file changed, 26 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> index 82608df43396..c588704d56a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> @@ -280,11 +280,12 @@ amdgpu_i2c_lookup(struct amdgpu_device *adev,
>   	return NULL;
>   }
>   
> -static void amdgpu_i2c_get_byte(struct amdgpu_i2c_chan *i2c_bus,
> +static int amdgpu_i2c_get_byte(struct amdgpu_i2c_chan *i2c_bus,
>   				 u8 slave_addr,
>   				 u8 addr,
>   				 u8 *val)
>   {
> +	int r = 0;

BTW: Short variables like i and r should be declared last. I don't care 
much about that personally, but some upstream maintainers insist on that.

And never initialize a variable if you don't need it. This will be 
complained about by automated checkers as well.

>   	u8 out_buf[2];
>   	u8 in_buf[2];
>   	struct i2c_msg msgs[] = {
> @@ -309,16 +310,18 @@ static void amdgpu_i2c_get_byte(struct amdgpu_i2c_chan *i2c_bus,
>   		*val = in_buf[0];
>   		DRM_DEBUG("val = 0x%02x\n", *val);
>   	} else {
> -		DRM_DEBUG("i2c 0x%02x 0x%02x read failed\n",
> -			  addr, *val);
> +		r = -EIO;
> +		DRM_DEBUG("i2c 0x%02x 0x%02x read failed\n", addr, *val);
>   	}
> +	return r;

Better to write it like this:

if (error_condition) {
     DRM_DEBUG("i2c 0x%02x read failed\n", addr);
     return -EIO)
}

*val = in_buf[0];
DRM_DEBUG("val = 0x%02x\n", *val);

Printing *val in the error condition will result in use of uninitialized 
value as well.

>   }
>   
> -static void amdgpu_i2c_put_byte(struct amdgpu_i2c_chan *i2c_bus,
> +static int amdgpu_i2c_put_byte(struct amdgpu_i2c_chan *i2c_bus,
>   				 u8 slave_addr,
>   				 u8 addr,
>   				 u8 val)
>   {
> +	int r = 0;
>   	uint8_t out_buf[2];
>   	struct i2c_msg msg = {
>   		.addr = slave_addr,
> @@ -330,9 +333,12 @@ static void amdgpu_i2c_put_byte(struct amdgpu_i2c_chan *i2c_bus,
>   	out_buf[0] = addr;
>   	out_buf[1] = val;
>   
> -	if (i2c_transfer(&i2c_bus->adapter, &msg, 1) != 1)
> -		DRM_DEBUG("i2c 0x%02x 0x%02x write failed\n",
> -			  addr, val);
> +	if (i2c_transfer(&i2c_bus->adapter, &msg, 1) != 1) {
> +		r = -EIO;
> +		DRM_DEBUG("i2c 0x%02x 0x%02x write failed\n", addr, val);
> +	}
> +
> +	return r;

Same here. As long as you don't have anything to cleanup just use 
"return -EIO" and "return 0;" directly.

Regards,
Christian.

>   }
>   
>   /* ddc router switching */
> @@ -347,16 +353,18 @@ amdgpu_i2c_router_select_ddc_port(const struct amdgpu_connector *amdgpu_connecto
>   	if (!amdgpu_connector->router_bus)
>   		return;
>   
> -	amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
> +	if (amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
>   			    amdgpu_connector->router.i2c_addr,
> -			    0x3, &val);
> +			    0x3, &val))
> +		return;
>   	val &= ~amdgpu_connector->router.ddc_mux_control_pin;
>   	amdgpu_i2c_put_byte(amdgpu_connector->router_bus,
>   			    amdgpu_connector->router.i2c_addr,
>   			    0x3, val);
> -	amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
> +	if (amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
>   			    amdgpu_connector->router.i2c_addr,
> -			    0x1, &val);
> +			    0x1, &val))
> +		return;
>   	val &= ~amdgpu_connector->router.ddc_mux_control_pin;
>   	val |= amdgpu_connector->router.ddc_mux_state;
>   	amdgpu_i2c_put_byte(amdgpu_connector->router_bus,
> @@ -368,7 +376,7 @@ amdgpu_i2c_router_select_ddc_port(const struct amdgpu_connector *amdgpu_connecto
>   void
>   amdgpu_i2c_router_select_cd_port(const struct amdgpu_connector *amdgpu_connector)
>   {
> -	u8 val;
> +	u8 val = 0;
>   
>   	if (!amdgpu_connector->router.cd_valid)
>   		return;
> @@ -376,16 +384,18 @@ amdgpu_i2c_router_select_cd_port(const struct amdgpu_connector *amdgpu_connector
>   	if (!amdgpu_connector->router_bus)
>   		return;
>   
> -	amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
> +	if (amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
>   			    amdgpu_connector->router.i2c_addr,
> -			    0x3, &val);
> +			    0x3, &val))
> +		return;
>   	val &= ~amdgpu_connector->router.cd_mux_control_pin;
>   	amdgpu_i2c_put_byte(amdgpu_connector->router_bus,
>   			    amdgpu_connector->router.i2c_addr,
>   			    0x3, val);
> -	amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
> +	if (amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
>   			    amdgpu_connector->router.i2c_addr,
> -			    0x1, &val);
> +			    0x1, &val))
> +		return;
>   	val &= ~amdgpu_connector->router.cd_mux_control_pin;
>   	val |= amdgpu_connector->router.cd_mux_state;
>   	amdgpu_i2c_put_byte(amdgpu_connector->router_bus,

