Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934EED1D462
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B4310E318;
	Thu,  8 Jan 2026 14:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IIQo6BX0";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C27D010E318
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMiRbvKrNaZmg08m8K0HOnSIZxD47hsAfNr3he+uosypvPZQo8fOiiI1BM5eismCM9s8lBstJ0g23PVGw2dxOWGN2q0h2dNCzuZePaM1zv6iE8ppE1arbAzWBxh3XcHGFHeFgYUMjYn+B4GLJv3d1haFFfWr2WQYyZbNqNJ+1bpd2qALFCs7fj1rvsU+A25pUJXv8f3g6qx03kMh4qOFLIoiThrJP9vRgb6ZntMUPKIynfoY2laSHS8sVmMqrdUdjxjsuEzJQJkpnpCMhU/Li9AOXY1sxIZM2NzXjJeC+PqKG128RGXt4/qZ7g1+aLxtx21LgbzfMDuv6L+9C9ls4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTY0NXbOaG+1nWFJojZsUQqImkqBiY/l/pHu4WWOE58=;
 b=nhxEJf86QpgA6p0GxYMoLqbNc5usVMj9wKG/nT2GHb0TimqAOcHJ8DU2Fi897OUNV+ga00Eu06UMZ6xKqxCyC4Aq9o1a+k1hNA+6OrUrShlCIoFDvs38iaCJR4FOsMq/XltSh/10olD9uxlIcxoMICV0lHMmYpXudOA3uCye3ahr5myQeg4EfQi6g2GI4mtMqDIEWd1B6sidvFCAzdHQGZvCNLliAWFq7z01Hv24DIFl627/l3zIQhoIOoOTeWImMCB4WtcyN1px78ULYLLSWUpNNApdjoiReso/TrTLcGKzFnqAV0ohlDGjP0XqMyPZYd21ovlVU9PI10/Ok+sdwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTY0NXbOaG+1nWFJojZsUQqImkqBiY/l/pHu4WWOE58=;
 b=IIQo6BX0v6zEkuWhX5MvT3e5unpdwaGfbihzhg1Me6ooUx8KCTDUkTZIqFkZyU6hATPG8cEsBAH2Vl8LAm1RB6d5HTcSLw/O90QTndJtV8LEwklfDjMLgjEwyQDJUWJQgXvuVT0omoMiMmMwHiMnmGIZpevDCRmnYOH9zIiLbm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 14:43:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 14:43:03 +0000
