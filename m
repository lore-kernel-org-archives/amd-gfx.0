Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7955CCA470
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Oct 2025 05:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C25310E66B;
	Wed,  1 Oct 2025 05:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FfF7kz1D";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013045.outbound.protection.outlook.com
 [40.107.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C78F10E66B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Oct 2025 05:42:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cbuJWzSRonmVRFSXl/rYMcFPBEjuXQE7XCZmn/kRTxOJIAhE6RJGY6FBLQWQ3kzKQ2jV4WGe8SmX1Bi1jLqSf9giqNs4jXmmT+tr0qH9yZhR+0VaOphrVpQ8LOf/aWuml9mPUkIVuaeAuoQR5P7WND8Kztnl5TVWnrc1sN47LsBd250W5GSadgtXoGVfNI3pF0F97CpSUB4wQLllHjvUBmM2aGaGYTfkic80eiXEyZHMC8uXtiEUMOqk6vTMkijwsZ1LwreGrucJjqTBF2vXHONbBEpSPfAh36wseJ0VLTIiMvRW1rWAhNbl0Eb56Gezd50J6oR1F3OQFIeo4caKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBGxvulQckl1AvGd4PVl9NHcPcFGrgrbrZMdq7ZX/lU=;
 b=h+lf1T0BYXe8ZI4gTvVCpcDGwYnmCtkYuvBCduo0jfIVIj4dVjOXMyhZ4KkP0+gJO/I2dVEPMiaBsEdaosmQm0NYphBwfbBtj3Jg3xfD4FqbcS1yxL3+RS9w5J8h0VmCP5zY5aR+gLNfYPzlaaWPzJFVyw0mxwjSnMfP2b3gQVzQiPMYUy7iAHKNaDIrZrvSCf6VQHBPtsZDkSSbB44p8rNyLBjS6Mc4tZoxL8eIhn8CdMOOhAn7PUu/s7YbF7oE9HVZ7p/H5qLChIBrSuihmeRd0dOBYnYuIVkpjpuw/r1MzMtpGBon0q3pgMXDlNoEAii2zr8L59p/Md6Scl3jLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBGxvulQckl1AvGd4PVl9NHcPcFGrgrbrZMdq7ZX/lU=;
 b=FfF7kz1Dgfn08E1YKXWCB2nSSHXZTeOfZNx751Y5kNAKUP5HcKiFv7kf1Z3Itq+rxgZOlpv0CDDPvrGKI5o/AByl0Zs0nnPX59dq5Hvp6JW8/SyKMTZpokm06TrXB1OVNszPpTIYLwWSDzOoNkRx09jHHNK+40zPChAbe/tp1Q8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Wed, 1 Oct
 2025 05:42:45 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 05:42:45 +0000
Content-Type: multipart/alternative;
 boundary="------------hVwVXdJ4u9426HHg8bTDaAEy"
Message-ID: <2f271e07-de39-4da2-88b2-54a6e03ce174@amd.com>
Date: Wed, 1 Oct 2025 01:42:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 17/18] amdkfd: set_debug_trap ioctl only works on a
 primary kfd_process target
To: "Zhu, Lingshan" <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
 <20250923072608.252345-18-lingshan.zhu@amd.com>
 <08ecb504-abb8-4ad8-bbbb-a18e19daffbe@amd.com>
 <498cf72e-6204-41ee-8a22-d7be901a8f77@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <498cf72e-6204-41ee-8a22-d7be901a8f77@amd.com>
