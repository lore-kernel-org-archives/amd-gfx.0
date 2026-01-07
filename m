Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8F4CF6C1F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 09:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 732A510E582;
	Wed,  7 Jan 2026 09:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mtk9o3G4";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE5F410E57D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 09:35:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1bn7argeREQx+av7nY9S7mRIIht4HoJcpwJ7YmdKzuX7J5STVkrUs8e5Dx1ZzNbeoFFZ9UecD/ZRF7wGHLJGCxvNdWmtWRjcjPjhm4tEwHWoN/8UyGFN+3N1Vy9fsSRGYgYyA6LiXXnw7q1NCbtvJcBfxsLRElFGjcjSyHixplueQwE3TUhcPlt8a/hR2+9a2RseEu4YmInjnqaSMauPCQkFQ/0JZBTIgTKUAV/K+mruH82RriOOOF+auImmBCItNvyNWRNxCwN51nYbmE23OM0nRUfP945wIi784uLxLrDz3HDA7c/WSwU2aKIsHADAwD7tUMMuC8sUIvnS3J+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdcMYq1VVlVgPV8tuFxl1jm41B/RdT6KZ+hOBxiNzMs=;
 b=VffONFAMXhy3ggkxCiEPFHP0uqgqJzohpvYYl5HnUrN3jqWHNp9Z/dYnD0UM9dn81mlVrch1363nUrWfE5G+n/u/W0QcBg9EjaobJKRgpQctCb/YUdEmkf3/bBGRQwHKtq10PquSRYr9SWSis6E8mIgfd1ChdVeaTJi5QQ99I8Y4E6c46RdCHpJAiHwi1qrN8mEuFu/fJ8nmSbtVCWPO+k3ddkwDNYKmT1q2H3KVUWQQPuzLQL59fC6+3Dz1Ee/+NqqH7YTwsgz+uaVm24LDAAlwa2xPW/hZXHvUArZbfJLeU+QiRiObR94rZWCw6FHSZPhWUX20a8BMS326q7ogIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdcMYq1VVlVgPV8tuFxl1jm41B/RdT6KZ+hOBxiNzMs=;
 b=mtk9o3G4hJ8qi2B8cOjpObV2FPW+uU5q7hjdxpqG9btALv9Q/q31IIyc9SQO+/iEduVt3HWSl9bIV6Ldtqi7DsmBxikaWTb+EK9Yq/SiE2fSOpOz1aL27lQoktB8DnZa2w2c1K+IxqQFSvoOuSr+BwNoLYADoHZH8SouSdp2nXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 09:35:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 09:35:15 +0000
