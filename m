Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269F0C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jan 2022 16:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 806D710E24C;
	Tue, 25 Jan 2022 16:24:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E25410E24C
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jan 2022 16:24:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvieHJZ+KOIfuuqVJsnaj7vBNVuP/vciJ21/BYfTHCkOpPATCH7Ul9b5ATWa/z/bd+A5ZDotT9GIJbVknL1u+0n2peFty6dk0hDtNq3606clKuE2fjU5NRjLNuVyFshJGYoE4RtcTYaAkq7rC9w7aIeZsO3WRFjf97ih6P2qfqaddX/vZ/mAQFUCUl0A1QGdLpKwI95y5XMgMrJAO9phZmiOsiTzuZldTsWpJAmeRf5USROZsvYKgEiJ4lFGgW/at008q3UR2Ly9u39lRiDHBLRwfiSbzcLfb+3blkrltEhd3159bqgyfBAwXD/Xs9QLN0+7XPh5kxyz4kovnh9WTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G964gytrPeiWVZB1VXj7xvqHNgGTOvhs9i7/A/WRkpU=;
 b=dpv8KXYigI1zAFfCj6SV/ElCHWc8FBGS5SdZGO2SrmAvwNOqwwGp7VL/6PhSrQxqDL8lw2niBjSLJFqvh9WxkcHt8nKauAlz/BnDc9qFPIm6ePlE2ymm53x1MHJJncmhRyxIWlCpFGeXMDNZDM1Fr51+PnUckZivn7J/w1hKhRuuJZ7t/YvgAf57MkQXwDhqsnF2GZ7zI+eBF2QhJpT3GicLnH/1Pp1j3qRYjH5PFD+5wIA6kcG+qJOrXm3u2ewhPY59+KNwdKfy9uA8JlM/OnE2Jwgg5pQORa4w4PxijSiMPdpvBtrkCYpBzsPrQDsvFFg43z5UTnREkcVkAPMkkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G964gytrPeiWVZB1VXj7xvqHNgGTOvhs9i7/A/WRkpU=;
 b=qRbAMRMouy9/tGTHpalvFsGmRhZjvf8hX0+diZtDXaFdRM92BqJqPt39tSY2pYGIPkv4WTzUxtynjsdqKC9h0uXXTJFEw2zpPqTZEWtsNf/wUusC8q2E5qFj8tIlIMINpruPeeZz93RM4gA5RNGK6P9grlPFDL25GGBxRpcEWbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB5022.namprd12.prod.outlook.com (2603:10b6:5:20e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 25 Jan
 2022 16:24:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 16:24:09 +0000
Message-ID: <d2868fc0-ea5b-174b-8144-7986af33e7b1@amd.com>
Date: Tue, 25 Jan 2022 11:24:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/8] drm/amdkfd: Correct SMI event read size
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220120231322.10321-1-Philip.Yang@amd.com>
 <20220120231322.10321-2-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220120231322.10321-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f01b1852-8077-43c8-768b-08d9e01f1d23