Message-ID: <61e6f8d8-5453-4094-a14b-280d3e07ccfd@amd.com>
Date: Thu, 8 Jan 2026 15:42:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: validate the flush_gpu_tlb_pasid()
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260106131921.801193-1-Prike.Liang@amd.com>
 <2275758d-de1e-42eb-b224-89485511a83d@amd.com>
 <DS7PR12MB6005E3B971A03814345CD820FB85A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB6005E3B971A03814345CD820FB85A@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:408:f8::32) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 41065908-ea33-4233-cf90-08de4ec43a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WW5WakYyZFlSejljbHV0VjlPOS9sMjQxdGN4aEQvZjNOUmJtbmhMNk1yeGI5?=
 =?utf-8?B?UmY0ZE1OVStwcnNHUnROTWlQZTVJa0VxOCtVcVZndHF0QUkzOXdPZUwvc1lp?=
 =?utf-8?B?QXpEN3VOcTlGV3JFQnhJazl2MnZ4UHlzZTE2eXdUYWFGZmphMCt4OXVzelF0?=
 =?utf-8?B?Z2hWd3ZTNXlXQ1M2MGNhNFJ0cGxQNWZhWEsrNWxWR3RUT3JVWUVXTUY5VTd6?=
 =?utf-8?B?c2hzVUNGODIvSW85N08xcWVQTUNEN25oTEZ4M0JNL01HQjFlYlArSHZFOTlo?=
 =?utf-8?B?YmFuc2xjMDhIVFlZZVdTaTQ5NUUrZHpmdzJwc0ZWNjd5YWVkcUJGSTYwVHZR?=
 =?utf-8?B?OW43bVFOTm9EbGZUSnVwVDFlbEtrd2xuUWRGaVozN0JzNEUzNk5WU0U3R2Vl?=
 =?utf-8?B?dzdoNExzSU94REFhTUwzNDVrVXZGK1BDcHNHeGNvQnliUkhJYkNvL0pLSEtG?=
 =?utf-8?B?bnZOT3JPUVAxV3h2Uk9uSHBSaWo0ZmJpWlh4WlRIZklYWGdlZm9DTmVTZ3Iw?=
 =?utf-8?B?U3pTaGZRQWlOZU44b0VkL2pUNER4SFJBdGhDaDRvc0cvRE4xeDFMbjA2djR4?=
 =?utf-8?B?aFkrand3OS9IeE91djRrcWY5VnNYK09vQVNDVVdPVVByMktIUElLaTQxL3gr?=
 =?utf-8?B?ZFdaVlY2U1VzdXhIaThEVHpMeEJHYmFQcTlHVWUzZkpZNnNUekRva1hxcGhx?=
 =?utf-8?B?NUphT3B0Z0JubStidDAwemVFeVFCbXpiSVlqMXgydWJaYWMrRnFQd2NrVHZi?=
 =?utf-8?B?T1ljK3hQUDVjc2t4Z3o2QTBMUGwwdzYvbVh5TWlhYTR3elM0V1dOWFVBUFlP?=
 =?utf-8?B?TXhnQTZCNm1YaENEa21BWVd5QVc5eGNyRGowUE1mMlN2VnlPS0h5NnRqbUlC?=
 =?utf-8?B?TWpNcGwzQ2dBT0ZMNHNPTjRhelpYbE5WYTE3UGtkaGtPbGtFM0crSUNGajZF?=
 =?utf-8?B?bVVWRlhuSEpaU3ZLV2w2MWVhZFcwTjFwRFhyRStlN21YQmozZ0JFdjlCczR6?=
 =?utf-8?B?MWJSWU9qd1VENHc5SE4wTWRGNStZZDFGRGxOZ0JzODh2TEFCcVVUUGZtT2Nz?=
 =?utf-8?B?L0R3b1R6eVRBcjhNZUtzb3ByZEZUc3AwbVY2THlNckZ1SFhYcXN1OVNqMWZl?=
 =?utf-8?B?STVuVHZTanZocnNNem9JMGpHREdaN3NNbjlrMVErRTBpaVNPeUtoYndzWitI?=
 =?utf-8?B?NGw5UCtJOFBaQWtDcm5XdFQ5RVdvVVFneDcwdGhIL2d5R0FvUHk2WU9BZkFS?=
 =?utf-8?B?N1VuaFFya1hJd1dLejE4U2ZteEtxKzNnTUkvY3pVVFh1bmhIbGVkSUpyeVc4?=
 =?utf-8?B?SDBUay9LelZDdFlmUzB3K1VPMFpnTFN1M2o5ZnRvdEg0TmFmU0d0ZkhMZUdK?=
 =?utf-8?B?eFhyU01nbkFxSXVtMC9CRk4rSTh2NVpTWHk2WHRPVE94RUMvOHNacFJvZ25a?=
 =?utf-8?B?a1Nra2I2Q0Y4TjU5R1NKTFBqUHlsMS92Wkdhakh3MXVUZ05ham4wdEdyQTV1?=
 =?utf-8?B?S2VXSWMvRmlWNTBhQlNQOElyK2s0ekZud0tOZ1h0akVyNWVNVHNZamxtby8r?=
 =?utf-8?B?Y09LeG82eHljZDM2K3F5Umg5WEQ0WnhIUG9NbjMrbWFWTzNaMml0SkFUZnlS?=
 =?utf-8?B?TFpSYmdHNHhlb3JYdEFpZ0Y5eXpRZ3NTMVh3QTNOSy84b3ZXYVovTTNTWFR6?=
 =?utf-8?B?dll4bWR4bitIdlJJNzJyY1JZa0Y3cCtkZUFJTWhPMVp0eWVNSHhoK21OL3Rw?=
 =?utf-8?B?czJrbWxGcUFkRXRKUCtIa2lVU0w0V252T0tZRDlqcHdXUFF6RUdKakN2Njkr?=
 =?utf-8?B?dmVUR3NGZ1N5OGNEazJ2VkRBUENkNVdsYmtKblRyaGg1WnZpZmxnV1FBNHRx?=
 =?utf-8?B?WkhWekNWd3h2cGFaWHNsLzZJVlhyZmcvMlhmcFFHMmZzV3p2NDZtc1dVZEhC?=
 =?utf-8?B?cUd1MmRVcUg5Vm1aWHJiVVNkWHMva0NqaU9DbldHZWp5Y25QdVZUZ3U1OXc2?=
 =?utf-8?B?am53Rm10dFp3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3o0YnVOS1o0TG9UN21HK2liYWEvZmpxQ2wxa3pRU1BlRm5yalBLZDNLUWJa?=
 =?utf-8?B?bXdKOUU4dXV3OUo2OVRYcUlEREVMSmlMZklpc0RWZFlSUzVRd2o5UkFoNUxN?=
 =?utf-8?B?aFZjSmJrbGJHRFF6Mm1aN2JPcmdJQVI0MnRUY21SQXEwZ2s2Ylc0ZUowVmdk?=
 =?utf-8?B?SE1rNEVYMGJyc3BqTmVyNFVlN0ZlL01nc2t2R09iMjdqOHpVbFl0aVFrd3Vr?=
 =?utf-8?B?UjllQzQ3cGQ1NHJMdXBnT2JTZEhaeWV1akR0VTJjWjdDQ3VFY3FIMm1SaG9n?=
 =?utf-8?B?bW1XbTFHWGJ4ZDF6d0I3VHJRb3NHSTZxcDlCUk1ySllqR2F3WGZPN21GeEp1?=
 =?utf-8?B?YUptNmRaZEFsSVZRRFBObUlPeUVrekFvYVAzQnFTWGNtOW03N3d4TnhiT05U?=
 =?utf-8?B?YTFaQkxBKzVrOVpJKzZxR0xQMnJCcTVCUXZ4Q05Gb2o4MUM3TGJpQlVPc05l?=
 =?utf-8?B?WW9rRFFEdHF3M2pUK3M2VnJLaUUwYmc3RGVCNFBmcEJxdENxZXNsVG5RSkxz?=
 =?utf-8?B?TmJIM1JhSzZRaUZSb1EwT1c2UXoxZGltbk9OWGR4NlpTL1RyRSsyWHlOSytZ?=
 =?utf-8?B?VEFjaFN0RVVJdmt6OTJnUHhEdkpDQVpnNnFBc2JrSElJbmkwRlBNOFFhMnhD?=
 =?utf-8?B?L0Z0bU5abkpJVGRxOHJNaW16UVF2N1VjSmxBVkVVZ0ZDaEZvVWoyR1hxZVpV?=
 =?utf-8?B?a2ZxelM4NHRTYUNRVnUrT2Rjc2thdUU2L2F5eWl0dmx3bUFvZ3RMdE1FaDJZ?=
 =?utf-8?B?dG4zNC9RN0xXeWZxQnBUUXJXalRBdFVhUUx3MEVqbnRXV0ZGUUl2QWRpYUlM?=
 =?utf-8?B?UVVrWm44QUJyR1hXZXJ4ZUNEVHBUWDMzQUFOZ3JraHVvY1lEZGNROFM3dm1Q?=
 =?utf-8?B?TEdyaGxUUFVra0tBWnFLRXdVZHpiWHlxVmFwa0syTk5wQ3prSzRNWnZNVDFL?=
 =?utf-8?B?TjJZRDJBbW1Xc2tRcHlZTEFFNGs2VTluZzJoSXlmVFlWSXUxRE9qbXRIS1RZ?=
 =?utf-8?B?Y2EySFNjdkdMSXF2S2pic0FNNCsyblZjeDdoRTdXa3VQYmlzNk9qdFVkbWhI?=
 =?utf-8?B?ci94RTRjSWRIak5nOHd1NVAwaHlkdElLcTJjUEt3eFFzbDkzVERzM3NEUEJ4?=
 =?utf-8?B?d1IyN3g4ZGsweWMveGR1bkptSWV3RUtXZ1NtY3FZbExSTUI0ODBaZlFpU211?=
 =?utf-8?B?UGxwTy9qcUZUYVNZcTBNR25nRzhHQUlKNmJJcjVOU002emkwMVFlTG9CdXNq?=
 =?utf-8?B?a2RWRnVQZ3Q0cDd0U0FFa3NIbnVPYnNQWHN4cXZSM2ljVnU1cUZtS3duWG5p?=
 =?utf-8?B?bGd6YUNkUlJTK25DVGRhejFHdnpOb0ZqdVdDU3B3cHZrTnVySmR2anJ5ODU1?=
 =?utf-8?B?ZEtWMGlObisyQlpOMGw5RlRqSmxkSzBTei9BRXc0WXEzcDU0YWZrSGxyZlEw?=
 =?utf-8?B?MVEwMDVtODJZM3B1UEx4NWZUOS9kMW5yUEV1cWFwbHU1SmRXN0pWalV2WFU1?=
 =?utf-8?B?MHowdk85dHFxOXJuLysralFadngwdnFkdmI5QmszOWUvemVlYkVsYU1MSk1i?=
 =?utf-8?B?b1B0UG1PbW5yZDhHQThFald4K2ZZQ05na3NJSFFNcFI5REM2Mi9PRko0ZkhX?=
 =?utf-8?B?VHZkeUVJWEtpUTNCdFZ3S0xqbk85Vk5PeXQvb1NQelcxZkJEdzhaMEd3UUpF?=
 =?utf-8?B?T2FmOEp4RHEzYkN6czIvNERMZjA3Rk92OUpwVGZKR0JRb2ltWkR1U2thOHQ0?=
 =?utf-8?B?K01wRFR0dS9WMVNvNnRFbVdvYzZ1N2VsaHRLTFhIVFE4a1g1djJyaVdtQmoy?=
 =?utf-8?B?alo5ZWpJYVdiZGZXMnEwNEIxcTU3ZzZ3ZFZiY3l5WTJ6cFMydlg3eTF5d3p0?=
 =?utf-8?B?QjlKUGo0Z3Vncy9qVVhEdjhycE5NbGU4SFQ5aWhodTNPaXZhVUNuSml4TW1V?=
 =?utf-8?B?dnRkemJNYldvMUFtU01BSnd5OVhTWmc1bzMxREtyUjJLOGVtVjU5c3NEd0V0?=
 =?utf-8?B?dmpSWVRCSzhQTUJkLzJJY1c4b0pWeWJ3Z010OGJCaGtqMDFMdnRGZ3pxenh3?=
 =?utf-8?B?cHdka2FVV25HZDY4M25YcS8rbjNWTDh5VGNucXc3NGlYQmRac2wrTUFGdEZl?=
 =?utf-8?B?clJobS81STk2M21heEMvQTU5a2NreXI1ZVZiN0ZSalVQTkQxZmtnUTZ4UDly?=
 =?utf-8?B?VXNWckZSSzY5cWtjVTVYS0hMQjVZWGtHNGc3RnV3cUg0VlY2THEzOGwySXB2?=
 =?utf-8?B?TmtqdlFEYkdJOFRrcGdlM1VSMGhXQWp2aEZFQ2hQcCtxdkt5aWp0VEZPT29X?=
 =?utf-8?Q?eTYhh5/cnNqkAa/Dqc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41065908-ea33-4233-cf90-08de4ec43a8b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:43:03.7699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKtMNhTkYKf+XLXjyiyoAi08xFma7uz0KzUqIeVOvV58OA26LfBHVaUDFeGxpBS8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574
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

On 1/8/26 13:54, Liang, Prike wrote:
> [Public]
> 
> Hi Alex
> 
> This patch should fix the TLB flush support issue on the older GFX.
> Do you think we should revert the following change to clean up the VM layer flush quirk?

Yeah, agree. The patch below is much cleaner than this quirk.

Regards,
Christian.

> 
> https://lists.freedesktop.org/archives/amd-gfx/2025-December/134959.html
> 
> Regards,
>       Prike
> 
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, January 8, 2026 8:44 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: validate the flush_gpu_tlb_pasid()
>>
>> On 1/6/26 14:19, Prike Liang wrote:
>>> Validate flush_gpu_tlb_pasid() availability before flushing tlb.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> index cd4acc6adc9e..f871f1693483 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -780,6 +780,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
>> amdgpu_device *adev, uint16_t pasid,
>>>             return 0;
>>>
>>>     if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
>>> +
>>> +           if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid)
>>> +                   return 0;
>>> +
>>>             if (adev->gmc.flush_tlb_needs_extra_type_2)
>>>                     adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
>>>                                                              2, all_hub,
> 