X-ClientProxiedBy: YQBP288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a3374f-f7b1-47e4-5419-08de00ad58ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTdla1BlOGV1T0Z5cGU5Wk80ODc0RDNiRFROZ2hBWU5sMWQvRXNQUzFxY21t?=
 =?utf-8?B?dWxka1RQS3ZPb3hESCtaYmJiVGdZMlZjN1ZGcElqdmxxZ2prWklFWU1vdytF?=
 =?utf-8?B?T2tuazJjUjFkRDJTb3VSRDQrbWJjWVV2bHdVbFplQ1UvU2FkRkhLK1BDT1hM?=
 =?utf-8?B?MzJDWktpcEhTeUtPcEhUdk9UZUlTRktPT1lobnMwSkp1V1lUcFljV3laVld2?=
 =?utf-8?B?QUlsMUw5emZUbHFKNzg4VExhZkl4NS95OG1kTVY5Q3RMcVFSM3paNWVzZkJh?=
 =?utf-8?B?U1ZzNURHazJMeHFZUHU4MWhXMUM4Rzg0NXBYZC93TkdpRXdjRU01ZG05YjBh?=
 =?utf-8?B?Y3cvb1lqVks0Q1p5NzlOVjk1enAvOE9RYS9IUzRrQy92bHRkUmZmV2VuS2lC?=
 =?utf-8?B?TjljZm1BWEY0bjVTRk9uQ0dZcVZlUFhMNkZtL1RzN0xCMW5SSUZpOWt2NmNC?=
 =?utf-8?B?V2JndnFMTkdlVFlWc09tN3RSK3Nid2lxU1hISDMxaWRBdVVmZWdqNXNHNWkw?=
 =?utf-8?B?alU0dzFzekJlQ1cySWVKamZRTW5TOXl2OGVKTkpsZ2MxSDZCZ1l0SUdnYm9y?=
 =?utf-8?B?QWRnWW9laFhNZCtNaVRsMmtkVThVV3c1b0tRL0poOStYa1NVYy94SmVLd1gy?=
 =?utf-8?B?NVlhQWE2eUwva3Eyd1pjUlFNWEZtdXVacGNra2lBTW9XeGN6elJUUDFzeitk?=
 =?utf-8?B?ZXNSWkdnWkVSYWpHdERFTUhMdVkwYmJQWjRxMFJTRndoSFJReXlYaTVqM2oz?=
 =?utf-8?B?c2FMSnVYUHZ5TWdvRTBtSnJhUjB3akpwQnlPMDBOUzZSaHR1Zmd4MlBwTTdh?=
 =?utf-8?B?eUxvOG0xbzQvTWRqMGFQVUtpbHRMSmorWGxqSDFnQ1pwZlFkY2NXVjV1Nkh3?=
 =?utf-8?B?bkdrMnE4UlRlMjlJODEwUUlHNVBOY0l1a1hxQ0dLOGUyek5SeXBpY2ZsZnFt?=
 =?utf-8?B?eTZQK3RLSENNVHZVYzNzYjVqcnNJaEpiaEw3cEYxeWZSLzJJUW1lc2hnL01K?=
 =?utf-8?B?Zm1MVlQ0MEcvamlndVVrNFVOakkvNU8vM2J0TUdlVFhQNEdvSHAzYzByYm1X?=
 =?utf-8?B?WldQQlFYdWxReVhUZTJuQVVVMUZRMUZKb3BEZFFZQ1FDRGE0Q0JjSS9wcExG?=
 =?utf-8?B?ejhIV09RT3J4N2tTbVJWbC90b1MycWJncFl5SVFFMWYvTG9IZGRFODQ3ZFRz?=
 =?utf-8?B?RkNVVWNIamZHVlZRQWRxWUE2czFGUUtVb0l4RjBTb3dzTG9uRjlXY2tHRlVP?=
 =?utf-8?B?bjFIMlJacEk5SjVQMU9ma2xNaUNUY0NBdzBDb0pXbjZaV3VJcDdiTm5qYWVq?=
 =?utf-8?B?NFFxOS80NGJBMStBZ1BxMUtSaDVJRjdLRUdWU1UxbFNnaVZ3UWJLSVByUm92?=
 =?utf-8?B?cGZNY0J2dk1JRk9XWlB5QW1oMkFBbnVGZXpCcUtSbXRGUGlQMFZuN0s5S0Fi?=
 =?utf-8?B?UVQrTVg2OUJsY2R3N2xjR2k3VUYzeVlMVFcyckhRV3NCVE1RTWZCbWxGWjVS?=
 =?utf-8?B?VEVuR3Q4TGI3bklUMzgraGRVeXFEeUhMdU52YmtXeFZ3RHhIVmtKR0VTQy8y?=
 =?utf-8?B?QlRkZ0Q4bmdhRjlHOTFvSERSVW1LejJzVFJzVVBnWjZOWWw0WHlrc3MxYnE4?=
 =?utf-8?B?eVN2SVU0NVdxdUQ0UDl5ajZzdlUvdVZ4T0dmOW4vU0ZKR2Y1aHFBYUh6N3RF?=
 =?utf-8?B?VnBORjlleXd3ajJiUzYwWUdKNjgxM3dBL0lCREV3ZVlYYWg5eDJKcmYxLzlL?=
 =?utf-8?B?YjVMK29WVktrUGFUSGpVWStiY0RuYThEQ3l3VDVndW1hcmlVN2R2UWpkaEYv?=
 =?utf-8?B?ejlYUXAzMjIyV2pTQUNqaFhOMS9zOUtSSnlRTTJzaEtUWVpYOUdhditRZkdS?=
 =?utf-8?B?amR1aGxPOWdaVnBady9BSHljejhlYWsvREZkRUhhRmZyWmhxNm5QalFDd3Fp?=
 =?utf-8?Q?ViH02bXRJXHLnHpg6WACgnbXOuGjMuLL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2lUd3RqVk1QZ3BNa0hwRkpyWlhnbElUREN3ci8rMnBlNEE2STRLeExzZ3Y2?=
 =?utf-8?B?SmtzUlZFamd0cXFVZzkrZW9ValRxQStHWVRnVWdhR0x1WjV2dGtMZlBUVmtt?=
 =?utf-8?B?ZC9PeU9NaVVybHkrOHVoQnFXM3NwYldLTUtqTEVrY08zTjZkSXZTelQyTHBh?=
 =?utf-8?B?eDlmSG51QUtJOUJ3bjNJd1NhYm9kYVBlalpWZS9ldEs5eVhjaUE1NFNnaTJq?=
 =?utf-8?B?N0dFL2VyUHA5cHlUN09CMmdUeE4vR0dCSTVoUjdhZlZxOFV1TkFDblF2ZHpQ?=
 =?utf-8?B?eGNtMGRMRTU3ZXJLTVZRT1J2aUJjZHN6NFZUWHRZOHVhcEdRcUNyaVR0eWpv?=
 =?utf-8?B?YlUvcEM3VVdmaERabjlYNlRQWXJzQVVjRHdQbGs4My9iS1B4TkRubjhUNUR2?=
 =?utf-8?B?RU41NE1MNlA5UStldUdmWUoxRDRFZW9PaC9HRnhiQzNNbm9vTklEckFDd3or?=
 =?utf-8?B?TTcyb1lRcFBZdUVadlJBTnlHcEVDY3hJU0dqRG1HTW1LODkxSWlKSzc2aS9a?=
 =?utf-8?B?WTM0M1hNaWlNUzJMSHppRm5hS2p2YUU2OTk5Q1ZvcWJ6STYwVjFORmwzVFJv?=
 =?utf-8?B?V1ZHMXV6Y2hsRENCU09NODVRcDFFRVNxc2pmWnBpN0d1SXVEMnY0NGV6UStJ?=
 =?utf-8?B?Si83VWNVVGNUalVnYVJxbGZQeXNzN3JIelF3K2o0enhydTNCYTRrYXN3VlVZ?=
 =?utf-8?B?ZHV1VnNUVTVpdFBwM3VCcEk1ZnZMVWZCS05UWEFqSCt5U1J0QjFOd2dWdmpa?=
 =?utf-8?B?bFc5b1h6ckN6QUNIYnNNU1JWcm5DQUs1M3BGdnpuSEF6N1hyWk9lbENvZlk2?=
 =?utf-8?B?WStlenoycm5VVFVDTVRXdzhzcm5xNXBHWWxBV29lY1RaZ1M5b2EwclVkdnQ2?=
 =?utf-8?B?bkVqVjBpVThIR1Nhdk5HalNFYkw3bDZobXdUSVA1WE83bW56ZTBnY0Z4RkJa?=
 =?utf-8?B?QjdKRUFtTkFqc0cwRVVBWVZFS0E2RktZOXBJeW5QRElpVXpqR013anF6MjA0?=
 =?utf-8?B?cUxPMVNkRXpJa0phRzR5N2ZJNGhVVlNFMnh0UzhsWmljM1RkcFlMS2wrcE5s?=
 =?utf-8?B?UDVveG53aDFXWWdnZDhPTVluRGdmTG9HaXYwUzVCaU94d0lPT2RFS2Z4ekNZ?=
 =?utf-8?B?L3k0U2FJVUtVNWFtWE1INDlwQ1JHMGVILzd4d0paemdseWFsenA4MTNza3U5?=
 =?utf-8?B?NkMwRVpuci93YnRzbk5TQ3B1UW5EamJBcXM2T0ZCalVCdThmamU3QzhGbElN?=
 =?utf-8?B?dUhlZ2JBSG5pQVd4cXFka1ZKQUJobDJ2T3o3TVFEdWtpQUc4NENkaEY3WTc0?=
 =?utf-8?B?ek5GQjQ5UGJSR09lQTRQeDUrWE9hNWVsb29RdGFYWTJpdkJVV2pXb295clQ1?=
 =?utf-8?B?YmdnRlFsam5IRXBYVFNvY0V3VUhNQzltOVdXb1VHSkVPOTVxN0hubk4wUEtw?=
 =?utf-8?B?b2M2em1adVExQndPdUgvQWk1QkxVTVZkd1ZWQ1E1MEF2bDhtd0tEZkdnMngz?=
 =?utf-8?B?ekZuU1NVVGV6Z2cyYk5Ya0U3bjdBR2J5SVdlWC9PMUJhWHl2Z3BWS3ROQ2E0?=
 =?utf-8?B?S1hqS0preWZzK2tneVRueDlYSlRLcVBvWWwrcWtIL05rMlB1cDZ5eFdTT2lj?=
 =?utf-8?B?STRydW9XRFlkc3dLN1BaSmFqUUE3R0c2bGZLY1lzUG9USGV2TmdxSEl0ZDc2?=
 =?utf-8?B?c2JCVmNvVkdwSjR6V1htb044WGx2RG4rYXVZUkpGVjNRZVBVQlhFSnJFUUt3?=
 =?utf-8?B?bDFrcWFmQnE4WmE2QlF3MW1TQTBtTUIzTmphYStsWUZUYXBkOHBCTjg3Q0VT?=
 =?utf-8?B?VjdKa0pmVlpyYjhkTDcwOVN0UUFyNElaN1pkenVZajZkUEhNK3QvT0txMUs4?=
 =?utf-8?B?OWI1STFlcVF0TGxmRWkvNjNxeTBVYUZUWlVkaEdnYzhabll6YnNoam5KSEN2?=
 =?utf-8?B?aDY4SlFydDB6RjBodEdiMWV1aWEwM0VoaWVUWEs5MVRBV2tMdW9JOWZhdENj?=
 =?utf-8?B?ZldpWFFkeitqL2FkeVE1WDN0c0FjVk1qUk5hcEVBLzZoVXFwdTNJd1hKOVNr?=
 =?utf-8?B?cGVDazAvSmxnVHF4ZFJPSFNNZnFuazR4RzVubjRiZFpRdEZpekNudWRRZGlm?=
 =?utf-8?Q?KcnT4Vk8r/rJSDfMYC/9yRjLB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a3374f-f7b1-47e4-5419-08de00ad58ae
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 05:42:45.1731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbmoZ9NKVgCohwd0SRyc1RJlkC6WdvQXBIBjdNO/ahZzLI5H+y9Ca1hClPvo0RziXZEVYYE4/zhyeq1PgORDsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
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

