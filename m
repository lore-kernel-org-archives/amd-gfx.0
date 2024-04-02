Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF89CD128D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 11:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C90210FC9A;
	Tue,  2 Apr 2024 11:56:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O8DiYC84";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2134.outbound.protection.outlook.com [40.107.92.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55EEA10FC9A
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 11:56:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdmVTqiNx2iB5TZrAI6QmjPVYk4aq4jLDp81sItCcsOV8NGjO+i7aiC9vg2qUdY0t8q+vg4WLiaaKrOd346laojDQRle1J6SOwfnGXy/wUuQl2rokV+JRoWKhSd1n9TlrfEHTy+GzKZCp+eXDtEB4JiOe7Hx5YYhek3hTTcPM7/tCTQ5oN4GTIhxBlubxdkzBZnqC9FCEbjQoDjofvVMyW1pe5I2kCXQ5tIEX9sENCxHwBlcGDNXpBHTnVS4B1OxmP2hkrMUaOYx0MgLEeuqXxTmmocS1lqz5tDwq4JnhdLWLGgl8q0EaO5Hqk3ZfIUqrOVEErA0IDy3GkF0UTylbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkyooXTnZUGv+KYI9Q3hOdGRt+QWQgFvGT6CtYxskes=;
 b=GjIQNfQNE3sLX61M4LofIL5ueAvJXhXWeEju6ddtP2PWQRCNN7XjcC8pK7OkQWjTRf/W0+j13ojzoKaS0I+ksmu+ugmMnyCW+pBN6bzPlbEkMBit6l12FSfH1v6JX9ymhbWkS2wFeXYnDVL5ztQcLGKO87eYiEfYDSRSr3FbdPNhKbmGcd1lNSX92KDcDWzyXMp7uB73phwk4jmtLKsCnzrQrv7y7UE4al3Rp4QDk7ahf2Q8+9ZGUfnWSU6hAu/tA0GpEYVaCGVgniav1uS2hEp7S7fVe62Wxd0CZ9ak/h5JkCDtUhKJ0++h3bTPBP/gB9jAo+LiX/9dTiy6kL/T0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkyooXTnZUGv+KYI9Q3hOdGRt+QWQgFvGT6CtYxskes=;
 b=O8DiYC84vMWGl8fWwLvRNDHKrTmRF1XMKaKPVd7IS+F/DkgjSpCOISMzlg5Bb+YQRPrHW/LfaiL3059o8XvbeB5kfwJ/CIm4gYR9buV11Ch+v7pVTxDiJ6Mu30tuK2JhwltKZoSRjxbuvB9R6/lMz5Zr4s1HI18oTDX4SVrqCcs=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:55:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:55:58 +0000