X-MS-TrafficTypeDiagnostic: DM6PR12MB5022:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB50222530E3CCBA5E1B607EAB925F9@DM6PR12MB5022.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4I+k/q3ACWBMwQgM7GmpDmykh9Jv8kQuS3q4KH/yAXZZ5P4FV3cUa1Do04X91y81C3JjpQ2HGHYDwsfYCrIXlCLRk8Zmm/E856HKaX7fNt2do7FY1/jpIV92l+4NguxqtGQgDGuMImL2tsuV67stagmsECuNM2Hg616yvueALWUbLZ1xZgi84xFajR0vKTX///VWi7VmbAD2SKBKJjZwPNqiksUjCfMgogR1AQ+U6sAs3tpkmf1fSkrlSplM0b9smw9OYh2hhV/K0Y6VXOguZz43roFObBXVdMh+FAAyP0BxLbNuYFeTgV7ZmK5qurxLqLqBLW8RwiOrg2Xd0f+Wr0jUHh4OefwrRMNPWc96VwS4Pz1QV1PY87u173OPd4lKljAgYzH6dDX1N+fqu1lWVOz1MTjJS1BgGJUj3oUsUZetkXpnU3Y20+uZRBu1GboEPeZ/To8d9hV4FycrtbbsrKUYQWm2uQ8vvtACHaKMcDs635hZ5i/66A+ucUKXkDaQhplrsw9rb44FJyHRJJ0KKtcMI3Yl2foaFDMNVDPd36HHIKOjdjzlUYMUzvjE48+cgwDJqLv3yuWqRFpyPCAxttM0XURJps7nMCAMP3liSW2R+9es7SRUKLnJmgmtwbmT5sILmif3E2+QUSO6BOLPPZ2lejfCXHB3L1xOARDscUE1iuJgxeerZAj6F9y22yJw1We80qY+BYE0JaIBl5JkQqpBJRK3Amljb6VoqB/QIAX5eeHxeGVulppgmcONtj1t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(2616005)(2906002)(36756003)(508600001)(26005)(31696002)(5660300002)(316002)(6512007)(38100700002)(8936002)(6666004)(6506007)(86362001)(66476007)(8676002)(83380400001)(66556008)(31686004)(6486002)(44832011)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTlIemRIWnZ1ajFIT3Z6T3VIbjUwaWlVbFBGaHVVWGxYMVd5RUhVQmpZamZD?=
 =?utf-8?B?S2Qxc2R0SDUrZTJnenlOUXlXaGNVOWZGRXpTcHMvNWtlV29iSXZDeTBIdTYz?=
 =?utf-8?B?VVloR3pRWjVKT1VMYStMRndxT1JrUFBmVThuZDZLeUN3T0NoWThYTzdzMXNH?=
 =?utf-8?B?OVh6SXluYU1QUXRFQ2ZiS1p5QU1LT2FVWTJ3NWZwMktONHdCSExDRFQ3TEIw?=
 =?utf-8?B?NmxNRWo5amhId1JETmd4eEtFM0lkTFlYWll5MkhwTE9xU0FoZUp6dnNSYjg4?=
 =?utf-8?B?TUpDb0MwQzVSM3ZodFdPVlFZSjRzYUo5YUlGTzhwdlJsUWhicUlRaHZRQjhl?=
 =?utf-8?B?OXQrSGd6dUNDYTBkWWp6ZVMvWTMvYyttVGw2T3ExZ3lQQkNnRXdRbThFM0tx?=
 =?utf-8?B?ZmxWV0NRcjR0MjlzTG9hdVdTeVhvT1h6dkxwdlU2SG45dWo3c1dsaWdRc09M?=
 =?utf-8?B?QnBUVlR4ck9SbkR1M09QRXFiQWlJOW5SV2R6SS9PYkxpaXFTOWRWbm5xaXlj?=
 =?utf-8?B?RHRxYVNQQ01jYzFtWDVhUXhiUStIUmFGOVhsamlpbW5MWFhtTWF5VTlGaENU?=
 =?utf-8?B?bmhDV3U4K1lCWnJRNFhSWlgwSElpenMwQUhqMkwwbW1iMmhWRHJrbFlCZ2hz?=
 =?utf-8?B?STlZTkl6UEJ1b1hvSGlMOVk4Y0pYRXQrQmJQWExhMjM4SHBqWmVBY2RBVGp3?=
 =?utf-8?B?ZVNrdnhvV0JFbU1MZFBua1pLVkgzWG5lT3ltcndIZUVpUnVRTFlPN0F6eHVo?=
 =?utf-8?B?dkNCd1hGaVhjSEpjUmpIZ092QXltVGpVampxQmRsOFFiQnBPTkF4QVc1RWlB?=
 =?utf-8?B?cmNFcmVnZ3hmZXJrdHNZMkxjcitFZm9MSXR2NG9PRkgvUkNVNFVTS09jZm4r?=
 =?utf-8?B?R3l3YVZvMUJsSXROQWlkUTZFbmwwUnlRZkdYam5WWHFmbm9ILzZnbHRseDA3?=
 =?utf-8?B?SkF3Wm83eTRlRlF1OVAzLzhONmExcUNETVo2Q0V4cFJFRkhOVWR1VHN3NTAz?=
 =?utf-8?B?V1BHeHptRU1JM3Z0bWdXakZTNlNSSUVYUTVMMXZRUTFjT3BKQTJrelo1eEhh?=
 =?utf-8?B?RTNCUGtQWGx5bHFjYk13Z0t1d2pQd2d0MjB2UllKUEpvQklBT3NWbWdTRnJ6?=
 =?utf-8?B?SDB2N3EvTjZRKzkyN1BUQUcrMVpXekg5UXh5ZXo3aUxIemQ5ME9CeFZxd2RL?=
 =?utf-8?B?Z2U0V3dHWHRDUEZPQVdnckRnRGlFWkJrYVpoNUNGWlZwNVhwSVAzWXRjYkxh?=
 =?utf-8?B?akJ6NEZ3N0hNcE1LbTg5V0p2YWg5eGdQTXZxM3F4dXFray9QcVN1WTYyNzVo?=
 =?utf-8?B?MmZxcGRxWGdoYkdqY2pkNXBhY0FlS0tNK1Q5aVJsOEpweVREeEp6ZDFXZ1pD?=
 =?utf-8?B?M0JUanlPcTlHb0hoK0R4a282Z3hoekt1RHhWaDhScXFNbFZ2Y3J5eFd1K1VW?=
 =?utf-8?B?T2RrNkdoT2ZSdHcrMUk2MUJoRmR2RkFLdGpDRE9VbzlRMzVGQjBmamZMYTFz?=
 =?utf-8?B?K0lxeFRBN0NSemptUVBJQU9YaFZkanE4dUVIUEdDaUprZkMxdGh6ZWxBVnhk?=
 =?utf-8?B?aGpoM2JrMGlHcE1ZbXJ0QnpGQ0Y1c25nZW1ubzV6U3ZVRUpVbTNjbjh1NWg2?=
 =?utf-8?B?ZnRsdFRDc0I4ejhFWHZwTTZJSDF4WkF2R2p3VXdhbjBJRE15dDIvOEhMNE5T?=
 =?utf-8?B?c2FQRzV1T2c2K3lPall1dUJwR2Q4aE5xY09FWUNZdjBwY1lkSEU3WXlubVo4?=
 =?utf-8?B?R1RvMTZXMUZaU3VDNTZFazdsTWZLdSsxckNwOGY3amxWR1hNcmNCc1plWVBw?=
 =?utf-8?B?QlFjT1lDNWdxMHVHS1ZORzl3UkdiWHJ4VGRwdDlEY3dIZEUwalBsV2pBNFVh?=
 =?utf-8?B?bXlLV2RMVHBuK0JVUy9GN1ZjVys2WVhPMkxjSUdVZnBlYmlvUU0vUmxyWDVR?=
 =?utf-8?B?Y0xuR3ZvM002L21aZklVbUZSLy9aZlRUang0ZmRlVE1Gdm1YRTVrNDQ5SUJB?=
 =?utf-8?B?ODVSVnZuZEZLV1lRcjl0OC9Ubms3N3p2N1dCcHZmTmxtMmd1ZzVzK1dmcmtX?=
 =?utf-8?B?SUx4RDVLN0tzMDFqUURDTnZhQ09nejdLRHVENGkwUTFUaG95UmRUTWFBSDds?=
 =?utf-8?B?a1ZxNWRWSnR1UUR3V2haSzJJUXNUQlZZQllFazhwZUx6NTcwYkVLVExQMzky?=
 =?utf-8?Q?R0Vr+JDE4dlDh/3m8aIA96w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01b1852-8077-43c8-768b-08d9e01f1d23
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 16:24:09.0221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPQhtYegfm4cAtl7f582PwQqn7FJqicEOb1sAYUJzZ/+pmMNu2JobxEjD2HZuKeTfyfiQa19ULk8GXuubQby4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5022
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


Am 2022-01-20 um 18:13 schrieb Philip Yang:
> sizeof(buf) is 8 bytes because it is defined as unsigned char *buf,
> each SMI event read only copy max 8 bytes to user buffer. Correct this
> by using the buf allocate size.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 329a4c89f1e6..18ed1b72f0f7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -81,7 +81,8 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
>   	struct kfd_smi_client *client = filep->private_data;
>   	unsigned char *buf;
>   
> -	buf = kmalloc_array(MAX_KFIFO_SIZE, sizeof(*buf), GFP_KERNEL);
> +	size = min_t(size_t, size, MAX_KFIFO_SIZE);
> +	buf = kmalloc(size, GFP_KERNEL);
>   	if (!buf)
>   		return -ENOMEM;
>   
> @@ -95,7 +96,7 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
>   		ret = -EAGAIN;
>   		goto ret_err;
>   	}
> -	to_copy = min3(size, sizeof(buf), to_copy);
> +	to_copy = min(size, to_copy);
>   	ret = kfifo_out(&client->fifo, buf, to_copy);
>   	spin_unlock(&client->lock);
>   	if (ret <= 0) {
