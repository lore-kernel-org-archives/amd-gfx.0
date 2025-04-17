Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D098EC369B2
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Apr 2025 16:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77AA610E1C4;
	Thu, 17 Apr 2025 16:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SwDtdNd6";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2D0B10EB7C
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Apr 2025 16:24:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuGx0L9D24c0vTruuRWadmfj6rSEVsUiW74+TMFs3re+mMy3KWhnFKQlwlJLYRPGgDlOEZczCk9BCaevqFMmw7HoWpVFe/gb2C7qb7/wGfWSXmNpHRzsvT/n1Bdbb8kK2YmlfAnVWTNQ5gUhhE74im4OwcOBhQkUAoso/rIKiOz9oXFxkcQSB+rXsvFR72XbCkXbEGE+iznLNuqVzUCHK8f2eQ4++dMBmaGX7ZXSQ6k6rQjlswZcDzDGen5TlfLtD/nx8Sr7EzXCbmOG3mUn+qTkPVVGx/fYbXnwSdjseOeGnVMB8EWTfIJz90VRkXZWpAqchuVyDaT2q+QktHZbzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxlLFneaVfqlBfO+0HG7RH+wgnZcw1wK6SNL0nbTINk=;
 b=YwJvmefo8rt6DsufpGKZ+C1q7CZ3xSTjAUwz7Swu240tnxVMDP5tRbVPyUJFbr8ad2WzvxKmQ4OptRedW27KkAcTNJk6P2BTSYA6fT5yjQNjMiwm5JzPgaWmQL3iQKrv0avJvwebgc2Kjfc38oJGCbByoDVu1UhFNgegsZ0T8zt74uNqmnsNL3sqFD1E95lroLQUJof2HAbUKJY895nm6MsnQ+jyfKJ2PpZAbGvs0cT+RAwPWohTlgD2As88pFOwemQFAlSPQE6LMxZL9CTZGY58HjACfW/wvj4boo77/v9gxlKikrPhkrCOfZxXeZ7TSBpWeeXYri8K9FkOYguKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxlLFneaVfqlBfO+0HG7RH+wgnZcw1wK6SNL0nbTINk=;
 b=SwDtdNd6ja8NaMdOlJF2vXT+g0kaKwLyLEhjb0v/uLPWaey8poKhPRii2BR5rHQ7JM2x72SpVETrvI3S6LLE3XrI5xsjc6H+TzVG4quQ52DgoKGdz88Laf10A+uAKcg+IuvgK91C5ZHunnGewfFL+vh8sK0yTAh6v2b1wrRWqsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Thu, 17 Apr
 2025 16:24:23 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8655.021; Thu, 17 Apr 2025
 16:24:23 +0000