Message-ID: <635b5592-c3fd-49f5-b9ea-402a01f70ee0@amd.com>
Date: Tue, 2 Apr 2024 13:55:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix discovery initialization failure
 during pci rescan
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
References: <20240402100552.3164095-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240402100552.3164095-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0208.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6438:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIYMuzvosJOOPJhiybMWsG1+ulMzDZe0fFh+/gSzjkFPo+wKTB70mi0khM7ZTmMJzeJJ04pCWm3pq6dryIC3AYTH7eLGRST80F5UZGJA6i3RT0geFaLtvwI0AaWW9RV6inHL/xZ1yK6opOmen7K5WmG00VgeSvXAD58PnesKrJerr+78f+Qx2MYUIVgm5xRbqhLAa4zZdqMgHfVVxfNy23uefxu//KGUwmR/y4PJZphNKUb6scQG4UEe+ewXh4eEghRoMSWdwSDncaNvK5iVqYB1R35s97ma2TM+UG8sHJdC2gyz+h+zaSRy5LI5yTslloVl651JKidXP7NiUBoPiCVlBmuXHyRGS/VvYI4ltqdedz7frFTHwr6zWlKvfJx/BsL+0h2tzQFJz8pMV8Oq7hvmngKbogzvzXJnAOJFN4xCFoQE3mPa+hifeocrbCi09stYSt9cpKPAh0/qaJAWfKW9OdWBVXnLmg43hgWDAPVg3Dww19XjmSgSAfuPdmWOOvmNxV7gnPUh/nVGFDgtokhBeNvKuReoHhGqWK7oqmybnXigMpK6+E4yC62OgP0mNCo8IQjhc0vAfzOqnYVigwFJuIOj5eknlp4XBZTZxR7jHCoCagkOOQvJNaDrwWHcO/qFwhmgutbotUZDyQVhsHE8o4X3Oe4el6gjZVE3BzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHdBU3E1Mm9oVUluc2Z5cWMyNW1qSFl1eGxBRWpwSCtzUUdOVXZ2eXl2WUxi?=
 =?utf-8?B?NU4yQjJNdzlNdGY0WU5SR21hY1B1dG1wWExDTHZsNi9rL0poZUhxM3UzRDJW?=
 =?utf-8?B?WWh2ZEh1TDRuMWJJVlNkd1R6MGtaMEZaTGVvZ0pGR205Tko5SUdBLzFuU0dI?=
 =?utf-8?B?MkpQNDRoZ3ZkT3pBOVU5R3I2UUI3OFlNZ0l2SEN4cTJmbFVCNE1HRCtaaU5B?=
 =?utf-8?B?bUUzcXpqTzVObHhXL2IwR3FNejFtbVZ4ejc1eCtTVC9GUmkwTWowRlh0aW9V?=
 =?utf-8?B?ZzNNejl3L0Y4ak5Lc1B0UGhCeFFrbS9GUFhFWGZyRGlHVW05RUxjWFZ1Y2oz?=
 =?utf-8?B?bjZBdENwM0dvUWFNWDZaVmo1VGpHYW1kNURVVE9xSFU2VXYxQnRFeUc4cjVC?=
 =?utf-8?B?Y3ZESzR5eXdxWmJVb3ZRM0Jlelp3VXc0Y2JFdDI1R053L2JYS2V5dnRpa2JO?=
 =?utf-8?B?RmJzSHBXWDdaWmJDZWcyb2FQdEFrd1M2YzZkQktpZGxZSzlyMGt1MjRpK1Vw?=
 =?utf-8?B?T3E1MFlnWFZsYkR0aUJ5VDNkSitoR1gyMWRtcnIwd0Y5U3hMa1RjKzQvRnJV?=
 =?utf-8?B?d3ZlRWFlczVvUEZTYmlYb0QyTGlwVlFSTUR4bCtxck1oTzJzT09zSm15bENq?=
 =?utf-8?B?SHpTa3QzdEpRbjlRWVpCNEhQWktyK1R2TXlETlNTVWJ2N1ZXNjNXbDZ0QWlB?=
 =?utf-8?B?YTNVTzRXd0o4Z05zRXNvYlQ5bWw2SCs3NitiZlBJdlNLSVJ1UGVLaGVSVDZD?=
 =?utf-8?B?RlVtMmpkSk8za2JDMUxBS2VqZVRjNVF3QWJtQ3JCMk0xdEdiUXIwK3QzQUZL?=
 =?utf-8?B?bm0wSU4vOHhDVTZEOUhDTmJhaENkbUEyVVJsdExLWU4yUk00eUJVUC9SWUhu?=
 =?utf-8?B?aXUwcmV1L0RlNldheDY4NHFJdG05ZWJmMFZSTkJhZGExbEt1VXY3YW80WWpO?=
 =?utf-8?B?V2xmOHhJZTE1S1lZWUppazdDQWpSMHA0SWdUaWpkTE52N2tsRnd1bkRrZG15?=
 =?utf-8?B?Qlk2bUJkUCtXNVg3cFRVWnQ3U09pdGt2SE1vYTNEVXVLeDBKaVJUVU1pTDB5?=
 =?utf-8?B?Wms0VnR1a0xqeUorSDBqcXFqZmtpREdBM01aT1dKMVU1dEF6bGJpQ1RsdWtV?=
 =?utf-8?B?WHdJM3FvOXFvWU9xVWNBZEhicUJtak8rVFJWbG9lcU52YWttSEpNRG1ZVU1i?=
 =?utf-8?B?LzF4VHNCOWVhYVZ3WlFYTS96cklueEc0eUFEdmtHT0dtTXpEdEZFZ2tJN3RW?=
 =?utf-8?B?eDZqaWNGdjZ5ak4wYVVkcEJXOWpsSEJDcHZubzdVcm8wVmF6V21yclhFaVRC?=
 =?utf-8?B?U1UxTUE4Y0JNOGF6ZFhSaU01cUV1dU9OM1BFbDNNQ05NR1U3VlVnRCt5dnJM?=
 =?utf-8?B?TTVlczN3ZGQ2VjFoZmdOWFh6MXAyQXBodDJrUlQzS2xucTdoQUh3VU5TWW9X?=
 =?utf-8?B?MGZ2RGdraWVuaEhTZDk2bWRNU0ZOQ2Rwd0RjcGM0cWJBUDAvc2dVVGdSRHB2?=
 =?utf-8?B?cnNTYVlXRFNZK0lhZWkzU2YzQ2tTb2xvZ1VvNVBjbDRDQ2JEQkNzQVdrYjdu?=
 =?utf-8?B?QWRLQmNzdFUvL3g0T1EzZDJjc2E0WDJxUnpjWjFwbFNjSXExdFZuaER3aUQw?=
 =?utf-8?B?WDlFRmxMWkZvUFBKVk1zK1dnTzM1TS9BTllsMU5zZGx4dWI5U1dpQmFleFFZ?=
 =?utf-8?B?ZkRjRnVZeFZsUncvKy9qL1QxRlVPSERlQUhSM2NKaURUSDJTaEFRSSt5NFE2?=
 =?utf-8?B?UDJLbEgySEtyL0pCcFo5MnFNOTlBeDNRMUV3VGdPWXBFK1NISU1wNnhsbzYx?=
 =?utf-8?B?YWhyMks5Sk1MbytsOERPNVNZQVN4SXczMnBzY1BHaUMweFJkQU0rQ0w5dUJ2?=
 =?utf-8?B?UDNya0NzZHg1STNQNkk2Uy8rc0p0amFtZEs2aHoyTkhtZG1CT0xwVzNIdlN2?=
 =?utf-8?B?ZnZjVXVPTVQ1VER3alpLcS9JY1lNQVBEcTFaaWNWOEpoYlJieDZGS29ZbC9M?=
 =?utf-8?B?NEd5azJCbVkrODZNZ2xFWFF0NWovTitpRS8wUUljdUEzYWNrOWJXMUR1RHB5?=
 =?utf-8?B?ZDZpbURWQVAwNjFodzVpOXNvdHpUbWhkYTZoa1hKTUVEZ3ZWaEtOQVJBTHFE?=
 =?utf-8?Q?akSlYDFRDV7p7uYZ4BjuVwJix?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3562f9-3c66-4824-f013-08dc530bdbf6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:55:58.1141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4w5D71xIKzIsSoqfQEmleHqLL2k66cf4ixsAlv6cpQ2oFwMjHarKd+wVkavqP4iT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438
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

