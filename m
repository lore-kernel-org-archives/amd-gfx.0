Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0012D4414C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 11:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8634A10E03A;
	Tue, 19 Nov 2024 11:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uwt9UCdQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B779010E03A
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 11:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dshHvCAFcep+gM/RspwFCQ6yTYTa2AbVxbGnCj5q/9essqvnU7fP8y7s9w3SCgtEZ6W6krRzI0OT0rN0UCITsXbMq7Q7ppe3s8VEhwYLnUoEylIm3WCi59ZFhzG7eU2aHuc/9wwKt2UYaEnL5dvbPUiff31iEXG8ZdZiu+Ok0nl1Sgb1O54wf1Zso0YwM9S96l+YHZPxAlPejqCb96nJoKpYx03ae+7Zo/xIFc93KMzgt4nVtHVldGqLYPQDqdK5vB/r109wZOqCZT3a/32ldxQQ3gIsIr/f702+pQ2nEI+jS0/vSkSLQwnD91HbZy1PP6CKa6+kRXd0/NAUXkWqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nmWUFnmtOnwkJwBZSOdUZi1HJhUTou4HZKlVcUwfBY=;
 b=XzSsZPjDZo85rAuWes63ZAs2nljzxgGGKGN1nTgh4iaiKKg0c5qblTqKmFLvD6MtaCguRrT5cKMRT3ZWGHAumKoqnTbjPYKC3UN5oWr5zYvbviCHgqZOgEIgtjPj/0jjB2Jg6b+Q7zQDHEJ2q1FTIBmaAJ7I7iVPFQI4khpvyXnFA6JEdCE3Ai0n7gFs3th8R1ozEeIgGVsRVyW1v+pSIP2avqlWYqS9Lj9R1sc5fa0WrFX2P2BY+HxTN4uKW3yr+TCiww+7+TExt97TckvlcXMUbwyHI9iPuge1xYgBfxhnvfog59WU+id3hBxp0JRuS3lCAuUDW5XIWjMT5tiClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nmWUFnmtOnwkJwBZSOdUZi1HJhUTou4HZKlVcUwfBY=;
 b=uwt9UCdQHJeofGmvVeYEl7kbCIGNBfNW55n2zYUjDzRRX8ixDM1gdBcwY5AqaaKpB7Sc+9DSo7B9CVjIIRJQI+iPduX+4bj2afcoMy6yK8Ru55M97L2JGqHPPM9Ki7Sqw4w3S704/QampW09lS6XsHxSRQ0qtd3myFeZAGMjWMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 11:57:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 11:57:31 +0000
Message-ID: <025f4cc8-17d3-4ed7-bd01-2f82feeb58bf@amd.com>
Date: Tue, 19 Nov 2024 12:57:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: reset fw_shared when VCPU buffers
 corrupted on vcn v4.0.3