--------------hVwVXdJ4u9426HHg8bTDaAEy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-09-25 22:49, Zhu, Lingshan wrote:
> On 9/25/2025 5:50 AM, Kuehling, Felix wrote:
>> On 2025-09-23 03:26, Zhu Lingshan wrote:
>>> The user space program pass down a pid to kfd
>>> through set_debug_trap ioctl, which can help
>>> find the corresponding user space program and
>>> its mm struct.
>>>
>>> However, these information is insufficient to
>>> locate a specific kfd process among the
>>> multiple kfd_process that belong to the
>>> same user space program.
>>>
>>> For correctness and backward compatibilities,
>>> this commit only allow set_debut_trap ioctl
>>> work for a user space program which does not
>>> own any secondary kfd_process.
>>
>> What happens if a secondary context is created after the debugger 
>> attaches to a process?
>>
>> It may be simpler and more consistent to allow debugging of the 
>> primary context, even if secondary contexts exist. Just ignore any 
>> secondary contexts for the purpose of the debug API.
> Do you mean reject any set_debug_trap ioctls on secondary contexts, and only allow
> debugging on the primary context, just like how we handle SVM and user ptr?

Yes, that is what I meant.

Regards,
   Felix


>
> Thanks
> Lingshan
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 29 
>>> ++++++++++++++++++++++++
>>>   1 file changed, 29 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> index 662b181f1fd2..2df095e25c2e 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>> @@ -36,6 +36,7 @@
>>>   #include <linux/ptrace.h>
>>>   #include <linux/dma-buf.h>
>>>   #include <linux/processor.h>
>>> +#include <linux/fdtable.h>
>>>   #include "kfd_priv.h"
>>>   #include "kfd_device_queue_manager.h"
>>>   #include "kfd_svm.h"
>>> @@ -2918,6 +2919,25 @@ static int kfd_ioctl_runtime_enable(struct 
>>> file *filep, struct kfd_process *p, v
>>>       return r;
>>>   }
>>>   +static int kfd_process_count_cb(const void *num, struct file 
>>> *filep, unsigned int n)
>>> +{
>>> +    u16 *ret = (u16 *)num;
>>> +
>>> +    if (filep->f_op == &kfd_fops)
>>> +        (*ret)++;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static u16 kfd_process_count(struct task_struct *thread)
>>> +{
>>> +    u16 count = 0;
>>> +
>>> +    iterate_fd(thread->files, 0, kfd_process_count_cb, (const void 
>>> *)&count);
>>> +
>>> +    return count;
>>> +}
>>> +
>>>   static int kfd_ioctl_set_debug_trap(struct file *filep, struct 
>>> kfd_process *p, void *data)
>>>   {
>>>       struct kfd_ioctl_dbg_trap_args *args = data;
>>> @@ -2927,6 +2947,7 @@ static int kfd_ioctl_set_debug_trap(struct 
>>> file *filep, struct kfd_process *p, v
>>>       struct kfd_process *target = NULL;
>>>       struct kfd_process_device *pdd = NULL;
>>>       int r = 0;
>>> +    u16 process_count = 0;
>>>         if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
>>>           pr_err("Debugging does not support sched_policy %i", 
>>> sched_policy);
>>> @@ -2984,6 +3005,14 @@ static int kfd_ioctl_set_debug_trap(struct 
>>> file *filep, struct kfd_process *p, v
>>>       if (r)
>>>           goto out;
>>>   +    process_count = kfd_process_count(thread);
>>> +    /* The user space program has secondary contexts */
>>> +    if (process_count > 1) {
>>> +        pr_err("Detect multiple kfd_process owned by PID %i, please 
>>> consider close any secondary kfd_process and try again\n", args->pid);
>>> +        r = -EINVAL;
>>> +        goto out;
>>> +    }
>>> +
>>>       mutex_lock(&target->mutex);
>>>         if (args->op != KFD_IOC_DBG_TRAP_ENABLE && 
>>> !target->debug_trap_enabled) {
--------------hVwVXdJ4u9426HHg8bTDaAEy
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2025-09-25 22:49, Zhu, Lingshan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:498cf72e-6204-41ee-8a22-d7be901a8f77@amd.com">
      
      <pre>On 9/25/2025 5:50 AM, Kuehling, Felix wrote:</pre>
      <blockquote type="cite" cite="mid:08ecb504-abb8-4ad8-bbbb-a18e19daffbe@amd.com">On
        2025-09-23 03:26, Zhu Lingshan wrote: <br>
        <blockquote type="cite">The user space program pass down a pid
          to kfd <br>
          through set_debug_trap ioctl, which can help <br>
          find the corresponding user space program and <br>
          its mm struct. <br>
          <br>
          However, these information is insufficient to <br>
          locate a specific kfd process among the <br>
          multiple kfd_process that belong to the <br>
          same user space program. <br>
          <br>
          For correctness and backward compatibilities, <br>
          this commit only allow set_debut_trap ioctl <br>
          work for a user space program which does not <br>
          own any secondary kfd_process. <br>
        </blockquote>
        <br>
        What happens if a secondary context is created after the
        debugger attaches to a process? <br>
        <br>
        It may be simpler and more consistent to allow debugging of the
        primary context, even if secondary contexts exist. Just ignore
        any secondary contexts for the purpose of the debug API.&nbsp;<br>
      </blockquote>
      <pre>Do you mean reject any set_debug_trap ioctls on secondary contexts, and only allow
debugging on the primary context, just like how we handle SVM and user ptr?</pre>
    </blockquote>
    <p>Yes, that is what I meant.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:498cf72e-6204-41ee-8a22-d7be901a8f77@amd.com">
      <pre>

Thanks
Lingshan</pre>
      <blockquote type="cite" cite="mid:08ecb504-abb8-4ad8-bbbb-a18e19daffbe@amd.com"><br>
        Regards, <br>
        &nbsp; Felix <br>
        <br>
        <br>
        <blockquote type="cite"> <br>
          Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com" moz-do-not-send="true">&lt;lingshan.zhu@amd.com&gt;</a>
          <br>
          --- <br>
          &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 29
          ++++++++++++++++++++++++ <br>
          &nbsp; 1 file changed, 29 insertions(+) <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c <br>
          index 662b181f1fd2..2df095e25c2e 100644 <br>
          --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c <br>
          +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c <br>
          @@ -36,6 +36,7 @@ <br>
          &nbsp; #include &lt;linux/ptrace.h&gt; <br>
          &nbsp; #include &lt;linux/dma-buf.h&gt; <br>
          &nbsp; #include &lt;linux/processor.h&gt; <br>
          +#include &lt;linux/fdtable.h&gt; <br>
          &nbsp; #include &quot;kfd_priv.h&quot; <br>
          &nbsp; #include &quot;kfd_device_queue_manager.h&quot; <br>
          &nbsp; #include &quot;kfd_svm.h&quot; <br>
          @@ -2918,6 +2919,25 @@ static int
          kfd_ioctl_runtime_enable(struct file *filep, struct
          kfd_process *p, v <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r; <br>
          &nbsp; } <br>
          &nbsp; +static int kfd_process_count_cb(const void *num, struct
          file *filep, unsigned int n) <br>
          +{ <br>
          +&nbsp;&nbsp;&nbsp; u16 *ret = (u16 *)num; <br>
          + <br>
          +&nbsp;&nbsp;&nbsp; if (filep-&gt;f_op == &amp;kfd_fops) <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*ret)++; <br>
          + <br>
          +&nbsp;&nbsp;&nbsp; return 0; <br>
          +} <br>
          + <br>
          +static u16 kfd_process_count(struct task_struct *thread) <br>
          +{ <br>
          +&nbsp;&nbsp;&nbsp; u16 count = 0; <br>
          + <br>
          +&nbsp;&nbsp;&nbsp; iterate_fd(thread-&gt;files, 0, kfd_process_count_cb,
          (const void *)&amp;count); <br>
          + <br>
          +&nbsp;&nbsp;&nbsp; return count; <br>
          +} <br>
          + <br>
          &nbsp; static int kfd_ioctl_set_debug_trap(struct file *filep,
          struct kfd_process *p, void *data) <br>
          &nbsp; { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_ioctl_dbg_trap_args *args = data; <br>
          @@ -2927,6 +2947,7 @@ static int
          kfd_ioctl_set_debug_trap(struct file *filep, struct
          kfd_process *p, v <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *target = NULL; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process_device *pdd = NULL; <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r = 0; <br>
          +&nbsp;&nbsp;&nbsp; u16 process_count = 0; <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (sched_policy == KFD_SCHED_POLICY_NO_HWS) { <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Debugging does not support sched_policy %i&quot;,
          sched_policy); <br>
          @@ -2984,6 +3005,14 @@ static int
          kfd_ioctl_set_debug_trap(struct file *filep, struct
          kfd_process *p, v <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out; <br>
          &nbsp; +&nbsp;&nbsp;&nbsp; process_count = kfd_process_count(thread); <br>
          +&nbsp;&nbsp;&nbsp; /* The user space program has secondary contexts */ <br>
          +&nbsp;&nbsp;&nbsp; if (process_count &gt; 1) { <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Detect multiple kfd_process owned by PID %i,
          please consider close any secondary kfd_process and try
          again\n&quot;, args-&gt;pid); <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = -EINVAL; <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out; <br>
          +&nbsp;&nbsp;&nbsp; } <br>
          + <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;target-&gt;mutex); <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;op != KFD_IOC_DBG_TRAP_ENABLE &amp;&amp;
          !target-&gt;debug_trap_enabled) { <br>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------hVwVXdJ4u9426HHg8bTDaAEy--