Message-ID: <97e20c2a-9f58-49a7-84b8-c457a7d30140@amd.com>
Date: Wed, 7 Jan 2026 10:35:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] drm/amdgpu: Replace idr with xarray in
 amdgpu_bo_list
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
 <20251219134205.25450-11-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251219134205.25450-11-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8f7e61-c222-439b-9ed3-08de4dd00fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHY5aVcwcjROZDdlNUZQenYreGRsZERpZkRIMXd5WnB2dUc4dlVhdHZIMTZ4?=
 =?utf-8?B?eDJYeEZES0R5OUk2b1llNEc2Rzh4ODFHbnpnR2RwQTVaU0p6cnpMUjBZYnJW?=
 =?utf-8?B?cWV6QlhMT3pvc0w2L005UFRrRDJkZ1VsdW9NUUJRN3VPMm1GLzVOWDBRbVFD?=
 =?utf-8?B?RUhxa1c4VytnQUI5RFFXMG5JNnV1VStkUUdlYXppR2Z4aktvNWRQb0ZrOFBx?=
 =?utf-8?B?WHYrSVZaMFJRdWcxV2xOamVYWDlPKzQ2b3dyUVFNVUdSNUZIUW1lWDVXWEpX?=
 =?utf-8?B?Z3JzZ09yc1hjaU00NFhMOXFNamlDbkVsNlJMdnlHekMxdjRJU1d2UXhML01y?=
 =?utf-8?B?OHhSV1JWa1pvaDF6UDdjUmxpakNmRW9vL0g5ZlY4UFZ3V2NYODM5M0g4ZTlK?=
 =?utf-8?B?MjJ0N1FVcWxDTVhRdUVtUTJRUG96cFpqWm9QSG5QWC9KNW1oRmx4YXRIbHdv?=
 =?utf-8?B?N2FmcUdTOVdQNmVZRFVCUi9PTjZLSVZ3d3JtR3A5UVRRVXh4eEpGbVdWTlJw?=
 =?utf-8?B?Rm41eExMRmt1cWIzRStNOVRZQzZBcUxuNWttdWY0ZG4xNEFQemszdWhUTTF6?=
 =?utf-8?B?YWpZWk55NzNNU3hjYkZHUTBvS01sU2V6ZFZzL2thRGVGbG1heUtqVlRLQnVZ?=
 =?utf-8?B?Ym5JeGxyWnRvNHUzT25nNjFIV1R2bDMwS1Ywc0JTSHZ0SGIvNm1aWmhnc0VQ?=
 =?utf-8?B?MmZISGN4VHdGaFlkY1lJWlRKUXFzcWU4a2RmdDYzRUdlT1FXTE95VTlTNjlC?=
 =?utf-8?B?UHhkYlRITlIvR3I0NXlYK0h4a1VyMlA3YXR0SVN6SGRJZ2poUmxiTG5Ic3pj?=
 =?utf-8?B?N0xLRXNPaStQeHlsV1EyTCtwZzdvQWVkMTcyWWtlQkY4Vkx2NXZ5aXBWOFQ0?=
 =?utf-8?B?c053bUMrclh4WTBVNHlOdzh1RWVlMnoxUURWZHV6RWhxbDU0eVBqUUdtak9O?=
 =?utf-8?B?TllXNms0QlhRemFRVmdoSWZXbzNIUU9vcTkrT0NlVEhWYWYvWjRkV0hYT1FZ?=
 =?utf-8?B?YVQ0bmZNRWdBTUJmRWFMVjBKWGFoekoyTGFSVE1sSFBJbk9TQU11dEZORFRJ?=
 =?utf-8?B?S2x2dTJJdTgwd3BtNWJjNEk3VGlCalZVMmJNWnhRT3dYNzcvWUpvZVExTTlB?=
 =?utf-8?B?YndsM085ZzdweWRxbkg1ODQvd3NmRHRzdHpodm1HelBOdTRSOXRPcTQ5Yllt?=
 =?utf-8?B?ZFNCekZPNVVORTdoTEJWMThIYUlzeHUvNTljL1U0cDVtRjdwbWFaNEJmUTV5?=
 =?utf-8?B?Z0Q1RWQ2emJqRFpTalFqbWYvVlg5Y016U1FWenIzQmtjR3dFNnRUT3dnaC9R?=
 =?utf-8?B?YjRmTkhod2oyTEdlbnJhM29wYVlCRTJkbkFyVitXRGtDMnZlTVorOEp2WnE3?=
 =?utf-8?B?cHhGTmpmRTBYUFdPS3pNR2MxaHk2ZVNpdHQzOE05L1VDUFlFK0d2RXNRaU5X?=
 =?utf-8?B?WUJBVXZkbTNRalk4WjF4V09LV3krL2tWY3ZDakNSL01GL0pETU9OeEo4WXF6?=
 =?utf-8?B?azkzaS9zRGczMWFnVEhTcytJZmdPR0hmUTBEaUpUeENGdGJWQTArLzhLRVdF?=
 =?utf-8?B?djA5azd5b2pYaEFobjVLUnFzQ0hwRGQreFMvNlVqQWM0MDVrOHZqNytkN2NQ?=
 =?utf-8?B?TWt3NnVqYi9NWEprRjUwTDQ3L1BIWHI1a2ZoZWRoaUdOenl0ZzM4WEQxNCtS?=
 =?utf-8?B?ZlB5VE5EaWt3aElXWE44UXk2SXd1QVZvUWtoKzVLT0xYY0dxMW5lVFZGM0p2?=
 =?utf-8?B?SE1NYVBMaVBrQUUzbE5xZ2ZqZTdidWxhVVg4RkFyVXd6VlJTUXJFamRvcE9R?=
 =?utf-8?B?dUQwWDhQSG5KVUVtSk1Hb0YvUUtNN082b3YvZkVOZjh1Z284WE4xYy96Mm1Z?=
 =?utf-8?B?cEhWejJNNHVmaVE3L2lkTTc4U3duN2lSZVcrbXYyUzlOdXJpRjVIZUQwV29a?=
 =?utf-8?Q?9I7i8h9RgOCScJIxvuxquRJdC5FItuLr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2dTSVJ2eXBLVmtaSTJ4VFNocWdZOEl0ZWJPdXM0bkFORGJRaWxtZkcxaGlk?=
 =?utf-8?B?aUk5RzVkQjd4c3k2TVRudkFZQzN4aGxxQy9nRFRFVnJjTzRaRWp4NmR2QzQ1?=
 =?utf-8?B?VmFuZk83TDVwdmlGY0V0a1g0OEpDOHRHRkl4Sko2RFRvZzJMNlNKaGhjTWRq?=
 =?utf-8?B?THEyRkh6NG9VTC9Ya3hmVVFaVlZZZEdhNS9iek10Wk9EVTlFRGtPYzE3UVNV?=
 =?utf-8?B?N29KaHpRcm5KekhLbVU3d2ptUjF5R2FTQ2dSaENiVjRZNmpsbkZsWjE0K2FJ?=
 =?utf-8?B?aEtCVnJDUVZ3QXdrZDlwM3lnVS9BVDFQckVpb0JFYVRielJsblJOMDZHWXNx?=
 =?utf-8?B?RFVYaC8wb0Y3TTNVSnhPc1MrT2R1a1BUU1o4WGN0dDYvdTBDVitmT2ZnRUZk?=
 =?utf-8?B?dkMvdnEwOG9QTVR6OWR3QVRCemtncVU4ZkhyRmVxVEsxbXErdTRxNFBiVTBi?=
 =?utf-8?B?M3dIanNLdWhHZEc2eW9Wa1FTUkYySHVCMzh4aXF2RkJCdi9hMEM3MFJvaXNX?=
 =?utf-8?B?ZTNRa3ZnT0lwajJTTlBhbVBhcDJKRVRkNzJtKzF1OU9pcGQ3dmF2T3ZXOWRC?=
 =?utf-8?B?QWFoWGRBZHphbGh6VGZzVzRUMS9pQ2VLL1M3QXlOUHhiSTVTeEFLa05NRVE2?=
 =?utf-8?B?ei9QaHRNWUJHUGhoUW1xRkJ6VXEvMDdLWVlMaXZrSUZqZkxhVTdUdjhZSU5v?=
 =?utf-8?B?WU5VS1VCYlUzSkwzVnVZakxRM1kxeVZYRkdwMlgwYmdsVXgvKzRKR2c3YjZ1?=
 =?utf-8?B?UnVkUldFaTlSWW9tbXlEMWlVUkg3ZVZ0VlhZRCtrWUdINmhRZzdyZnJtKzBl?=
 =?utf-8?B?ZkdnR0ZFbDdpZUFKeVN4ZzZVdUlvbVFyZW91YmtOOG1Ed1ZLWUk1ajRRbWVj?=
 =?utf-8?B?K1d4cnNDcmhSWWRsSDJBWmlYajBiQ0pSVjB1MmNId3lBMXl5aXhHYjVGbUt2?=
 =?utf-8?B?S0tiYzJnMnNjSnVNMU43cGNKeDROV003TGcwNHZqMW1uSitqMGo3Q1FRNFNV?=
 =?utf-8?B?c2RVZGFhcXQxVGF1Q0FHdVRrVHFsa0crbm9JQ053dFlFOFFkdWJoakoyRzlJ?=
 =?utf-8?B?dzhMK1NRQmFmVG5nc1ozak1nWU0rVmUyVkdyL25ZUm1uT0dBbFBvOFArdExL?=
 =?utf-8?B?VUxkWStDbnZQWGJWeVVjTDJtZkFGZzh4ekRLZW1FZkhUV2M2VFM4UTNuQldU?=
 =?utf-8?B?TlZnRDlXbzl6SDlaeWtOUjR0YUdCaDU5ZzlyUHFSQlA5T0V0dWhjb1llUE8x?=
 =?utf-8?B?YUtDNitGa2c1bC8rRkNON1FRd1dGd0F4bXlxdlQwMnpKTVB1WlZnSEdQcVZP?=
 =?utf-8?B?SnBFQWZiSk5yYXdDUzZPQXR0eG41UzFNT2hxaWRaNjFueDA5cUI1Vmp4NHYx?=
 =?utf-8?B?NmN4aXVXUVZMM2YrZTJpYTgwWE4ySWNVZnRDd2ZsTHp1bVNnU1k1L2dLOWtS?=
 =?utf-8?B?NTFIRDdIMlVzZHlFYnVOd29PWFY5UkY4dmErbGxISFR2L0xZZVU3cGNRZTdi?=
 =?utf-8?B?V3cxTXVhakJJckFadkNXb1ZwaGJLV2dITzBZRkV6M1B2eElUUS8rem5PdWNM?=
 =?utf-8?B?eUQ1cndtVEh5UXd6Q3Z0QmpnU0ZDbzVxSVVUY3MzWlVNd0t4bU03OXBzVXV1?=
 =?utf-8?B?NEdURjdsNW5ISEFjUCs3Z0gzbXdsRVBvRStVTHFYd3ZWdEt3WlB2elRsWEw2?=
 =?utf-8?B?dHh5MW1OWWJhc1YyMWp4NDh3b29FdzRkR3RBR01PaEMyLzdqWHJQdkpqZjVT?=
 =?utf-8?B?UmNPLzdKTldxRzAzQittbVdjYUtyVE16ckVKeld6Vzd6V0RqNDl5bXF5QjFU?=
 =?utf-8?B?NWhOVVdXSWF6OVdHdWJDd3h6VmdlNjgwTER3K2h1T2F4eEoyTjFkOWtQd0RR?=
 =?utf-8?B?VUI1Znl4TitaMEx3VUQ1ak1PQ05VZVZaUXBnVWRqNVVPVnEvc25xZDF3V1Zm?=
 =?utf-8?B?TmhEVFVmMWZlVHQzM0lzZGROc094c1V1TC93MFZlMkhSUHJxd29tNlphWUZ6?=
 =?utf-8?B?R1QvS0ZQTzVVUVdVeFJJd0p5OFFTUEluOENoeXJwUlpRdkh2LzdpV3hJeTZC?=
 =?utf-8?B?Q0NTcWIyTjZnTjd3VzJqeEhhZG95Zitlc0tlWEE5a09RaHViNi9TTFNRRzYx?=
 =?utf-8?B?WkliTnI1dHBqOUlWeW5hcWRZTldQaXRsOFMvTHMzbDFwbGJNemc4bEZ0aGV6?=
 =?utf-8?B?UU9QMFJ2cmN0N0RPdkozUlRxcG1KclV5NWpaM3ZzdDhPenpwbnU5YXB2dFJ5?=
 =?utf-8?B?NzZ3Q1RyWG1GY1U5ekExQVMwcExXWXVIVzdCNEo3cUJ3cDA5VHpVbG1TSmVG?=
 =?utf-8?B?d3B3U2IwLzVzU0lXN2ljaTY0bERBb3Y0OFgzTEMrRFFtTmJXZlI0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8f7e61-c222-439b-9ed3-08de4dd00fff
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:35:15.2293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkY0gDbILCF/zBV7ySG9ZF9Ph5u6gOYMCkubvs1xezyc0Qyw493uts1lUKLBgrCz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
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