To: Xiang Liu <xiang.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, leo.liu@amd.com, hawking.zhang@amd.com
Cc: david.wu3@amd.com
References: <20241118094737.1024533-1-xiang.liu@amd.com>
 <20241119105739.1047372-1-xiang.liu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241119105739.1047372-1-xiang.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: d0a4560d-b330-4403-7fcc-08dd089158b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nm1heFpTb0lKMTZDbnhwWDRCQ0tsTzExUzVqbTU1RkUyUUZ1SnJ5SU8vQXR4?=
 =?utf-8?B?LzVXVHArM2FwN0RWVFRIUDlVeml6SzVrekhvODcyV0lPaDdGZHJCemhKS2Ex?=
 =?utf-8?B?d0NzUnpBQ0tmZ1A2dHNEdXZmTlFOU3hSTXVKb1hoNi9wWmtoRGFFRTgxZnE4?=
 =?utf-8?B?Z25BRVN2d1psRU9sK1RGSUhXSEVMQjFYVGthb0ZYdDVyRFNLQVpGSTVlWUto?=
 =?utf-8?B?K2N2YTNuOFhUVGN2VzNuM201dk03dXU0VlQ5ZUdJS2Fvd3dFZU9ZRFdrSEJY?=
 =?utf-8?B?UVVHK3R4TUVMT1JXT1VnZGVMbFdVRFR6NlljY0hvQ0M0Yi9aZGxHZ3FhbHlj?=
 =?utf-8?B?L25zWWdPeGRzTWREejJabG9rbE1xaW9vQm5QTUhxVFdPWGhadkRuelVMbzJs?=
 =?utf-8?B?Y0FYSFJFa0kya1VnOGhRY0ROMlhmM09lOWZBQnExUEZ4ZkhNVkNCRW5LS3N0?=
 =?utf-8?B?ODlhMm5MWmh2RXZVcS9aQ1M0Ni9oV2g1eVZ1bFBqejFwTVhOcXNvRk5Jc2U2?=
 =?utf-8?B?M2xhazNrUlp6ZXh5cWgrMlN4aWUwYUFQOEcvbjJIRkZwRTZPcTlpSUZNaVpB?=
 =?utf-8?B?ZlpobzMzOHozR3lQOGU2NUtpdkdYZ1JwaTdRemJEdlc1MXF2VlJrUDEvMzJo?=
 =?utf-8?B?SXpJZkk5aEV2U0crY0ZYV0lVTm5OTkZHZ1JyQ2pBUm9SZTNJMWJOaFZSdjlv?=
 =?utf-8?B?Vk5XYm5BRkJha2tKWVM5T3NWZFI5N25tRmNoQnQ4UjJ3RzNGOFJNdG1NOXVJ?=
 =?utf-8?B?MTQ1YjFsTDVlc1ZONVZMcWdKeTFhRmRCbE5LRjc2dzRkM0dIcUovWTdKbFZo?=
 =?utf-8?B?eDBWUmc3NUlBdVBSYlUxL3MxKzlkbVRjYjFBUG93VW1VRHJVbjdRei9yYXJ6?=
 =?utf-8?B?T280c1J4ZTNNcUtiZVk5SDdLOWhpck50Rk02QVFkTHA3TlpEbEdldTBiY0w1?=
 =?utf-8?B?dDBTa1lsd1c4U01md3FrQWNScjdycW91VnhGZ1FKUnlrcFVIc0I0d1hHZkI0?=
 =?utf-8?B?RkZOVFh6bDl6RndMZzNxZEZWY1Nxb3FzWHU2N3d5cE9DYlB4UFIyM0c3TGtz?=
 =?utf-8?B?bEpyK0lNcTJHcWF4Q3ZhMHptVzJIeU1HUjMxSmg1NmpPOURXZzBmVDR0ZE0z?=
 =?utf-8?B?RGRSaUNtcGZzSURiQ0U1S3pQREJjMDEzNGorL3dlUGl0cW9MU2VmK3Z1Zk1i?=
 =?utf-8?B?a21MTU8zWTE3MnhTWnorc0FBNkVSbmI1NURtZng4b3JFNXh0YldHSGxnNVd1?=
 =?utf-8?B?SzM5c2c2VmEzdWE1cWVtWFdjTXNkWnRtblhKeE80cnZQTlRKSHdOTjUrTW9M?=
 =?utf-8?B?QUEyeE5DT3ZVWmNGSE10OTVMNG9KVnRZbnEyNmVaOEtMYXNpREhOWTlaZFdW?=
 =?utf-8?B?VU1VOU5Bc3pEdEdzT0ZJWkRGMzRJMmVWbElrK1BUaG5Fc2FJcENGVFQ0ZkFz?=
 =?utf-8?B?MDRQaGc1ckx3aGZkR2hGUGZXekZ1RE9Dd1ozZ3NSOCtSQ092ZGNHTWNKVSsv?=
 =?utf-8?B?UHZtS0w1N3l6UlpTV1RRV0VyKytHYXREdmVoV0dlQk1lKzV3MUxZTWxBQitM?=
 =?utf-8?B?NmhxUkI3OUg0VGVRYTBURExpcjVlaE44WWZ0V1g4dFovczVDNjJvYkpYSGNo?=
 =?utf-8?B?UDR3Q3Urc3NGT0NWQVkyTFkrN3V6d21zWFB3eWNNWGJ5M1lyTG5OYkc2a1dq?=
 =?utf-8?B?Z2Zic3AzSFphaFJjREp4NU8vc043bVdXYitPVTRTTHRkbUFBUEVONWVYSkV2?=
 =?utf-8?Q?3xEKrmTaHWCOL6CZs/yL3lSgKm72/BfbWUgg2pB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NStCOXFaM2tMRGlUUmpPeVEwbHVPMVhEUzRrNGl1Q2V0V0NJc05yaGx3TFFq?=
 =?utf-8?B?VDB4Zk13ZjFKYUc5ZUJ4dUlwN285TVBtbGNXcHZyL3RudUYrcHJyMVdEdHRP?=
 =?utf-8?B?TGdkZkY2RU9QekE1M1Q0M2hkR0NQaWozMmxCb1RRS3VIcGFENFM4UE9nZzFq?=
 =?utf-8?B?R3VoMGo5ZHRoWTU5UExSckUvNGRKMWR4Nmg4STdDblE1VFprdVUrdXMxazJ0?=
 =?utf-8?B?d00xekQ1d3hPTFdvYS9BSzJLRmdSczYzOXFsNzB2TEhWUGxvMkNLS0grMG1H?=
 =?utf-8?B?UlNBS2JjYUExVlV5YnpCK2lQVEIxZWoramZva1BKN1NWVHpIT0FmUWxjRVc2?=
 =?utf-8?B?elYrVldZV0pldWlHQUZHZlBIKyt1MlNEMDZMN1hRZzE3cHd0RHNKMEhMdTg5?=
 =?utf-8?B?NFlXNFJZWFJ1ZzVzZHN3N29TMXhkNE1ZM3N4S25OWkdFUS9RcmlRWmxpN2c2?=
 =?utf-8?B?MlZkZVpWSEYySmNyVWRiUmxLdVhSem1xSTFyWFh1dFRUakRhS3dvYXdHL3dP?=
 =?utf-8?B?MDVvYi9wVHhqTEhGUllqWElBektianpQbHhWNlArOFNEZXJhdFQvanN5MDBt?=
 =?utf-8?B?L2R6ZERBQzA1WnljNU1pZ25aUUxJdERYVTY4ZTM5Z2xGRmpLVE5XUVdHcUMx?=
 =?utf-8?B?N09RZmlwYkJLdWdHNEdRSlUzLzZCNVMyc3ZQdGV5aEJRajh2bHVKdnJkVVNz?=
 =?utf-8?B?RTk2SFVta3J6ZkZUK09kY2c5N2U3QndqZEoxMGhLbzZBeHYzUDlKZFdHaE5O?=
 =?utf-8?B?UC9Td2xUS0p4MG51VnhKVkVBMS95cWVYRzhiK0hPalFjME0yZ2dJWUttdlNz?=
 =?utf-8?B?RnRxUjlqdkltTC9ibXpvOTJMRFViekpxd2UzUjNLRVY3d2VXUGxQQ2tCMjZQ?=
 =?utf-8?B?KzVDRHdsY3B1enBlaTQ1dE5mN2dwME51MUltTm00eWk4RXI0VjJwN0h3K0c0?=
 =?utf-8?B?a3h3QVhPRXB2aGoxbEZpNDVqalV3dWlQeWdXbDMvTzN1ak1jaUUxWmNyNzBq?=
 =?utf-8?B?dFFwbFhqZC9zby8raHZLWlBrK2grMzFGUDU1S2lpYUt5ZGM2T0VvZ3EyalVO?=
 =?utf-8?B?eEE2K3FIOEFIeFVnbnYzRWtqMk5oNG5LbFBFR0ducktXcWpHdnpxY09ET3NE?=
 =?utf-8?B?UFFNTEdpM0I1NWxDYUdqMklVSmZoa2I3aFpUWnI1bHpOVE9hRWJrbWxKQjNC?=
 =?utf-8?B?aDl3VjVud0JYbkZwSE5LdzZnc0xoTzF6R2VvVzJkTC81SlJjMXBPWmt2bkhK?=
 =?utf-8?B?ek1aMFpSaW4rNTV2Vk9hVGVxYmNYMkkxNkZ5TUcwQ0x0SExwYk8rWVlhdmZj?=
 =?utf-8?B?M1k5SmFyaFN5c1M1ck92RjlndTlONFBRVnJkdHd5OFVmYk1pTmVQbHlEcHc0?=
 =?utf-8?B?T3VMcUpOWHNRUVdIQkU1bmVFcDZuZm8rZjF1U1lETzVjRWkvZ3RzdGYvL29O?=
 =?utf-8?B?cHNyeExLTWdxeHRtWktPRkV5Nk9qUll5eDdnUVU4YU55eW1TRFByT01QaWF4?=
 =?utf-8?B?QjREQjRGQ1FHWWtwTWoyUTV4azFYdlVlbG5DSmxWV2lrNjNhQmpldE5iRWJ0?=
 =?utf-8?B?NngzV0ZlSFFQMTEyNE9WamZETDVJWjhKNTJJTnZaSDYyNkNwd2NTaExhWjl5?=
 =?utf-8?B?N2JwTTlrbndjdkQ1QXVzbXJGT0ttRHNUZkkya2pST3dSSFd4VU9ERTNsK1Zm?=
 =?utf-8?B?aXdNN3ZQR2F2L2pqbVg3RlRxUEw5T09xcHVTTTVQMy9PaDJ6ZjVEQlFySjVm?=
 =?utf-8?B?c1VEckJrWENsYU10bFpxMUl3dTRpVFJYeTcvUEM3OXZpTTV5ekJSVjdkTzBO?=
 =?utf-8?B?VDBETjhzRTNZVTVWbEorcHZBMEMxUC8xRlBmV2hCQWMrNmNhbkRmL1NtYnBB?=
 =?utf-8?B?aHFyakw5VHNVUlJKaDM5WGM2R1NwaFRyVGdDRXgxK1FxU0JCTWNNSEg3RWdz?=
 =?utf-8?B?elNaS2JQOWZNZFZVWnRWMm8rdGtRbW0wY0QrV1JYbTc0aUhzSFRPWGlMMFh6?=
 =?utf-8?B?c3NtUWxHeDFqNklkamdRMTNvclczUkhGYUFBQTluRzdXcVdqR2g4aldxdXRm?=
 =?utf-8?B?Nnh3SXV6R2RSalJZYzNDZlhYYjBXeWt6dUxFMEh3TnJCYWtMNTNNaFJSS2RO?=
 =?utf-8?Q?cv5g=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0a4560d-b330-4403-7fcc-08dd089158b3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 11:57:31.1220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSeUDA5RcaVOZKrRr8cWv+dewoO7d46WGJGjwp7eVXbwFSZsUhjWej7sbd8PELSr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
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

