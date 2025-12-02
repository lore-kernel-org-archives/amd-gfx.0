Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B8AD1266A
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 19:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B2D510E698;
	Tue,  2 Dec 2025 19:32:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YpBlaLtp";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E966B10E698
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 19:32:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdEFcE3ximb3jkwKV8o6vQK6mg9ty6XOCSXPnweyJXky06LvVP+rFdTYYtVm+ji+u+uPCDE2LyE1Pnzd4XsFPJj9KSaEoxpKINcfgrtB/+F9zvE7Xl0u8zR+ZWi41moT9S/36nR+BD3N9vN2o37HuVpJOWP0soXeVc4cIrh8bDzglWsrXk8RtEhUxszPAogCdg14dt54ISV2PnQXKhqhjo5ZBWSBKTrAD9U1zOAQ3bnf7A/mPq6OFFB2oRQ1KbMeJB22hhzI6X8Jn1UtLpCiTlJmWZDrNNNtFPM9ExKDAFfWw7N7OcxvZeVh4saCtUgL+h+q8tZUcu7E8m4mkMIekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRizd6Mu1z+rPWVfbtn0o6LEUVavEIU1NQAqhPnmZe0=;
 b=bQtasjASrxGsspW12Tm7RzN+top1jMMmMFR/DcnKO2+ae8TabXpO3Env7kuRwk1ZbIbuwR369n4vGmE3A/QdBc+HqeZlrZGsZxlPYLiPoGMCQts+wg8hYZMazZwCyOZZWSZD8MMl9YQcKxknP1Tg/wDOeH+uUK93oY+Y5NihuaCGAG8IrBEXf1ZHICh2I/iu+ceOcgxtt7rWTbRWSw+eGcIY+675YcGQbecZfT67lElMajGIEtXzHFaNaMp7kElrHz32kFhm+8aY0Ig9dGWn+uv8VRQ/o6yQhzqy41iEesLYoYvk6Ouaq7AdAXNmp36fRVMo5cDnHtn2MutY4W2jTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRizd6Mu1z+rPWVfbtn0o6LEUVavEIU1NQAqhPnmZe0=;
 b=YpBlaLtpu9Nrc7iLuDHPE1nuSmITh4HBSWCm4/duNxfo2MR0nsdNEBtOAWj3bwy7siwniZSnnJ5AyuEagFrlMysI0fEaRsTuL1K4fPDHJp19BtHwFYlt3yCncGPT6B65Zb82V6pEVhBVHFR8U315G/7rFPU34hMXsKKAFZgBuaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 19:32:17 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 19:32:17 +0000