On 12/19/25 14:42, Tvrtko Ursulin wrote:
> IDR is deprecated so let's replace it with xarray.
> 
> Conversion is mostly 1:1 apart from AMDGPU_BO_LIST_OP_UPDATE which was
> implemented with idr_replace, and has now been replaced with a sequence of
> xa_load and xa_cmpxchg. Should userspace attempt multi-threaded update
> operations on the same handle it could theoretically hit a new -ENOENT
> path. But I believe this is purely theoretical and still safe.
> 
> Also, since we have removed the RCU protection around the handle lookup we
> also removed the RCU freeing of the list.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
> v2:
>  * Dropped RCU freeing of the list.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 81 +++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     | 11 +--
>  4 files changed, 42 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 80dba6276aa8..ec3cbe70012a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -50,6 +50,7 @@
>  #include <linux/hashtable.h>
>  #include <linux/dma-fence.h>
>  #include <linux/pci.h>
> +#include <linux/xarray.h>
>  
>  #include <drm/ttm/ttm_bo.h>
>  #include <drm/ttm/ttm_placement.h>
> @@ -499,8 +500,7 @@ struct amdgpu_fpriv {
>  	struct amdgpu_bo_va	*prt_va;
>  	struct amdgpu_bo_va	*csa_va;
>  	struct amdgpu_bo_va	*seq64_va;
> -	struct mutex		bo_list_lock;
> -	struct idr		bo_list_handles;
> +	struct xarray		bo_list_handles;
>  	struct amdgpu_ctx_mgr	ctx_mgr;
>  	struct amdgpu_userq_mgr	userq_mgr;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index fbac929f711c..59def86cdc04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -37,14 +37,6 @@
>  #define AMDGPU_BO_LIST_MAX_PRIORITY	32u
>  #define AMDGPU_BO_LIST_NUM_BUCKETS	(AMDGPU_BO_LIST_MAX_PRIORITY + 1)
>  
> -static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
> -{
> -	struct amdgpu_bo_list *list = container_of(rcu, struct amdgpu_bo_list,
> -						   rhead);
> -
> -	kvfree(list);
> -}
> -
>  static void amdgpu_bo_list_free(struct kref *ref)
>  {
>  	struct amdgpu_bo_list *list = container_of(ref, struct amdgpu_bo_list,
> @@ -53,7 +45,8 @@ static void amdgpu_bo_list_free(struct kref *ref)
>  
>  	amdgpu_bo_list_for_each_entry(e, list)
>  		amdgpu_bo_unref(&e->bo);
> -	call_rcu(&list->rhead, amdgpu_bo_list_free_rcu);
> +
> +	kvfree(list);
>  }
>  
>  static int amdgpu_bo_list_entry_cmp(const void *_a, const void *_b)
> @@ -146,31 +139,20 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>  
>  }
>  
> -static void amdgpu_bo_list_destroy(struct amdgpu_fpriv *fpriv, int id)
> -{
> -	struct amdgpu_bo_list *list;
> -
> -	mutex_lock(&fpriv->bo_list_lock);
> -	list = idr_remove(&fpriv->bo_list_handles, id);
> -	mutex_unlock(&fpriv->bo_list_lock);
> -	if (list)
> -		kref_put(&list->refcount, amdgpu_bo_list_free);
> -}
> -
> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
> +int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
>  		       struct amdgpu_bo_list **result)
>  {
> -	rcu_read_lock();
> -	*result = idr_find(&fpriv->bo_list_handles, id);
> +	struct amdgpu_bo_list *list;
>  
> -	if (*result && kref_get_unless_zero(&(*result)->refcount)) {
> -		rcu_read_unlock();
> -		return 0;
> -	}
> +	xa_lock(&fpriv->bo_list_handles);
> +	list = xa_load(&fpriv->bo_list_handles, id);
> +	if (list)
> +		kref_get(&list->refcount);
> +	xa_unlock(&fpriv->bo_list_handles);
>  
> -	rcu_read_unlock();
> -	*result = NULL;
> -	return -ENOENT;
> +	*result = list;
> +
> +	return list ? 0 : -ENOENT;
>  }
>  
>  void amdgpu_bo_list_put(struct amdgpu_bo_list *list)
> @@ -215,12 +197,12 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>  int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *filp)
>  {
> -	struct amdgpu_device *adev = drm_to_adev(dev);
>  	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct drm_amdgpu_bo_list_entry *info = NULL;
> +	struct amdgpu_bo_list *list, *prev, *curr;
>  	union drm_amdgpu_bo_list *args = data;
>  	uint32_t handle = args->in.list_handle;
> -	struct drm_amdgpu_bo_list_entry *info = NULL;
> -	struct amdgpu_bo_list *list, *old;
>  	int r;
>  
>  	r = amdgpu_bo_create_list_entry_array(&args->in, &info);
> @@ -234,19 +216,19 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  		if (r)
>  			goto error_free;
>  
> -		mutex_lock(&fpriv->bo_list_lock);
> -		r = idr_alloc(&fpriv->bo_list_handles, list, 1, 0, GFP_KERNEL);
> -		mutex_unlock(&fpriv->bo_list_lock);
> -		if (r < 0) {
> +		r = xa_alloc(&fpriv->bo_list_handles, &handle, list,
> +			     xa_limit_32b, GFP_KERNEL);
> +		if (r)
>  			goto error_put_list;
> -		}
>  
> -		handle = r;
>  		break;
>  
>  	case AMDGPU_BO_LIST_OP_DESTROY:
> -		amdgpu_bo_list_destroy(fpriv, handle);
> +		list = xa_erase(&fpriv->bo_list_handles, handle);
> +		if (list)
> +			amdgpu_bo_list_put(list);

It's usually good practice to make *_put() functions take NULL as argument.

Apart from that looks good to me.

Regards,
Christian.

>  		handle = 0;
> +
>  		break;
>  
>  	case AMDGPU_BO_LIST_OP_UPDATE:
> @@ -255,16 +237,23 @@ int amdgpu_bo_list_ioctl(struct drm_device *dev, void *data,
>  		if (r)
>  			goto error_free;
>  
> -		mutex_lock(&fpriv->bo_list_lock);
> -		old = idr_replace(&fpriv->bo_list_handles, list, handle);
> -		mutex_unlock(&fpriv->bo_list_lock);
> +		curr = xa_load(&fpriv->bo_list_handles, handle);
> +		if (!curr) {
> +			r = -ENOENT;
> +			goto error_put_list;
> +		}
>  
> -		if (IS_ERR(old)) {
> -			r = PTR_ERR(old);
> +		prev = xa_cmpxchg(&fpriv->bo_list_handles, handle, curr, list,
> +				  GFP_KERNEL);
> +		if (xa_is_err(prev)) {
> +			r = xa_err(prev);
> +			goto error_put_list;
> +		} else if (prev != curr) {
> +			r = -ENOENT;
>  			goto error_put_list;
>  		}
>  
> -		amdgpu_bo_list_put(old);
> +		amdgpu_bo_list_put(curr);
>  		break;
>  
>  	default:
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> index 1acf53f8b2f9..cf127bc66f53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> @@ -43,7 +43,6 @@ struct amdgpu_bo_list_entry {
>  };
>  
>  struct amdgpu_bo_list {
> -	struct rcu_head rhead;
>  	struct kref refcount;
>  	struct amdgpu_bo *gds_obj;
>  	struct amdgpu_bo *gws_obj;
> @@ -54,7 +53,7 @@ struct amdgpu_bo_list {
>  	struct amdgpu_bo_list_entry entries[] __counted_by(num_entries);
>  };
>  
> -int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
> +int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, u32 id,
>  		       struct amdgpu_bo_list **result);
>  void amdgpu_bo_list_put(struct amdgpu_bo_list *list);
>  int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 6ee77f431d56..88f104041157 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1445,8 +1445,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	if (r)
>  		goto error_vm;
>  
> -	mutex_init(&fpriv->bo_list_lock);
> -	idr_init_base(&fpriv->bo_list_handles, 1);
> +	xa_init_flags(&fpriv->bo_list_handles, XA_FLAGS_ALLOC1);
>  
>  	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, file_priv, adev);
>  	if (r)
> @@ -1492,8 +1491,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>  	struct amdgpu_bo_list *list;
>  	struct amdgpu_bo *pd;
> +	unsigned long handle;
>  	u32 pasid;
> -	int handle;
>  
>  	if (!fpriv)
>  		return;
> @@ -1529,11 +1528,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>  		amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
>  	amdgpu_bo_unref(&pd);
>  
> -	idr_for_each_entry(&fpriv->bo_list_handles, list, handle)
> +	xa_for_each(&fpriv->bo_list_handles, handle, list)
>  		amdgpu_bo_list_put(list);
> -
> -	idr_destroy(&fpriv->bo_list_handles);
> -	mutex_destroy(&fpriv->bo_list_lock);
> +	xa_destroy(&fpriv->bo_list_handles);
>  
>  	kfree(fpriv);
>  	file_priv->driver_priv = NULL;

