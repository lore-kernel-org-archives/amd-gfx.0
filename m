Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E988CCF9FF
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 08:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E715310E044;
	Fri, 31 Oct 2025 08:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oL65qCh+";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB4210E044
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 08:40:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5Ptcq/FVW9Du1trUrmXrNuylPW0cPtyGCwn0IfomqWk031sFGSM8NIeTuDbrUvz6STzAmE4IOXJ/nv+r2CJfg3gYEK5rJWvhcpUxglHWkD16UnyGWVmLTLEqVJRuDrUriJID97DmuZA+m3kbc8ZvoVPoo1nYLi7BtjIgABt7rs+geiB6n7AbPedZr7PF3pNYXGzzF9c/agum+R1W6wdtf/TShqI7hfhrxkdkV7pUEnXa16FMLLo+9f7QlUvYx5Ctpkacle7zGtcKoHN/TDbyshOnZcRTknoCzSvTa88BkM94K6OKr0nzJl6nCgdnm8QnBXv4YXSt2Zs9Gy4GKL7mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAWrDRMjJ9XE1QTzr5pZZ7W2dyd8b4EkuUmiXdFvWJM=;
 b=y2bgF8Tq/QE/b7B7mVRzR0Wzru+haxjXB+HjuVjTC8g6wikL565u2izxv5rU0dRNSn0WsNztIyfZRO8BEnFffiNvzG+3B4f4x1v2b085AgldyJuoZlhK/0l4UDi2jkQ5PoamT0KfPY599IOIKuJf3tCJKExBjz5FjxVJcMmFTFeLXhx1f/3kMEscp8F3myoM/i+G8ro5XdF9lEvhtLr0yMpXVBDU+meYean/hg3QS29u20vbYrfy+KXaGhng1vM8MlQowslKC6DHtN31EzqZL7Ui7L/NsjCYHoPJzdNvs/nb5aDguZCSpQFOTQ3bP7IbkhE0F9E/WFNDKcjfQtpaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAWrDRMjJ9XE1QTzr5pZZ7W2dyd8b4EkuUmiXdFvWJM=;
 b=oL65qCh+BTtoYRk7SWORO1Sqtp8rDIRmjDsb4Pm/RUt2RWQK54N0D+2c9QO+xabu3qNbZnq+OO5WAQfnRszxHuLPJAgL7zkcXBf/8EAnDCPvza9cj+LH/GxuV78NXLiPTqKE7x5NnSUn16fvUbjnsuNmCsE8m5Ar/R0GoFsxte4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 08:40:01 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 08:39:55 +0000
Content-Type: multipart/alternative;
 boundary="------------SnK01ViafZo33RHeTLyR7tDr"