Message-ID: <9072b455-9a52-4623-9272-4921825f8320@amd.com>
Date: Tue, 2 Dec 2025 14:32:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: Ignored various return code
To: Andrew Martin <andrew.martin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251114232546.1586273-1-andrew.martin@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20251114232546.1586273-1-andrew.martin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0194.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::23) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d265c8b-dcf5-4f35-e347-08de31d980fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVE4a2hFMHp0UGpralFnQy8rUTNwWm9EV3BHaWMxNzJCcFFmc0tNdm5WbzAw?=
 =?utf-8?B?amxHY1EwVVMxanFmN2ZTMWxzQzRvOHBxNzZSVmN5T2p3QkQvczhUWU9WaUlu?=
 =?utf-8?B?QjA2d0k0NFYxRlNmcHFkdU5XSUhuMEh0aWtYRFYwK3FnSW9YVDViVWVIQnhl?=
 =?utf-8?B?bmtmeXNzS2o1d3NFRXJLb3lHb3pmRmpEblFkOUJaaVpkT0d4TWZ6OXFzMzgz?=
 =?utf-8?B?eVZRb2pwbjF3RU1iYzVob3gzUm5wTlNtRmxPYlpvMWRwRzZLcUJzcEhUZHh6?=
 =?utf-8?B?WUpYU2xvZlBDTHh0dUJzbnM5UDNHb1pmOWw3M0JtaERUeWZXMkwvV2F3MEZQ?=
 =?utf-8?B?by9vZ0xlRkVRa3JVQ0hmeVJORWVOOE9VK2JwWDBPUzhleE80UVRSaDV4NzYz?=
 =?utf-8?B?cE5FVWk5Vzl6T05rWFQxTHk3anBIZ0tlekNHdkJDWW1BSURCeVZsQVhyWlYv?=
 =?utf-8?B?V0RaZjNZcDhiZjlxVzVtRFNaa1VYTkh1ZzRlaHZlUTVqVWZoWmFYWjMrZUU2?=
 =?utf-8?B?cHNyQU5neVhicWhyOUxwWXNCUkVDNFp1VnU0TEtvQzkvZU11ODlubmJ1MlpT?=
 =?utf-8?B?cUZENE1IMjJIb0Zxd0xrWjJXbERpVFlFSEVaQ2RHRnhXS2xHN1RPK1FqTmdh?=
 =?utf-8?B?VElKOXZ3RzJ4NXFBYWF3bWN1MHM4WFVMV3p4WnBVM3dic3lJYVNkc1h3Zmwy?=
 =?utf-8?B?R1lCenkvdlRDb2o2NzFKTEZYRDFuNU9DQlptWlovYkUzRkFoU3FIcHV1RmVM?=
 =?utf-8?B?amtvbGhZOW52UnRiSS96NGxYQThqZ1JOY3JHcXNhazZubXVOL1VBd1BqRTF0?=
 =?utf-8?B?eHdrY3psY2hqYldsb01la05Ha3JKZUFZUnM0N1VPci9XUkVFWmJFamRjVzBK?=
 =?utf-8?B?a2Y0VW5hSGw0TEdBT1FDelAycEZVbjkrbWs0azYzSWx1SWtCWmFISjVmK0Rx?=
 =?utf-8?B?Ykw4KzV2SjRHazFYZ1BPUzBDL1ZyOXRwU0lvYUFweHdqRDJzaXI4RW92VFBn?=
 =?utf-8?B?OG9CR0RTT1pFNDFKOWJoZFVZQUdUSVVoR0RvVnRlUU1SajhNZUVIT1Q0eXFH?=
 =?utf-8?B?NThWQ0NQckZ5TlpSdkxVazNxRFRqTjAzaXp1a3ltak8zUENLN1dvM0ZpOUgr?=
 =?utf-8?B?cndqUXEzZkEvREErNC9iZ2gwU3V4a081ak5TWUJjYVZUU3Z2UUdONDIzcDhw?=
 =?utf-8?B?SGxmaFBOMStadXZ3WXk0ckZJbThtdTRISE9HY2pUS2VuOW0xaFRQY0hQcjZx?=
 =?utf-8?B?Sm1ZZXFyWEtFdkFDcmZlaTBSbmVRRE13ekpmSzhldm5qR21EcnJkYVN3L2tx?=
 =?utf-8?B?NmZrMWRJd3pqNFpYMkZWQzJBeERXcmdBUGExQWxWSVduMmZyVGh2OGFBMUR2?=
 =?utf-8?B?YlIrLy8vZWdnVE1ZRmpBeXZmbWp4anM3VmRSMjJGMExEVkdJd1ZJSXBqZGx4?=
 =?utf-8?B?aXBnUTk2dkZiZzVIZ1JCR2tNTVprQkZCbXh5WTVONDZoZ09UNzRDbGw0cDBh?=
 =?utf-8?B?MGlESDNJZnJHMjBvRXd2R25SekxsT0VjbkFtb1hZSzBib203cFpLVSswa3F5?=
 =?utf-8?B?eis1S2V6VkFMdmZnSWdKWHUzdjd2SldkbWtJN3dOWmc2UThheElINUVaQTdp?=
 =?utf-8?B?Y01jcVY5Y1JqeWVsSXJvcStwL0lGTE81WlUwVEFzanBCcjkya3o5MjBaVzJw?=
 =?utf-8?B?ZENsZDcvN2NwMTZSVjNrNXgzY0tRdkc1Wm5EcEhoS0hMeDFHeFRJbmxDYXNU?=
 =?utf-8?B?UzFhOGNhWEdLeXErdG45VHlRRzR0U1hJbFFmQzByUEdZemRRc0dGL0pjcDZS?=
 =?utf-8?B?YkwvVWc1c20wc0VoenhJVGFTQmI2Zk9FTWVLYjFjV0YzZUk3bkg5YXV2TVRp?=
 =?utf-8?B?Wk1vMnltcWR4RUhsSUNPTW91K1RKTDFua0FPaTlqdmE4Zmt2d1c2ZkZNU3Mv?=
 =?utf-8?Q?2uuyiywFH4LjlSYMhFhcR4EDf/IDTnhj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clNIL0g3dEpqQSt0d1BaczIrZjd3cjg3MlBTYWlxZjBCVTlobERndlZCdzRn?=
 =?utf-8?B?dEZwMGR6WTNWQ3pDM1U3VHhOcTJVZ1FHcWVPdi9seXg5N3gvRDgzWFdiV3lt?=
 =?utf-8?B?ZStKQWp6cUxYSUVZZVhra1dZTXVQSjZlUWlsNldYTk5iT2xOejdVRHBNZWU5?=
 =?utf-8?B?M1FvaUp2b1E3V05xMUdUc0FGMm5wTlR1WDZ3RC91NGx1S0hNYXpPREZtMHlo?=
 =?utf-8?B?K3g4b3B6eml1NzNIR00wem1pNzlUTWdrdlNsWXU1SHNUdEdleXhDOUVNNnJF?=
 =?utf-8?B?VE5xbk0ySVdKY2s5aDBUVW8rdWJWUkliSG5ORlhNa0QrSWxPRzlPNHdxeHN0?=
 =?utf-8?B?MmE1TlN1WWF2MmVDenpWOWlMV2VhOUdtbGRKa3VMRkRqcTFnajJmdm95RURI?=
 =?utf-8?B?bEVqbG9veXJ2M0tERzRRZitlR1Y1SUNqSm5yek5PSThmcEVkWjBGZ1RUN01D?=
 =?utf-8?B?VFFORGVPUzBXUXNRTkI0a0ZhQ2NRcDRSa0ZNS3g3OW9sYW5Xd0dTY0tQdHdB?=
 =?utf-8?B?enJKWXcxVmhBV2tuUUh3UHV0TVlEWkxXMEtva1hBNU1kNnhuRkh1eFJEb0dI?=
 =?utf-8?B?UUZCOXRDVVJreXpQZFNPQW5UdW1JbVFNZzZ4NVB4aGRsYWZNdys1bHh6MTZE?=
 =?utf-8?B?ODBCWjNwTDN2ZUJzWUdPbGM3bzN1MGsxYWU3UU02NWV0L2g4aFdXYjRGKzZp?=
 =?utf-8?B?RTJvTlV6T1U5TmlEdkRTekZVZ21pMmFpdVZLVDFWWmY0VjlJdjBZWFloeTZw?=
 =?utf-8?B?cmVrTWdaU093ZkU5UHNlQU5aY1hPT2I2aUtyeDJaQWZpSlR6SjNoK0o2c0hq?=
 =?utf-8?B?Y05kSUxMQ0V1TFF5QXVNM2pMNkJ0M0ROWmdyV0NtY2RtQUhNMEUxT083MTZC?=
 =?utf-8?B?VGcycktKK3BkNWFGS3lCWlc0S1lqZ2R1Nm05bjlTUjRPL01WNW80NjBKOFhp?=
 =?utf-8?B?TGZoTk9vRld6Zm02NUxMK2F3YzZ5Ylovd0s2bHNYcHZlajdweWhGeW9HYVZ0?=
 =?utf-8?B?L2JTVW5HUkNiN0JHdU9seFlKT0lRQzB5bDZSVE1zZGE3ZmxaRFZZcHQ5U29r?=
 =?utf-8?B?VkRlazFIUDQxMWZsRjZWV1JSdDlwdS9YUVBjbUt4elBzNHUyWUlQTXltNVRm?=
 =?utf-8?B?VVBwTFB6OXdldGVUY0JTSHl0VU03SjMwM0pyYXRZWEMzV0phMW9STzQySkVZ?=
 =?utf-8?B?WTNXMFR1V1RONmRYaTE3dFptaWhVemZrOHJPd1d2T2ZKU0hMRGFQRmI5M2lI?=
 =?utf-8?B?RkZGOVczWGRHbVJsSTBPeG93T1RhWWRTRGxPV0EwenBmb3M4NE1GenZiODlw?=
 =?utf-8?B?RXB6SGtxK0JRbGs3WHc3elR6SVN0Mmt2ajd4Z2hHSlN5NEJzOGpkeTQybjRy?=
 =?utf-8?B?bFpPZlBKUlNuR1ZtN3lZTWpLMnJWckJIYlA2aC9yYjdOZzk3dmdJUVdxRUFh?=
 =?utf-8?B?OVp6NlV5YllCbXVnTmtObnFRQU5ubzBURkpsaXlUc0dadjRlM0VsUXNHZFBa?=
 =?utf-8?B?cTZhOXNvYkI3ZGJqZmp1enJOcGdBRHl3NGtTcHlvajkyb3l0S01tcnpYUXB2?=
 =?utf-8?B?U3F4TWRVakpnbnZiRWZsNU8zZ3RteXB2WXhJeGRtYkpkYXhwZUpVMWxxU1Rs?=
 =?utf-8?B?dmhQaGFEd2JZUVZGTTFPbVpENStucFFnUXFJNmNvRzNsWVZPMXR4UFNHMVFJ?=
 =?utf-8?B?S0RYZHVqbjl3RGNCU095alU5dXljcEVMbm9uSitNRnNTZ1lENGEyNGtKZFlJ?=
 =?utf-8?B?SmxVak9icUlNNURjZzdYTkF2aXZEYXFmeEcwbFcyeTlSZU5SN3dFRWhiSDln?=
 =?utf-8?B?VUZmRkxRa0xHcDdXVGxuaWdWcjNLbmsyVGN4VFYzdWZWMktYeVFQL2Y0b0J6?=
 =?utf-8?B?Uis1Mk5YWldyRTlEQlYybmtFQnRUcEVNTWgrMU1pMTNhNTNxaWl1djh0QURu?=
 =?utf-8?B?V2VBMEFTeTVkUjNaTG0yTmVqbWRhQm0rd2Nwd2dkQWp2eGhJWHBYWFdPMGZk?=
 =?utf-8?B?VXhDNGswV0pFa0VreWNvQlV6dFlGREh3Z2tkMW0veTlHNjlQL1BQSEpZb0cz?=
 =?utf-8?B?R29jMnNsN0hRckRpOUEwQ0Z1MXo1OHRPTXc3am5HQVNvaGxkWk1RR2dZZXVH?=
 =?utf-8?Q?es2g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d265c8b-dcf5-4f35-e347-08de31d980fd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 19:32:17.6599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5nCzIpTgeMe21KdWy6hUFdldAB57SUCXJqNFbmonZsT7pXdw47xuERiY6me+FmT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862
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