Message-ID: <8e94a695-3c22-4269-9292-cf86d5328c29@amd.com>
Date: Thu, 17 Apr 2025 12:24:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/amdgpu: Don't pin VRAM without
 DMABUF_MOVE_NOTIFY
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: yang.su2@amd.com, hao.zhou@amd.com, asher.song@amd.com, pak.lui@amd.com
References: <20250417133352.1204510-1-felix.kuehling@amd.com>
 <094e983a-38b0-4a05-8b65-50a7f2f4ef56@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <094e983a-38b0-4a05-8b65-50a7f2f4ef56@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::36) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc61967-fd93-48ba-aa7c-08dd7dcc5017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzNQM0k0b2k5V1BNZG1YNUZwdDBVb2tLazh6aHhxTThmZVY2d050OCtoSE8r?=
 =?utf-8?B?SG12ZTN4V0R2Q28zQ0lqM2JFWi9vR2J3dHJTWVkrRlhEbkoySE5hNUp6anFN?=
 =?utf-8?B?MXNtRmNJckVhSmE2MnhPSFVHcEhmUDdIR2dRR25acnh4RU95cVRseVRVVTFD?=
 =?utf-8?B?SFVJcmlPdVVjTW1VMFE3OTVvT2ZDSVBlY3F6VldIcFAwVUkvL3ozV0VsaFVU?=
 =?utf-8?B?OUx4NHFHUW9xRXJSYytVYlI0WENZMFQyNXBPbTY3dkpxRWxnMVZyaUlqb29z?=
 =?utf-8?B?M21nL2h3bzBVaXpSbXpQbTE5bjZFdUQrZmNmODNBbzVkV1dKTWNqOW1mSzYz?=
 =?utf-8?B?ckVQQzhhT01LdFJtMW56b1R1dkxTMVd2VHVZQXB6QTBIRUNYenpwYmF6N2tk?=
 =?utf-8?B?QUNNTUFsQjdjS1hrTll3a1EzYnFuRVZFSnZaeUcrMjBlL0ZKM2ZTWWU2U2VH?=
 =?utf-8?B?RDNkWllCUzRZMVhCU3JsZlorNFBTTG9NVlFBUGFzOWsydnNuVUtIbHd3bCtk?=
 =?utf-8?B?SzJ5SVZrcC9EV2tEb0VIMU04KzU2V1ova2hhdlRsL3RleXhlazVBaldTTU1h?=
 =?utf-8?B?cG12NWFpVFF0ZFlHV3MrZzROREcrL1ZlVE9DbmtsNTFZMEE1dWtnQ2gvYlB4?=
 =?utf-8?B?anNvaDdnRGJZSWtEZCsvanhRTlcyM2tYNFdTbzBqd2xFUWoxZHBGNWRNc0JI?=
 =?utf-8?B?dVZtTitQTXFGZ2JhRlI5NXU3elVnNGNGbXVUcENLRFAxRUJEWWpEaFh4WU9E?=
 =?utf-8?B?cWRRdE54bm1JdlZCRUw5elBCbzhjVVZJQ2lFWnBuNUZwM2REMkhZQmFqUkxD?=
 =?utf-8?B?aHNvWmNlaFZwTmJoV3ZIRUVTSnlFdkJRbTI3KzRER1IwU0MxTklmY3AwaFdm?=
 =?utf-8?B?WWpvaVErYWpFSk13WE8zZksyU3p1YmVaR0YxbGZ6OUN0Z0pjT1krZUNIZVc5?=
 =?utf-8?B?VWYzbXdGNE55MUo0ekFFMnowMVdaSU9PMytNTG5BQjJOcUtKRUdmZkt5c0FY?=
 =?utf-8?B?am9BUlhtMExLNnJHQkNkYkRGb1hrZmxNT25ZeFZGMFFLM3VZS2dVcDRtUERY?=
 =?utf-8?B?UnJEQUViSnZJS3hOS1JScTBHOHRuajVYWEZnRnhOTlB1dUhnUkRVNGtDQnlm?=
 =?utf-8?B?NmhHSUNpMnJwSHlmdjRuM29EZVNSYU82S29udDhDOUZxK1VYTkZMeCt4aFpM?=
 =?utf-8?B?a2ltSkNBNFdGZ0hSSUtIY21NTHZ2N0VpaU03NlM4Z01zSDJOZjQ5Q2RDSjBr?=
 =?utf-8?B?SmlsTEdTU2FiOXVFL0FNRGdrRkFkc1N1OWVGeTB4dk9hMUVWdk1kUGFXUFRU?=
 =?utf-8?B?bzVsMkNCM0tJendPM3RGenh4WDJrZGxTZUlqYXNSN2tYQkY1NWF5ZDJMNHY2?=
 =?utf-8?B?Q0NJRjJDOUpaN0lxWWtxK1VKWFYxVEUyV040NHpXb3AycHI2U1dFMEdndi9I?=
 =?utf-8?B?QnFKcmgvaVRyZHlwcGkwRE5FT2pMSk1icDNDL0lYdzdFQXVBOTVkQVlOR2J1?=
 =?utf-8?B?Tjg1MVp2NGVHK1dXRXpxYTBQajFFSEcyVjh4ejVDd1h1M3JyM3pYbVhIMlRz?=
 =?utf-8?B?eVNmcWNzWnRVZFhsTjJGSEw1T0lORmt5cU5RTG9iKzhxRGJGUmpkeUFmelVh?=
 =?utf-8?B?dlFZbDNVZmF5eW5YbXY1TzhxQVRiR3J6dVNwQ3BBVGxBTEtlSnE4UVNZeUgy?=
 =?utf-8?B?SzVDenhkRHVyWHBqWDh2T3FoVlN2dGg3R09DSzB4Ymt5N0FzTERsdGFxUXh1?=
 =?utf-8?B?clFRUWdINTBSV2ZSQkNuWEl0NFhUVnJrVXVVclp6VjFMUW1iVTJFVnZGcDN4?=
 =?utf-8?B?M3k1bVR5ejFVR0pFb0wyUTg0ak93MUpMLytBWXEyQVFDTURJL3F4a1ZMd0o5?=
 =?utf-8?B?bjNXWDhpK0tLOExJT29CQTU2eTZ4ZXBPOVViTTVKVDVVOTl3RDlqWDhyMjdC?=
 =?utf-8?Q?cfKhDDb1IM0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGZjOEdINmhxNDY4ZkxlcWpHWjViZ0dlbUxPWVBzS25xRXo2NnVHbTlrZnlz?=
 =?utf-8?B?YzB0d2NqYWtoRGVhQ3NyazAyNS8rUE1oZVZ0VTVZYU01bmNZVlNQUU1FMWNs?=
 =?utf-8?B?bko5Y0RiZ0VLOEVPQVlQajI3a0dJa1owWWtHUGIwNEFkMkpWVzlVZ2dlZnNo?=
 =?utf-8?B?K01UZGxCSU95QUhYV1p2SUMxYkJWZW1yNEtGaHZNMkFLT1RFVk5mdThaVm1p?=
 =?utf-8?B?eUszNUY0VmNUK2pOdUgzZ1owSXZ5d0JGL0NORVpmM0ttM21WOGcrOEF4a29j?=
 =?utf-8?B?WDFKK2k5SWY1SVlpMUcrUlIrek91dXVFUFN2SmhiQWkxcThLcUEvZG9lN0FT?=
 =?utf-8?B?ZzBqQUs2RkxlQW40OWNsTThPUU9yT3dhaXVoSUIzMUIvNlBreFhmM2pHUEpZ?=
 =?utf-8?B?VXdIMGc2VEtqdGM2emYxK054QWJ4dDhzYmx5VG5DZkNkVTM2S3BGaDZWUE1L?=
 =?utf-8?B?MXlkRkJTM0FrVDlOZjJTUDlkM01sMXVnVVNHcmd5Z0U0T25HTDFqZWIrakMw?=
 =?utf-8?B?eTg0NUM2b1ppTm5ZeGdXVHcwMG9vNGdpU1oyUVFzeTZpaE5wRHR2cWxKZGZK?=
 =?utf-8?B?Vm95QktpbTdrMVBGQlQ0VFNya2RndnpTNTBwMGFoTkhtK1RSVDhzUzR5Q3RS?=
 =?utf-8?B?NHRPVG14YkRZSjNSR0JiSnN0eDkvZ3p2dWdLdnQzREFRWk9LV0ZJM0s2V0ZL?=
 =?utf-8?B?cHkrdXdFL2YyMytaMHFaZHFCSXZlN1FzQTVxNCtIazd3aE5UWnlnanUyK1V2?=
 =?utf-8?B?UmMya2FaZTBYOFdEMHg0WmVhTmN6aGVLeTVPYlZzQWxqWmNYOWM0UGtJdUJG?=
 =?utf-8?B?Ymlmc3RhUnNoSXRaMG55RzB5ZXcrVkRYNlM4MjN4WmVJMUpsWXB2dlJIQjly?=
 =?utf-8?B?V0xBWXZWMXp5TDl6b2ZpQXZFZGJYNGpqOGFjd3FCVHRQdWlLbkpCMUFYcURQ?=
 =?utf-8?B?dmwyakZ6eis5TnZOcG1LODZ3czRxa3lnSHhveS83a3VwQldLRDEvRlBWc1VN?=
 =?utf-8?B?SVZKWDdBN01zaGJDR3AydktiWlhIL3A0UUdRZElkSDhhZ3BXaG55L1NQNnU5?=
 =?utf-8?B?aUhvQTFRZWhjYVhXbmIyOVZnM2c2b1cvaGl0cEZyRW9Mdld4bUZHbUNYeGla?=
 =?utf-8?B?anJTTnVjVW9PTTJsSVV2aXFPandBc1R0UWx0V3NkS25zU0VmdFhaWmYxSnRL?=
 =?utf-8?B?S091ZjFkMnpSMmtaaHc3cmlmUXFaYm1sU05MVlNlZUM5emZROGNSMC92bUdp?=
 =?utf-8?B?UU9KZ3pCd0gwSGVHNWlrTld0NDlhTEYrQnhWWENyL3FqalY3NDk5bEJtNG1Y?=
 =?utf-8?B?SGlXVHVvYUxzaXB5NGN6OHBML1h4d1JJMW9weEovMFZQNzExU1hobkNmMFFv?=
 =?utf-8?B?QVdvZUY0Z0kyLzJtak1JdVVKZGZFT09DRUF5WkN5a0VKekZZTGVsTEEvcytM?=
 =?utf-8?B?cGFPaGFxRWZqK3Bic1QyaGNsang1RE1tbGl6bk9IbTNoUVNtUDFBZHM0bXhU?=
 =?utf-8?B?NUlhdFp1a3R0dCtKRlZiNmlQSHdUbDFuUWZiVnRFOVYyMlZKQVBmaDMwQTFw?=
 =?utf-8?B?aUxwTDNyOUpBbWNoQjJJVWNESFQ0S1RoR0xNYWhSVnI0ZTFFTXpQdFNLN0Yv?=
 =?utf-8?B?ejBnNU93QVBJazZWcXhMQzNOSUpMZDZhUENqUDA0RG5kME5RMWRLQkpyOUVJ?=
 =?utf-8?B?R2JnODVFNUlzQkJmRnJETlFtdkVjRnpEV1MrUjliWUhCbDJ3WG1PVHptU0tr?=
 =?utf-8?B?c3pTclJUMlhiQVhnNG1VcEVyZFBvYWRtZk5Db2lPOU9CV2laUy9oSkE1L2xk?=
 =?utf-8?B?Qm9zU3BtMHFwQmxxYU9qMHZXZ0xpcU80RzI5Q29wNG1tT1J1ZDVVM0N1WTQ5?=
 =?utf-8?B?bnJSQ21xMFdUK3ZDYTA5dTdDY2txQmRQMWV6eXdKR1c1Yy84b21Sa0NRall4?=
 =?utf-8?B?S2hkR1lMcmdaMXJQeDlFZDhtMm9Ccnc2MWNyVFVSUXNHVmFoQ1M0THJOZVhl?=
 =?utf-8?B?RGN1RWJEMHBLdVJMRW5NQU5xbzZGRUtFYUx2cmJEN0tPTDFzZUgzTGVhbGts?=
 =?utf-8?B?MGIydW1weWpzUDZ2WmpSZ0J2T0pycXFnYmE3eFdyTzd5K010Y2FyWWlSYWZM?=
 =?utf-8?Q?mnphDWyj0jRGeqp697Tm2uhkT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc61967-fd93-48ba-aa7c-08dd7dcc5017
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 16:24:22.9090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRtX2XuOGZ42d6Mg5+XTROgC/krxB9at2lC9l9U0OcJQ7UN3iaZCSlj7pU4EDSkCIYWgaAgxLmzXo8vclqn+bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759
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