Message-ID: <6ffc1416-ae2b-4ab0-a602-a3f6711fa213@amd.com>
Date: Fri, 31 Oct 2025 14:09:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: grab a BO reference in vm_lock_done_list.
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Sunil.Khatri@amd.com
References: <20251031082531.32715-1-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20251031082531.32715-1-christian.koenig@amd.com>
X-ClientProxiedBy: PN4PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::17) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CH3PR12MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab43acb-18b4-4673-4026-08de18591114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVZTWVBEdzVOcnB3SlpyUmRUeUNuS0ppK3d3ZktES0ZJZlhoZmJiOVVQWVl5?=
 =?utf-8?B?SzlLaDFwRW95RXlIajNubUZ2UDVtQWtVWCt2ZXN0dnBFYXBWbXZYenl4Mmtz?=
 =?utf-8?B?QzBhdnFtamh4Um1Wb1VIS21UYlB3emw0WUxnR3E5T0xWZ09CK0k1QlJLVG9O?=
 =?utf-8?B?RFFCS1ZPVWhWaVBwcVNoTlZuQTVWOU1zMy9FdVFYcE1GQWt6QnpGYkZBYmFl?=
 =?utf-8?B?S05EMTB5MmJtMldac3FWNjhEd0RPWHc3NUZpU2luQkxxS1ZhOEdnT3g2QVJD?=
 =?utf-8?B?c3FUd0dUVUJIdDY4UE5kMWZYN0pxL2M1RmJHbVQzSVA4U24yc0ZBNyt5cjlB?=
 =?utf-8?B?NUlSbWd1TGxqSFBIUUM1RlVyQ0ZubzRsWDEzcFM0RFFWaXpPL255VnkrbjVL?=
 =?utf-8?B?WExuSHR3TGtmajFjVUNESmROYjl4VGRJeFdhMlkweEo2MGZUdDExM2ZzR3JB?=
 =?utf-8?B?d1JuRWgxbVR2L25RbWhOMVB3WWw1Y2VXcVdqU2VvNzdvb1FScGJ1NlBNbzJr?=
 =?utf-8?B?NndOMnpnd2NHSUdFV2p2NjB5VjArTThHdTBKYzZMdXh3UWMvcTU5K3BKbzBK?=
 =?utf-8?B?ajM4b0F6bUpJVG9nRHdqdHgvZ3poVVBCV0NpeVRJcVNKdmNBczV2RnFnZnBD?=
 =?utf-8?B?d1lSUUlXYjVSdXgvSmtYZHUxY2pYNDNNK2dkdi84aWpjdmNWWENTWE84Tk45?=
 =?utf-8?B?eHlSZXF1THM3RUliVmx0NWxoWjd5Qzdyem1mcGZDLzZkakRCYzNCK1AyV1VB?=
 =?utf-8?B?dW14cDBCcU5VajFEYXRkNUFlRUJJd3Bra2w3Z1hIamp4enF2UkFLY0tObThv?=
 =?utf-8?B?blk1U3I0OGRRSldmU3lZVUdUNUg5Z3IveDlrUXl4anRPdXdTUzI3QVlpcUxy?=
 =?utf-8?B?MUh3YzhRRXcvZFBXd2doZzh4Q1kxbzFGS1VMNGxPQ3dTcEluR2d4WEoxUGpo?=
 =?utf-8?B?cEdnQzZqd1JOVUVPMVRZSk90SlJnZWN3U0sveHZrUWg2bWF1S2JEUDdOR3Zl?=
 =?utf-8?B?UjYrcnZWNkYwTjZwU0luTkNUSnl3dWdTQlNVdE1jUXAxejdCaFNKMFBVUmp6?=
 =?utf-8?B?M1NWVldQU3B3QitZeXZPbEpPdkZyR1o5MXJGZDU5NkxZMHFJd0xEbWQxYjBw?=
 =?utf-8?B?L0hsNHF6alpNaXhsS1FJczVMYlpHV21YT0tkWlc1S2NEKy93L04rWjVQSmdF?=
 =?utf-8?B?cHlxTmRuRGlBaWxneUVDRVhIRWZ1TmJKcWRqckY1NUttYnhYL1VLZW5mdExH?=
 =?utf-8?B?YUE1V2pVa0U1TDBlb0RCd1lFZjlmSlBza29MVklENkkzUzlISmVsRnNNNnB1?=
 =?utf-8?B?NGN1d1pEalNaQU5Ub2V0L25lS2tRL09aTGs0N3N2bE5PSGx1cjNlWUN0bGdF?=
 =?utf-8?B?UjZuL1VtNnpOYXdmOG9rb3VObXZTUGlLa3RhU05ueFkxVjRvT1NyVVJBaTY2?=
 =?utf-8?B?MUJXYS92NUNPSERiMVFnQ2RzenI5RXE0NlloVDNQY0dzZStwamVRL3hNZWNm?=
 =?utf-8?B?L0hXQy9BTDNvMVhWTWVsaEZidUV1TEhBbG4yck8zeFloMlNSY0crQUcvR2px?=
 =?utf-8?B?WFJqVzRHWnNJTEUxSHdQSnJvWmZxQW55eXFSaTlyeCtsWHNoVUVUY3oweGRK?=
 =?utf-8?B?d1NSZjlUajNNM01uMXlxQy9nREpaOWd6VS95a1JWZnVaa3BNTXpLL05XazF3?=
 =?utf-8?B?azl5UmxPaGI1Q1FDZXhiakplN0hHbXVDSDljNWhwQVFRQndGZXNvbXBaajZB?=
 =?utf-8?B?cXJ0VzY1SjRVTlJ6b0Y3T2FmeXRTOSsxNy82a3ZLdlJWS1piVnFxZWIvOW50?=
 =?utf-8?B?d2JTdnVXcHgxTFhONTNlN0RBRm5jc0VQSVVMaXhhV1JscjdIM2tpbEswYXdz?=
 =?utf-8?B?TGFWYTl3blhxZTV2VHBJakdSR0pZZk9meHBISDkrelJSK05raXVNSVFvcWxt?=
 =?utf-8?Q?Y6JmOlioVoZmjLoeGqhlBXJajWKx2VVF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkdMUE05TmVkaHpnajhDWjl4TTEwaUFJcHhHSVFyQS8yN1k5Q0I2OExRcTVl?=
 =?utf-8?B?ZU14bkN6eFhFdjJTV2R1MXhWUGlaNjF0UENuS0Ftd3pQWnQxUDNSbXlvWHox?=
 =?utf-8?B?ZzcrR1Q0RVlQVjRyS28xWG1vSE9ESHZMeTFxYVBBSU95ZmE0cTBNRjJOcVo5?=
 =?utf-8?B?TWNvSzB2UlRNTkJzZUYvWmJ6UkZXUDZPS2szb1dnbXRsTHVoT1YyV0thaXZW?=
 =?utf-8?B?d0ZYaE1XeHI5N3RDQXJYUUpzYkE2UHdBK29HM2doQlYxekZjVkRqUUlrbUJz?=
 =?utf-8?B?c3RKbFhBTCt2a3JFN0l4Mi85ZmJMbUxDUkdGVTZqUzZTWkVsLzNYUW83bG5E?=
 =?utf-8?B?U0xlTFBMajdhOERoZGhhQlZGaDcxWTNBRW5VV3hhTnF0ZUVla2M5QkRMSUdj?=
 =?utf-8?B?bE1zZlJxbVpudXRUMmJuSXNVZFhMS29ZUjRyMmlpVlZBd1NUNFFxUmJOSTJm?=
 =?utf-8?B?eHJ1NS9lc1BTc2puMGdMWU0vWUR0Y3JrNmwyZm43WnkxZTdHN0lvUHJmbk1D?=
 =?utf-8?B?dVVUbk9wdUhJY2kvSzd1blJ1M1lKQjF0ZElMYWZOckY2M0c0Sy9Ed3A2Vlo3?=
 =?utf-8?B?cWxMU1dGaHljZDhnUXZOZlV1N3o1ekdjMFlmdzVWOWg0QnI5RklYSG9WcDNS?=
 =?utf-8?B?MUZ4Tzl1TUJXb1Q0YWlOSmlsR2owaEpWejZzK0VmMklxaXRzVUtjYTdOOVJZ?=
 =?utf-8?B?MTZrQ3NENUJxZHhTRUFzRjFGSDN1NkNJUTNyUUtOcEVTTjAwdjJKSkNxb3J0?=
 =?utf-8?B?NVB3d2tWL2V3VDBoeVJCS2Z2YytzekgrNGh4M2h6bHdFM3JKVWhqVmtFRStP?=
 =?utf-8?B?L1kzWGhzeWZCMWxkU3M4OU5DMC9nYWdzZXl5bWVveEtYTlJOc3pBSkNCUWVE?=
 =?utf-8?B?SGhqdXc0RkhjSlMyVjhqY3RjL240M1ZLcktybW5RY3JZMjgxMWxZcXJvKzdC?=
 =?utf-8?B?UHJNdDJlMFZ5MklUSGNJVjg0NDBrT21jMzc0V3B3aG1GaWtYQ2RMWjlGRERk?=
 =?utf-8?B?Q1lRbThZKzlyc2drd1FrZStQYzRpa05ZTGhpTFhCaWtUS3FDekhOWWlXbWty?=
 =?utf-8?B?cmpGVTdmYzduc1FLN2llR3I3Z0Z5VmJ1bXdqc0VYemJWME1KZGF0N1U1elEx?=
 =?utf-8?B?bThMYmVSZHQ5TU44dFFnWFNTc0RsZGRSVmNIcklPSjFvSzFkbGx0eTdyVUoz?=
 =?utf-8?B?bzFpcGsrNE5xbVlyNTZhY3pyTFhlR0U3YkhPK1hxb1dNakZIV1NFaFZONUls?=
 =?utf-8?B?Q3V2T1JxRG1aQzVKR290SThQV3pMYnJaTk9YQlBsbkg0d1NmcmFwT2FsV1F4?=
 =?utf-8?B?Tm8vZzR6TGo2bGwrdG1pV2hhRWhqV25Yb3RUN280UXFqR3VZYzMyUjQ4Z2w0?=
 =?utf-8?B?K0tYbGNtYnlQYitCOFpJNzFRaGx5SWJPR043OHN0OEZVajZKenRZSzJubVVR?=
 =?utf-8?B?by9WMEpKMnFkOUVSN01CNWVRUTVkRzE2ME1JUFlMNXVhMWpJMVRGc0dnV3Jn?=
 =?utf-8?B?ODhsYVFGb09tNW1seFFGMzJkYm5XVGYwZ3cvUWZrZlFkd0pEWW9sSFFEOHc4?=
 =?utf-8?B?Mi85RWtwWVUwcXVFYm8yN0FlTUlja3Jobm5CR3dYZTU1dHhxNC8xcUpYYXh1?=
 =?utf-8?B?TVZBdjhqSnJteXlZRnRQSzAwYWdjOEFOZFk3cHRsWGkyWVJzbmNIdFhMREh4?=
 =?utf-8?B?aDZiUmdYYW5UVTE2M253bGI5emd2VDZNMUduMGQ1N3k2Mkd2eTRlZVFRSWNu?=
 =?utf-8?B?MnRrM2hTL1JLSXo5V0E3ZUdhU0FaaHZVbWFzeGNoQ3A0ZG0weU9wZktGVWZu?=
 =?utf-8?B?Z1grY2NSUXBPWHplcWwwVzNoL1RMNVI1RUN4TDFPN0FJUDlJL3NyTDRVQi9F?=
 =?utf-8?B?V3BlNU1IVFQ2bTc5QXRYOG5EZkx6OTl6Vk9iNDJYM3p0aFlzM1M3SFFtVG1V?=
 =?utf-8?B?bTE2dEk2T3k3N085NlNMbWcraWFuMS92d0pNT2hXRGJkeDFXK2x3dWtVUTAx?=
 =?utf-8?B?UDdnOXRLWkxTVE5hbExuMzdJM0Jjck5uZmw2Qld0TE5SR0NLNlZKUGVlTVdU?=
 =?utf-8?B?OGJNcGJ5R203QWV5d1ZUTFJFd2RYUktxRlVreGMzdnlBamRYZ0ZoOGRHTVpZ?=
 =?utf-8?Q?7FjZFJa+iUO8LgGPNdb4qcCRT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab43acb-18b4-4673-4026-08de18591114
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 08:39:55.4347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5K4KPVnGqYWhzUZBhHVCEI88ZChzefHY31KBCle/f036pWpJIMTXtNfoqmD+STvqoPV5HLKsUx4ql6oif3zAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432
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