On 2025-11-14 18:25, Andrew Martin wrote:
> The return code of a non void function should not be ignored. In cases
> where we do not care, the code needs to suppress it.
>
> Signed-off-by: Andrew Martin <andrew.martin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 +++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 5 ++++-
>   2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 644f79f3c9af..e1b208aa72c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -313,8 +313,7 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
>   void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>   {
>   	if (amdgpu_device_should_recover_gpu(adev))
> -		amdgpu_reset_domain_schedule(adev->reset_domain,
> -					     &adev->kfd.reset_work);
> +		(void)amdgpu_reset_domain_schedule(adev->reset_domain, &adev->kfd.reset_work);
>   }
>   
>   int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
> @@ -715,9 +714,8 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
>   		if (gfx_block != NULL)
>   			gfx_block->version->funcs->set_powergating_state((void *)gfx_block, state);
>   	}
> -	amdgpu_dpm_switch_power_profile(adev,
> -					PP_SMC_POWER_PROFILE_COMPUTE,
> -					!idle);
> +	(void)amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_COMPUTE, !idle);
> +
>   }
>   
>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 22925df6a791..81a3e0aa40a9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2780,7 +2780,10 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
>   		 * saved in MES.
>   		 */
>   		if (pdd->dev->kfd->shared_resources.enable_mes)
> -			kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
> +			ret = kfd_dbg_set_mes_debug_mode(
> +				pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
> +		if (ret)
> +			return ret;

if (pdd->dev->kfd->shared_resources.enable_mes) {
	ret = kfd_dbg_set_mes_debug_mode(
			pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
	if (ret)
		return ret;
}

Other changes look good.

Regards,
Philip

>   	}
>   
>   	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;