Am 19.11.24 um 11:57 schrieb Xiang Liu:
> In the case of RAS err_event_athub, the VCPU buffers are corrupted and
> cannot be restored in amdgpu_vcn_resume(), the buffers are cleared to 0
> for good. However, the fw_shared stored in the buffers need to be reset
> , or the firmware cannot work properly.
>
> v2: Remove redundant code like vcn_v4_0 did
> v2: Refine commit message
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 32 ++++++++++++++++++-------
>   1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index d011e4678ca1..cf8264bf45c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -123,6 +123,20 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
>   	return amdgpu_vcn_early_init(adev);
>   }
>   
> +static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
> +{
> +	volatile struct amdgpu_vcn4_fw_shared *fw_shared;

Please drop the volatile here, that usually doesn't do what is intended.

When you need to make sure that the hardware sees the written values you 
need to use a memory barrier instead.

Regards,
Christian.

> +
> +	fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
> +	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> +	fw_shared->sq.is_enabled = 1;
> +
> +	if (amdgpu_vcnfw_log)
> +		amdgpu_vcn_fwlog_init(&adev->vcn.inst[inst_idx]);
> +
> +	return 0;
> +}
> +
>   /**
>    * vcn_v4_0_3_sw_init - sw init for VCN block
>    *
> @@ -155,8 +169,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   		return r;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> -
>   		vcn_inst = GET_INST(VCN, i);
>   
>   		ring = &adev->vcn.inst[i].ring_enc[0];
> @@ -179,12 +191,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>   		if (r)
>   			return r;
>   
> -		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -		fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_FW_SHARED_FLAG_0_UNIFIED_QUEUE);
> -		fw_shared->sq.is_enabled = true;
> -
> -		if (amdgpu_vcnfw_log)
> -			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> +		vcn_v4_0_3_fw_shared_init(adev, i);
>   	}
>   
>   	if (amdgpu_sriov_vf(adev)) {
> @@ -234,7 +241,7 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>   
>   			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   			fw_shared->present_flag_0 = 0;
> -			fw_shared->sq.is_enabled = cpu_to_le32(false);
> +			fw_shared->sq.is_enabled = 0;
>   		}
>   		drm_dev_exit(idx);
>   	}
> @@ -280,6 +287,8 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>   		}
>   	} else {
>   		for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +			volatile struct amdgpu_vcn4_fw_shared *fw_shared;
> +
>   			vcn_inst = GET_INST(VCN, i);
>   			ring = &adev->vcn.inst[i].ring_enc[0];
>   
> @@ -303,6 +312,11 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
>   					regVCN_RB1_DB_CTRL);
>   			}
>   
> +			/* Re-init fw_shared when RAS err_event_athub corrupt the VCPU buffers */
> +			fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +			if (!fw_shared->sq.is_enabled)
> +				vcn_v4_0_3_fw_shared_init(adev, i);
> +
>   			r = amdgpu_ring_test_helper(ring);
>   			if (r)
>   				return r;