--------------SnK01ViafZo33RHeTLyR7tDr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 31-10-2025 01:55 pm, Christian König wrote:
> Otherwise it is possible that between dropping the status lock and
> locking the BO that the BO is freed up.
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index db66b4232de0..c3dfb949a9b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -484,15 +484,19 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
>   	spin_lock(&vm->status_lock);
>   	while (!list_is_head(prev->next, &vm->done)) {
>   		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
> -		spin_unlock(&vm->status_lock);
>   
>   		bo = bo_va->base.bo;
>   		if (bo) {
> +			amdgpu_bo_ref(bo);
> +			spin_unlock(&vm->status_lock);
> +
>   			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);

Just for my understanding, there is a possibility that a bo is free 
after spin_unlock and we might be using a stale/NULL ptr of bo.  So we 
are taking a reference before releasing the lock to make

sure the bo is valid. Now calling drm_exec_prepare_obj take a recount to 
make sure the bo is always from now on. Reviewed-by: Sunil Khatri 
<sunil.khatri@amd.com>

> +			amdgpu_bo_unref(&bo);
>   			if (unlikely(ret))
>   				return ret;
> +
> +			spin_lock(&vm->status_lock);
>   		}
> -		spin_lock(&vm->status_lock);
>   		prev = prev->next;
>   	}
>   	spin_unlock(&vm->status_lock);
--------------SnK01ViafZo33RHeTLyR7tDr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 31-10-2025 01:55 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20251031082531.32715-1-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">Otherwise it is possible that between dropping the status lock and
locking the BO that the BO is freed up.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index db66b4232de0..c3dfb949a9b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -484,15 +484,19 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
 	spin_lock(&amp;vm-&gt;status_lock);
 	while (!list_is_head(prev-&gt;next, &amp;vm-&gt;done)) {
 		bo_va = list_entry(prev-&gt;next, typeof(*bo_va), base.vm_status);
-		spin_unlock(&amp;vm-&gt;status_lock);
 
 		bo = bo_va-&gt;base.bo;
 		if (bo) {
+			amdgpu_bo_ref(bo);
+			spin_unlock(&amp;vm-&gt;status_lock);
+
 			ret = drm_exec_prepare_obj(exec, &amp;bo-&gt;tbo.base, 1);</pre>
    </blockquote>
    <p>Just for my understanding, there is a possibility that a bo is
      free after spin_unlock and we might be using a stale/NULL ptr of
      bo.&nbsp; So we are taking a reference before releasing the lock to
      make</p>
    <p>sure the bo is valid. Now calling&nbsp;<span style="white-space: pre-wrap">drm_exec_prepare_obj take a recount to make sure the bo is always from now on.

</span>Reviewed-by:
      Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a></p>
    <blockquote type="cite" cite="mid:20251031082531.32715-1-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">
+			amdgpu_bo_unref(&amp;bo);
 			if (unlikely(ret))
 				return ret;
+
+			spin_lock(&amp;vm-&gt;status_lock);
 		}
-		spin_lock(&amp;vm-&gt;status_lock);
 		prev = prev-&gt;next;
 	}
 	spin_unlock(&amp;vm-&gt;status_lock);
</pre>
    </blockquote>
  </body>
</html>

--------------SnK01ViafZo33RHeTLyR7tDr--