On 2025-04-17 8:57, Christian König wrote:
> Am 17.04.25 um 15:33 schrieb Felix Kuehling:
>> Pinning of VRAM is for peer devices that don't support dynamic attachment
>> and move notifiers. But it requires that all such peer devices are able to
>> access VRAM via PCIe P2P. Any device without P2P access requires migration
>> to GTT, which fails if the memory is already pinned for another peer
>> device.
>>
>> Sharing between GPUs should not require pinning in VRAM. However, if
>> DMABUF_MOVE_NOTIFY is disabled in the kernel build, even DMABufs shared
>> between GPUs must be pinned, which can lead to failures and functional
>> regressions on systems where some peer GPUs are not P2P accessible.
>>
>> Disable VRAM pinning if move notifiers are disabled in the kernel build
>> to fix regressions when sharing BOs between GPUs.
>>
>> v2: ensure domains is not 0, add GTT if necessary
>>
>> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
>> Tested-by: Hao (Claire) Zhou <hao.zhou@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 19 ++++++++++++++-----
>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> index 667080cc9ae1..3c2c32a252d4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> @@ -81,17 +81,26 @@ static int amdgpu_dma_buf_pin(struct dma_buf_attachment *attach)
>>  
>>  	dma_resv_assert_held(dmabuf->resv);
>>  
>> -	/*
>> -	 * Try pinning into VRAM to allow P2P with RDMA NICs without ODP
>> +	/* Try pinning into VRAM to allow P2P with RDMA NICs without ODP
>>  	 * support if all attachments can do P2P. If any attachment can't do
>>  	 * P2P just pin into GTT instead.
>> +	 *
>> +	 * To avoid with conflicting pinnings between GPUs and RDMA when move
>> +	 * notifiers are disabled, only allow pinning in VRAM when move
>> +	 * notiers are enabled.
>>  	 */
>> -	list_for_each_entry(attach, &dmabuf->attachments, node)
>> -		if (!attach->peer2peer)
>> -			domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
>> +	if (!IS_ENABLED(CONFIG_DMABUF_MOVE_NOTIFY)) {
>> +		domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
>> +	} else {
>> +		list_for_each_entry(attach, &dmabuf->attachments, node)
>> +			if (!attach->peer2peer)
>> +				domains &= ~AMDGPU_GEM_DOMAIN_VRAM;
>> +	}
>>  
>>  	if (domains & AMDGPU_GEM_DOMAIN_VRAM)
>>  		bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>> +	else if (!domains)
>> +		domains = AMDGPU_GEM_DOMAIN_GTT;
> Please drop that.
>
> We should probably use allowed_domains instead of preferred_domains and return an error if none of them work.

I sent out an updated patch with that. One concern, though: With discardable VRAM BOs, allowed_domains may not include GTT. I'm not sure if such BOs would ever be exported.

Regards,
  Felix


>
> Regards,
> Christian.
>
>>  
>>  	return amdgpu_bo_pin(bo, domains);
>>  }
