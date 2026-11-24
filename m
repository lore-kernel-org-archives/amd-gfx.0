Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1323A606A321
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JQLAB1f0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E6BA10F37B;
	Tue, 24 Nov 2026 08:49:13 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010001.outbound.protection.outlook.com
 [40.93.198.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450DC10F346
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 08:49:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mcmx1WK8iDELohz0n1kpFaRTNlmMEKJuaMSvrOHEW8P65TEnwI0n+WuGgorIMTrWCD8TjC5PVa+9pHCSJbFWN3InBglksASdpmYc76pgGuzJXKKB2RS5MUJFRi7O55JwViLaNivWAExAVm9P8Qnmwd5E3cnNwtpauU6U7SfP9LSKCepSVbPxJzL+xGDFjKGegzKSb/wi8XxxXECUeKtqldx8iCea1Vb4KVbPRfdlzrITsKV0PNTFPoiujDyfhEIr7qeSulxV90g9fG0sIuVRtEtwV+M0PrXQLzWWSAoyq90/asuwmc3gez8qVmJsqzwx+8d6Bi/QG7hGEl2P/19i9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfvmicrhMme/fO1JRoEjx0x7voBmYc0mHDftgBzxvnc=;
 b=aKLT9ri4gW7SKSqmIlY8F1DVLCt4HHM6QbE8+zAZvitHQsBm+aQTGTxFMCoMhPpgBfZOWHINQlD/LmxQ/onXr/jFr4x5c7pfrP/zB8gCytyJiysFdv85H99//p98pddKkj+bP0AwXgWRZy+jiQEfbi9yRNP7p3sh97yZnUuML4OlWrq97GDmvw+cs0VX0gE8IGooOmdLC1WGjZN2hLvsClTXWoqEEUPG7ktiUjGkA/btjABajpz7Zv2nbaCWxg4jdojh+Cd7FUUH9O6Peg2rAewsedGUUk0iiPBMOTifqk8l6mO/NnNEQ2ZpESpwSb7gatg7JWoplfusWmk4SeQS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfvmicrhMme/fO1JRoEjx0x7voBmYc0mHDftgBzxvnc=;
 b=JQLAB1f05UVqmUx5MKKmtDylePdbfCSZuPN0JETZZh3BiHCLRMucL781Z75eTqe3C05PmF16RZvdwoOewVdzKiuum7XDQ+6a0GcjaiRp7CO9nzoN7CgGDUf/J6Vy4B/Qli1C6zeKKwLGsY+IBcN1sPTSMyP6i5JU0d6Qoy52vsU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Tue, 24 Nov
 2026 08:49:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 08:49:02 +0000
Message-ID: <78d76d07-9b2e-41b4-a104-4f074c50c60a@amd.com>
Date: Tue, 24 Nov 2026 09:48:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] drm/amdgpu: keep the A+A VF VRAM base at the SRAT
 address
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Hawking.Zhang@amd.com, Lijo.Lazar@amd.com
References: <20261116194727.397571-1-Zhigang.Luo@amd.com>
 <20261116194727.397571-2-Zhigang.Luo@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261116194727.397571-2-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: ab7360a9-2327-41ea-208b-08df4a07c9e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261009223027099003|22082099003|261021121427099003|261021123027099003|18002099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|56012099006|4143699003|261102123227099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: nScluQQyeoTBKvMR8Xev/fCSp6F9Qzl6E6JcXsP/bUKYnggTw7uIFP3e10WiFirILjklkuqQ67Sga4xDh0ARgIigq4QK2NipGoZSIQd8CQ4eIwI3dYT5aZLUNnin5yVEKLA0CgOvzh29SwzON4gRXepnYe73h9LqRYhh32rwM0UGW7N+rC/7TkqlsPpFUU8XC9iKguMKaOpnp6bhMcirmWypC4XtGhlc6zKo5FPAni132bY2AE8FseFuPSyJVUluE9uhaP/ua4kMAkruve0QwkpjBWyacgPQYMhO/AgOZob4cT2GQydEkZjuV4D+2h8eHN6tNdhyUAIW8taPyhI66KuBcJB4wgNxismuVyshKARjUSN0wZfwUzXf62n5dGxE5sG3CaWdywYnHzhRtIUZqcD9Ut5GlojNwvqwAs4qZSBwBfyfJp/TKs78wGTRGMbHNz5NY5yJql4gFC5ZdNVj/ZVYFOPnuHaTWYnldBqOAV+uXlb/bJkgb/NuIQqMp7IXXu+XpTDPKHggl6pAit40KElee2FIpx1igXZ5Mp15t5TnsmYdLcCuNMWPCHVfPHwRDfetNKnWtSiYeAaXTwjMBCJItl5qk3nf4cpd5NKHzuiZPr8Vw3i7VbGfknCF4Fxiog6FaRmPkwEVOoDWSbfVWic+IwqCiiIUw99oCd7V6uI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261009223027099003)(22082099003)(261021121427099003)(261021123027099003)(18002099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(56012099006)(4143699003)(261102123227099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZERORklHQkNMMFk1UUx3aDBxOGFhT21jUFE2Mld2MUxaRzVSTW01MUVmNUNp?=
 =?utf-8?B?RXZQM1RkRjlHeFVISU92dTNuWVVTT1N0b0JHWE1ZOHhNQVZINGNMMFFkR0Ex?=
 =?utf-8?B?VVJjZTNZRmVIVkVDcnQ2bDJFcmFuakNWK2pzaTBQTDg5M0ZPaEVwSXkvVjcv?=
 =?utf-8?B?MVg5dTVlWVQyRjNsVTVob1o3bWM1akR4YTdZOE9LcVJMV3FXQTl4VVRPZXcz?=
 =?utf-8?B?b0ZWOHZZUXhVSFdPSGpoa3ZXeXJKNFQrSjZjMVlyWjNHcFF2SUZmc0dFK3Jw?=
 =?utf-8?B?WkI2MkpmM0tBelRYNUVwV0Npd3krbnBmeG5IYjNnOFB1enpnM0tDZkNDWEl6?=
 =?utf-8?B?WC9kNDNEVHBMeVZnZWZPREUycGNZSTBuTk5jY3NHRHJNY0JxWGVwMHJSTWxm?=
 =?utf-8?B?OERkK1NxOXVHbHg1aS8vT0I4Z2RpdGxEZUpZM3BCK0RDMHNtSGt3UzZJcHF5?=
 =?utf-8?B?c0VMUE5CTkxVQ1owc1c2ejdrTWRNcUQ2WVY5RlFjYkhsSkNQeHJjS1hXd1E2?=
 =?utf-8?B?UHoyUWpPTHRKRzJXeEJsdzJIdmcvdDhOK0FBRXl2ZEcyWWRCdVVodG0rcWpZ?=
 =?utf-8?B?cExPM3E1cTlZNWhGV3J0NExQcDlEc09ZeXdVMjBtTjBZY0JQTVVibjlmcnpO?=
 =?utf-8?B?QVN6ODV5bEt1Y1ZHNmpsRnV2OFArRHJINyt3cHlaWTFoTExMaGEzWHlEYW1M?=
 =?utf-8?B?TnhXU0R5R1RvWUFBQURFN3EvZHRxQ1Z5WjhMTkxpZHRmZ2xQL1JKRW9wMVI3?=
 =?utf-8?B?VWJZOWx0ekxSMlFWQjQzZDlWVkEwa09HY1JuOE8rUjFicUJuS2xsaG13R0xq?=
 =?utf-8?B?R3lOZTN4UytiVWlMV2ZlTWo0ME5IdWxZUDZGZElmUnFZcDZHa3lRTjRYL3pZ?=
 =?utf-8?B?N25XNDJvRGpHM0lwajlQZGdYY2xaa2Vwd2RYZzZiSFJNc242QXlPK0UxeGE1?=
 =?utf-8?B?RHRQL1ZYbGNnTFJVckVzeC9oSmdTRkNwZk1RNFArcXlobmkrY25IYmFvRm9D?=
 =?utf-8?B?SDVFdnlqU3Rrd3lXTGVCOUYvS1BtNzZrNGZkNDk3YytJNzJLS2p3YkdtVjUz?=
 =?utf-8?B?a21HSElwYktVUE5Pc0Iva2djVlJMQzR2Q2dnSGg4cDVFdk9rK3lNSE92U0Fh?=
 =?utf-8?B?TzFHa2Q2elNMZ2w1TVkxQ2NKV05Mc3Y4QTFXeVZmNGZIYnVuanFDK1lzOEVh?=
 =?utf-8?B?c1ZhK2lsVjl0eE84THBpNVQyRXVGb0pZR1pTSjlBQkkvSFNERm85M3ZEREFQ?=
 =?utf-8?B?OUkyelloalZFNVh4MmtHRFFtS1FBNUVCMkhVMmJyRGcwbTZDdzF6cGl0dk9m?=
 =?utf-8?B?UlFISXhpcWt4NzNVSGtmOVNLMkgvQjBGb3BPZHptbU50T1Y2RGN5TmZzS3hR?=
 =?utf-8?B?My9FYk1KOVlkaUJ4QXhHY2didWF5WERrMEx5QUpwMTIzQ2lWM21OTUJMbGVE?=
 =?utf-8?B?M1FUdHg5elIyVDJ2SkFaM1Zhd3BMNEZ5TFo5WGt2OHJLQ0VSejdVRnZRQ1dD?=
 =?utf-8?B?YnRXUzVwa0NDb1hmYmpRcHpaVlk3S0ZRenFXcW9BV1VueVY4SWxiT2lQRFN3?=
 =?utf-8?B?RmtSMldzTHhXclFJeVVYWDRjNlh2YlA4bFFna1JTK1JZbVFJUjRSdis1NlpS?=
 =?utf-8?B?aFpCV0NXbUtEZnlORWJrb0x3Rk8vY1ZqaG1VU0tDL0hOb3M1YVJNemFsUEd6?=
 =?utf-8?B?R0I0VENDSDFIV0hqemVPL2ZHRTVqOVFpS0xOR2ZmbzQ2NkMwMG5wNjlLODRn?=
 =?utf-8?B?SkoxVTRYaFRZM1hlR0QwT01WZUZzUVJQbTYzODMzMEplZDVIRThLNHY2a0k0?=
 =?utf-8?B?dHcwNzZtb2VlYnVVbTNPbUZFZ1hNMFF1Vm5sZFBtNWMzQzBUNDh1TEdyWnNS?=
 =?utf-8?B?MjJqV0J1WjFrRy81Qkc1Wlo3NTB4RnhWbkJhV1k0UHNhOXZpRmNMWGlNUVBF?=
 =?utf-8?B?MWhXVjZnRjBlUDIycS81enp6Smt0aG5hbEQ2UnJIK2NHQlhMNVlKV1ZoTUVS?=
 =?utf-8?B?Nmo3OU5MbW03dTBHZDczTWlZYWlWVEpoQ3FRZnpPY0Y2b1JqNUlxaDNlS3Nm?=
 =?utf-8?B?MmpmSTZ2dVM1ZWN2blRYUTE3WnBmdm5OYy9aNmRqNFJxc2FDdXp2VlJUdHYx?=
 =?utf-8?B?TkNCbTR1d0dvbk50QkMrc3VOc1lPMTRaaU10b3dYTFRSWlpDWnk5bE5wdTlr?=
 =?utf-8?B?S1dENWFpTXgwUXVzN3FBZ1pyQjBMdTBhSnpqWm9wVnQ5N1o2b3hDMEZPRVFB?=
 =?utf-8?B?N0ZaY3kvZTNjZ3lueGpsYnZRcmJGang3U3p3aU9NRDczRnJSalJTU1hXL0hw?=
 =?utf-8?Q?Fk2U6Gjsv4rWy9Hm45?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7360a9-2327-41ea-208b-08df4a07c9e4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 08:49:02.6155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gw0SsatdnJumScBsoez9Kx4IG68IKA1EWmYYflvVHSR4jLnerQTdgO5XFPVvZ2oi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/16/26 20:47, Zhigang Luo wrote:
> On the A+A VF the hypervisor reports each VF's VRAM address and length
> in the ACPI SRAT table. The XGMI LFB region and segment registers
> describe the physical GPU, not the VF, so the node id and segment read
> from those registers are not a valid VRAM starting address.
> 
> Read the SRAT length in mmhub_v4_2_0_get_xgmi_info() and report the VF
> as one physical node at id 0 whose segment is that length.
> get_mc_fb_offset() reads the SRAT address on each call. mc_init copies
> that address, plus the node product, into aper_base and sets aper_size
> from the segment. Node id 0 makes the product zero, so the PTE base
> stays at the SRAT address.
> 
> v2:
> - Explain that the SRAT address is already the VF VRAM base and must
>   not be adjusted by the XGMI node segment.
> 
> v3:
> - Report the VF as XGMI node 0 of 1 instead of special-casing the
>   node offset and the PDB0 size.
> 
> v4:
> - Read SRAT in get_xgmi_info() and derive aper_base and aper_size from
>   the FB offset and the segment size.
> - Move the 8GB GART alignment into its own patch.
> 
> v5:
> - Revert the SRAT aperture commit with the other two reverts. Leave
>   mc_init on the restored connected_to_cpu path.
> 
> v6:
> - Read the SRAT address in both get_mc_fb_offset() helpers on each
>   call instead of caching it. Keep the SRAT length as the segment
>   size.
> - PDB0 is already enabled because the VF is CPU-connected. Leave
>   amdgpu_gmc_is_pdb0_enabled() unchanged.
> 
> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>

The handling in gmc_v12_0_vram_gtt_location() needs some more cleanup, but that wasn't messed up by this patch in the first place.

Reviewed-by: Christian König <christian.koenig@amd.com>

Sorry for the delay,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h  |  8 +++--
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 16 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 38 +++++++++++++++++++++++
>  4 files changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> index 5f36aff17e79e..47092ec6dff2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
> @@ -79,11 +79,13 @@ struct amdgpu_xgmi {
>  	/* from psp */
>  	u64 node_id;
>  	u64 hive_id;
> -	/* fixed per family */
> +	/* Segment size. Fixed per family on a hive. On an SPM VF this is
> +	 * the SRAT length of that one VF.
> +	 */
>  	u64 node_segment_size;
> -	/* physical node (0-3) */
> +	/* Physical node, 0-3. An SPM VF is node 0. */
>  	unsigned physical_node_id;
> -	/* number of nodes (0-4) */
> +	/* Number of nodes, 0-4. An SPM VF reports one node. */
>  	unsigned num_physical_nodes;
>  	/* gpu list in the same hive */
>  	struct list_head head;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> index b13967a1c8fba..837ad28530e48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -53,6 +53,22 @@ static u64 gfxhub_v12_1_get_fb_location(struct amdgpu_device *adev)
>  
>  static u64 gfxhub_v12_1_get_mc_fb_offset(struct amdgpu_device *adev)
>  {
> +	/* SPM VRAM starts at the SRAT address. */
> +	if (amdgpu_virt_vram_is_spm(adev)) {
> +		u64 fb_offset, seg_size;
> +		int r;
> +
> +		r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &fb_offset,
> +							&seg_size);
> +		if (r) {
> +			dev_err(adev->dev,
> +				"Failed to find SPM VRAM in SRAT: %d\n", r);
> +			return 0;
> +		}
> +
> +		return fb_offset;
> +	}
> +
>  	return (u64)(RREG32_SOC15(GC, GET_INST(GC, 0),
>  				  regGCMC_VM_FB_OFFSET) << 24);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index 7e0b83b1015fc..14ef841d70365 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -707,7 +707,7 @@ static void gmc_v12_0_vram_gtt_location(struct amdgpu_device *adev,
>  			amdgpu_gmc_agp_location(adev, mc);
>  	}
>  	/* base offset of vram pages */
> -	if (amdgpu_sriov_vf(adev))
> +	if (amdgpu_sriov_vf(adev) && !amdgpu_virt_vram_is_spm(adev))
>  		adev->vm_manager.vram_base_offset = 0;
>  	else
>  		adev->vm_manager.vram_base_offset = adev->mmhub.funcs->get_mc_fb_offset(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> index 4495d52b4b07c..ba4483948ce5f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> @@ -132,6 +132,26 @@ static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_device *adev)
>  	if (!adev->gmc.xgmi.connected_to_cpu)
>  		return 0;
>  
> +	/* The SRAT entry is the VF's whole VRAM. PF_LFB_REGION describes
> +	 * the physical GPU, not the VF, so report a single node. The
> +	 * length is the segment size. get_mc_fb_offset() reads the
> +	 * address later.
> +	 */
> +	if (amdgpu_virt_vram_is_spm(adev)) {
> +		u64 fb_offset;
> +		int r;
> +
> +		r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &fb_offset,
> +							&seg_size);
> +		if (r)
> +			return r;
> +
> +		adev->gmc.xgmi.num_physical_nodes = 1;
> +		adev->gmc.xgmi.physical_node_id = 0;
> +		adev->gmc.xgmi.node_segment_size = seg_size;
> +		return 0;
> +	}
> +
>  	xgmi_lfb_cntl = RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
>  				     regMMMC_VM_XGMI_LFB_CNTL);
>  	seg_size = REG_GET_FIELD(
> @@ -177,6 +197,24 @@ static u64 mmhub_v4_2_0_get_fb_location(struct amdgpu_device *adev)
>  
>  static u64 mmhub_v4_2_0_get_mc_fb_offset(struct amdgpu_device *adev)
>  {
> +	/* SPM VRAM starts at the SRAT address. mc_init copies it into
> +	 * aper_base.
> +	 */
> +	if (amdgpu_virt_vram_is_spm(adev)) {
> +		u64 fb_offset, seg_size;
> +		int r;
> +
> +		r = amdgpu_acpi_find_gpu_memory_in_srat(adev, &fb_offset,
> +							&seg_size);
> +		if (r) {
> +			dev_err(adev->dev,
> +				"Failed to find SPM VRAM in SRAT: %d\n", r);
> +			return 0;
> +		}
> +
> +		return fb_offset;
> +	}
> +
>  	return (u64)RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
>  			         regMMMC_VM_FB_OFFSET) << 24;
>  }