Am 02.04.24 um 12:05 schrieb Ma Jun:
> Waiting for system ready to fix the discovery initialization
> failure issue. This failure usually occurs when dGPU is removed
> and then rescanned via command line.
> It's caused by following two errors:
> [1] vram size is 0
> [2] wrong binary signature
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

I'm not an expert for that stuff, but using dev_is_removable() indeed 
seems to be incorrect here.

Feel free to add an Acked-by: Christian König 
<christian.koenig@amd.com>, but I would rather wait for Alex to come 
back from vacation and take a look as well.

Might be that I missed something why the dev_is_removable() check is 
mandatory or something like that.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 07c5fca06178..90735e966318 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -255,7 +255,6 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>   	uint64_t vram_size;
>   	u32 msg;
>   	int i, ret = 0;
> -	int ip_discovery_ver = 0;
>   
>   	/* It can take up to a second for IFWI init to complete on some dGPUs,
>   	 * but generally it should be in the 60-100ms range.  Normally this starts
> @@ -265,17 +264,13 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>   	 * continue.
>   	 */
>   
> -	ip_discovery_ver = RREG32(mmIP_DISCOVERY_VERSION);
> -	if ((dev_is_removable(&adev->pdev->dev)) ||
> -	    (ip_discovery_ver == IP_DISCOVERY_V2) ||
> -	    (ip_discovery_ver == IP_DISCOVERY_V4)) {
> -		for (i = 0; i < 1000; i++) {
> -			msg = RREG32(mmMP0_SMN_C2PMSG_33);
> -			if (msg & 0x80000000)
> -				break;
> -			msleep(1);
> -		}
> +	for (i = 0; i < 1000; i++) {
> +		msg = RREG32(mmMP0_SMN_C2PMSG_33);
> +		if (msg & 0x80000000)
> +			break;
> +		usleep_range(1000, 1100);
>   	}
> +
>   	vram_size = (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
>   
>   	if (vram_size) {

