Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E950CAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 02:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 785BF10E2E6;
	Fri, 26 Sep 2025 02:59:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xHt0Oh4m";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2A8910E2E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 02:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4BGwia0Mu1OzijQRIBUCaWikfYWMc/0ky0b5LixUXRLN62B19z45y2TrT8sfUUUu65oZqTA5+BMMSMsdknSZo7Br2E2wlKLdS7VYEHpTMfTbPSU0HNl8i44mLicWVT1N6qD2hcOxJQPt494L5b0WCE0aWbWoKi98rGHqut8nesJ6gCphAGuFl3xLk26yPEKqbO9AasMwrMXSKUO8xd6tjI0ByvaNmTqyLfhSq61rIRhn3Wj3CsqFElLjZGVlHyPIIDjD2G6p2s1CTD+dS6ujwZlSlYGL/P7JxuH5/b8CYPBtNL3fsjE2x5KIWVPAJih1rtz2ILPJHVIkGurEoS/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+V5Lq4rcnVw87VmK+r97HJLaSsS4KG/otbh6cMWv2ps=;
 b=N2K/agzP/w79WVyk3OA9Ag1c58pRWtRZIEbswcNZYacLUodbcSMYLPdSPUzdD/buEWZwT7p3tEFRd4CzhM6Pc84EcqoqubEm5rC5OQAYl0IBzde6QeVII2M1lxhbOSrbMFybf4KKWLI+ZX7NJ9svrEOU5jCH5aizT/QZlOtW7P87LAfqBRHTwIEjpFCIF0ySVCJ6ThVre9wuvjc7yZhz3p33KUbCuSFws0XIGAWiIV7Zh3XJ21ar9p1JKTxDyd3cfMwS5jVLb7bCbHQ4vvBl/cwvazZ61x4B7QTEHZtszyTDCDN76EAAcjAgKAiLkt3xIC7Dvmy0OfUcnMUv8v2Wjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V5Lq4rcnVw87VmK+r97HJLaSsS4KG/otbh6cMWv2ps=;
 b=xHt0Oh4m/dwgwIHBR2XHDAFRa0U8Ayt+XLcfxbySq94UqjGSlBWu2M0TG6m1wlYAlDdGA1feKnw51Evzj69PMq7pxn6ZFYIRKHa8GHsGEpYus8kk1szMFG251d0RMvz+QBDwb0khSIPduy91xH31Gin8RVZ5L9aePXEdxe/yxQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 02:58:56 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.9137.018; Fri, 26 Sep 2025
 02:58:56 +0000
Content-Type: multipart/alternative;
 boundary="------------thPYzTbS4tZMwBd2aFAPGiP7"
Message-ID: <76904dd4-0d36-4c5f-b8a0-f7905fc87853@amd.com>
Date: Fri, 26 Sep 2025 10:58:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 08/18] amdkfd: identify a secondary kfd process by its
 id
To: "Kuehling, Felix" <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
 <20250923072608.252345-9-lingshan.zhu@amd.com>
 <00280d51-4548-4e60-9005-34683d4068d8@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <00280d51-4548-4e60-9005-34683d4068d8@amd.com>
X-ClientProxiedBy: TYCPR01CA0167.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::7) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc6e779-137f-416f-4353-08ddfca8a1fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjRCUEsvQUdmZms3VGVncFZpUFFlaUlOUEFxN1EzeEFCRjRTZ3B3bGUwZGhJ?=
 =?utf-8?B?UHZEL3lqWkhHTWovemU5Qjh4N25iVElsSVBNU0VQLzF4T1lrN2E1ajd2YWFV?=
 =?utf-8?B?bC8rT0RpZUh6dEd5VTQwZnNwbXFXeWlHbDJYSGg4Ylo1NlNBVVZQL3BnT242?=
 =?utf-8?B?K0lnaDJMaGh1eWtDbWtJQzhUektqWlJLVlE0OHdPdkdKTWlIMkVPV1JraWk3?=
 =?utf-8?B?aTRKck1vcGJXUEtZcS9hQ0dvYWJPS0QxcHh3Y09tYjE1OUxQcTVwdFZaYWRC?=
 =?utf-8?B?bmc3RkFBV3MwYXV0OGVHNkVzdXh2M0xqUFFHU3lUZzEybHp4SitkNVhibVNK?=
 =?utf-8?B?ZnRMUVZTTE1rZi9RVGpNMmdEZzZ0Vkg0WVNSNTVPamZQc2VxS1ZteTdIaWFS?=
 =?utf-8?B?dUdRamo2QUxxY2REcUFrVi9iZERHNVNFbmZNUkY5M2U5Qm5EQkVVWjRRM2I0?=
 =?utf-8?B?NXFQZXo3Mms1aW00dHFXWGtkL3czUGRXVTZsZnIxQW1sM0d4OG5GYTNZdUV6?=
 =?utf-8?B?Qlo2VnpIczQxQ3VBaHFVMnZtRmplRG5GRk43MU5JSS84aUpHNjBTNUZoTkF1?=
 =?utf-8?B?cTR3RTgvek1SV0M1Mk1pYjlROTJrdjNiT1F1WjRYenFoR0h3SzRyWXN3aUVs?=
 =?utf-8?B?SXJYVGVkUEllcmdJd1pDTGR3RTNKZGg5S1FIZ1NKRDdBVlptdGVyK0VwNHl2?=
 =?utf-8?B?Ryt1RkhzZHViSUplQ0gzVmx4RU5MeXRMdVhmdTNyZ3RPSUVaQ1pmakM3UFY5?=
 =?utf-8?B?bW1sd1NUOTlGZnMzTmJaQVFrQzc2TVcrbXphbnArcFpwMmcwNGY5MVhHeUFB?=
 =?utf-8?B?ckZUS0puQ1ZGRE1yL3p4Y2VmVFNORURjaU9RbU1SNHNkdmc2S3VQZXNESWl3?=
 =?utf-8?B?Y2NmWUVWNy9iem1TTm1xalI3WFRQQVo2clZteUtOSUhnNjc0V0t1QWdPYmZi?=
 =?utf-8?B?amw5NG5aSXdwMWtKS1YzTU9EMjJ3eHJWSFR5QTJPZHNCeGQ3WExVLyt4ZHpY?=
 =?utf-8?B?R0ZLRVppZEgyYUZYZWF2RmVUVkZVM0hHdE1odTBBaWQ3azEzbXBYYmF5V2lr?=
 =?utf-8?B?d0NjRDlJZ2g5enNaa0xraTFqbzBNSmI0THcrb001Tm9IUGVkNDd2akNtVHNX?=
 =?utf-8?B?RFFKbTFzME5yUHlZdytmck94QU1OYi9qaUhNOThsRmhqK3Iwdmp0RW51UUg5?=
 =?utf-8?B?OFZ6NGl0ZGtVMytwTXVjdlpFSjN1TGwxQ29pdTdOZnBjeXJuRXBuK0Jzb2Yx?=
 =?utf-8?B?bjhtb2xMQkdHZVdsaElTUFlyd2Nxa0FzYXBKLy9OYkhUOXJadERrRVprNGNE?=
 =?utf-8?B?WHhWWEszazNsb3d5ajUzYTNLNlhOTHNYeEhnaE82MndRdzBMVDFvUndFQm1X?=
 =?utf-8?B?SXRPaU9ZZXBvZ0wxRGFIc1RSUDBRbHd2c0VNWVhCUC91QWM0NVE2VTdsbUN1?=
 =?utf-8?B?NzJGc2dpalhGeEFmQmVYUTRiSFFHSTZMTWxQd3BEaU9qRkppYmg1eFl4cFJn?=
 =?utf-8?B?MEFIeGRzWkpTZGdHd0FaUXJ0QU5UM3FYbUF1SlRKVm01RUVEZGZtTnpJOWd4?=
 =?utf-8?B?V29mVGN1R2txZ3V6S0FRbkNWU08yUERydVMwQzZiYm9scjF4dnFhMnZMTTBh?=
 =?utf-8?B?alZRbU9aY2JTR0g1bjNBbHhCaVhBb2FsU3JhbDBZQUdRU3JyelpYZk01eUVS?=
 =?utf-8?B?SHBNcWRodFU1QjBMNWpkTzBOTVlYalRtQisyZ2xLV2E3SUFxSmpLQUtJcXpG?=
 =?utf-8?B?b0cyQmtqY2p4TjRRYWM0Ny9VY2NjSVRUT016Ujl4eWZlYm5NQzBtNk8vWU9S?=
 =?utf-8?B?QmI0MWtoMDVrQ3dxWHArcWh3Vjl1dFdrUEtsZDlxTEhrKzdsWG85SHVQNEZz?=
 =?utf-8?B?ZFF1OWxQcEszS2ZvOG9lMjRjUE5qeXdyR1k2bi9xVGxpdFFSWDFheU44K3o1?=
 =?utf-8?Q?Esc+PUYiNVrDGjuaSkAohIzR8dg8XyZn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG15WHpQY3YySitINk1jRVhGVGVaNFFWdlpsWno0UmwyK2dRMDNXUWx4ejBZ?=
 =?utf-8?B?MlZ3N09zcW1PTU1NMmxicUxwWGJQbG9zcllMc29zY0VmZlhiMWwxNjNMbGhu?=
 =?utf-8?B?UEFxSmFCemFOdTdzaGNWU3FUYko5aUhFQjN3NjZwZ1VMWEswb3NsRWFlVnpB?=
 =?utf-8?B?bkxkTFJKR21OQkhSV1NMdWlsTVl4bmNjUEVBbGRDMVc5ODBDY3RmcmhJTlVv?=
 =?utf-8?B?dlBQWDRVMjdxSmFMMlhSS284ckhMZ21ZOUEycTIvWk5XMWxJc2V4eG9HdDV4?=
 =?utf-8?B?czN0eksvVkwrVUY1MkZEcTQ5cXM5VHY4T2d5eS9JZ0dER0JFbVlpWmF6WVpl?=
 =?utf-8?B?YklYZCtzY25HNDE0MXdOemh1WllzMUlFb3RIc1B1WjFOaWo0cFZnQisvTlpO?=
 =?utf-8?B?Sm41RVVndVgvN3lheWpyZEdrZVY1RTJmNEs2L3FnajB1cGR1TDgxdVZTck42?=
 =?utf-8?B?NitFYU9VeVlhczc1UDVjRUE0V0p5VStiMFdXaHhsZFM2cDhXbmJOVFVaWVQ1?=
 =?utf-8?B?R1FMTFVqM0xYL0kxMURYQVc0UnVhWlROTEtWSi9vYmZka2RrRFdxOWJ4c1o2?=
 =?utf-8?B?UzFhWWRVM25LM2dRaVNVcUdDVHlEb3laODhEaDllaXlIRUdtdm5wOVpzZHRD?=
 =?utf-8?B?QVI4SDVDQTAxWjE4N2tSbjRDWTFLWk1MblFPZzJXLytYWnZqR1BsQTNRMFZE?=
 =?utf-8?B?d3NJaGdSSzNvbmZBQTdSbjNaRUF4czNPRGIremhNTWN6RUFwdVVXZXhrWE56?=
 =?utf-8?B?N2ZyanJsZzltUlVVbWZvOThWRTd2emU3L1dKOU5kRXR3djRGblV5cDlFdk0x?=
 =?utf-8?B?UXhzT2NVckw2YjJMeVQ0MnJRYnoxOFMrUEY4Q053bkFzYnlYVGtja09INE4z?=
 =?utf-8?B?d3hrWmFDR2MrUzJQaVM4MWppdzBQRy9HVC9mOCtMNmNFVkVjT09EZHMrSEhw?=
 =?utf-8?B?ekNYVEpSbGQrL1dvSnlTRHJKa2RwUzA1b0EvcFZFa3o4MjlTR21SRGF1eHB0?=
 =?utf-8?B?cW4ycEZ1K3RZelBaRVJ2VzVsc1NtMThvdU45YnRhS0RFbytxQjRONWJaQUVz?=
 =?utf-8?B?aEtPb2hUdjdTdW9UOUNqclVYZGxPTVhyVGw2ZTRUeUZTRDhlT1N3Umk3Y09E?=
 =?utf-8?B?M3lZSEFjWXhEYmFGMjFCMUFGZDdud0tIZTVJajRMT29hQnI1eVJuQUdBNmNv?=
 =?utf-8?B?WDcxcy9Lbjd1elRrTlRwMkhsZDRKSnpjS3ROQnFFUU9oaDFrMWtkTlVISnY3?=
 =?utf-8?B?NXFudnQ0cHBBQWxCcUhTV2lSRVNzQmR3Z3NrdnZjSml0ankva1BzZGJyT2hi?=
 =?utf-8?B?eWhBclgxVzR4a3JzTFVIeVRlV0ZudUhBOXc3c2tXVkw0b0pXMHdpbHZCeG9o?=
 =?utf-8?B?UHB1TmNwWlkvakV4bkxqRSt5TFRzWHdTUGxtZ0Fpa3V1YTRjR2F2THNncVNF?=
 =?utf-8?B?T1FyVVNLdDQ4a2k0ZmQ2aWo3NEtBTUM1dUZ0OGRDVkZWVzFPOTgvOWpjM0Fu?=
 =?utf-8?B?ejNJSDN0aGtNRnVzL05YWkJocmlqUU9KY2V3UnE2RFNFeElzWEJFZThOc1Zs?=
 =?utf-8?B?TTBiZjV2N2J4Q25uQ3M4UjRjQkYzUnVyOGpjZ2l2R1hkR0p0eDRiYndiejlj?=
 =?utf-8?B?UjA5VXlJUngwTDF1bVVmbDBncEk1Q1lRUFVMcU1kYVM2cGxHZHNNc2FGaGV6?=
 =?utf-8?B?VEIwSXRMQ2VKUm54eE1NK29URnJNaTlNWjM3R014Y1NOeCtZaEM5RnNsb2RW?=
 =?utf-8?B?cTNiSmg5Qm55SjYyd0ZUN0ttOVg1THVXaVZNc2psaUw2NWFGa1VmMXVJMUtO?=
 =?utf-8?B?NTVuWTFnYVV2NUh1VzU5L3VmRGVvSUs5VTF0WUdTOEt0dzFWL0pDdXhTazJZ?=
 =?utf-8?B?ZmNRU3YxZWx2c1E1a2Q3RWlMdGxodktTTEhQUVhqcHJqQlhCeHB4OEF1cStq?=
 =?utf-8?B?Y1cxeGV1WXU2aE9MSTlYRExWYVNrcjU1UjN0RnBTcnlSY3IrQjZ3VTdid2h4?=
 =?utf-8?B?c2ZBRUVhanR0Q3lkMC84WEFEQ2JtQzF6bzBIYmpwNldJa2I1Y0NBOCtNVEpX?=
 =?utf-8?B?cUhCc0dDdHZ3SmxYYm1DanBLNWl2MWlZUG1naGNaWGRUalJiaTJQRFFJNHFG?=
 =?utf-8?Q?uEb7vaLfFaMYj2N3bWK1F0EF5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc6e779-137f-416f-4353-08ddfca8a1fe
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 02:58:56.1704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlPZdgpcMrKExq5kcpWSYamW41kG+ArpEFGfCBNvIgU4EjWXSFVjnnCp5CgaAyEOJfaSkL/lwHaUYEfurZr9xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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

--------------thPYzTbS4tZMwBd2aFAPGiP7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/25/2025 5:41 AM, Kuehling, Felix wrote:

> On 2025-09-23 03:25, Zhu Lingshan wrote:
>> This commit introduces a new id field for
>> struct kfd process, which helps identify
>> a kfd process among multiple contexts that
>> all belong to a single user space program.
>>
>> The sysfs entry of a secondary kfd process
>> is placed under the sysfs entry folder of
>> its primary kfd process.
>>
>> The naming format of the sysfs entry of a secondary
>> kfd process is "context_%u" where %u is the process id.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 ++
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 83 +++++++++++++++++++++++-
>>   2 files changed, 86 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index d1436f1f527d..d140463e221b 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -998,6 +998,9 @@ struct kfd_process {
>>       /* Tracks debug per-vmid request for debug flags */
>>       u32 dbg_flags;
>>   +    /* kfd process id */
>> +    u16 id;
>
> Can this subsume the "primary" flag? E.g. process->id == 0 could mean
> "primary context", and all the secondary contexts could have non-0 IDs. 

I will remove this primary flag and try using process->id to identify the contexts, so here 0 is not a good
default value for this process->id of the primary kfd context anymore, because 0 is the default initialized
value for all kfd contexts, I will assign another default value 0xFFFF to the primary kfd context.

This change will affect some other patches in this series, I will remove their "reviewed-by" tag.

Thanks
Lingshan

>
> Regards,
>   Felix
>
>
>> +
>>       atomic_t poison;
>>       /* Queues are in paused stated because we are in the process of
>> doing a CRIU checkpoint */
>>       bool queues_paused;
>> @@ -1012,6 +1015,9 @@ struct kfd_process {
>>         /* indicating whether this is a primary kfd_process */
>>       bool primary;
>> +
>> +    /* The primary kfd_process allocating IDs for its secondary
>> kfd_process, 0 for primary kfd_process */
>> +    struct ida id_table;
>>   };
>>     #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 5d59a4d994d5..8e498fd35b8c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -54,6 +54,9 @@ DEFINE_MUTEX(kfd_processes_mutex);
>>     DEFINE_SRCU(kfd_processes_srcu);
>>   +#define KFD_PROCESS_ID_MIN 1
>> +#define KFD_PROCESS_ID_WIDTH 16
>> +
>>   /* For process termination handling */
>>   static struct workqueue_struct *kfd_process_wq;
>>   @@ -827,6 +830,7 @@ static void
>> kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
>>     int kfd_create_process_sysfs(struct kfd_process *process)
>>   {
>> +    struct kfd_process *primary_process;
>>       int ret;
>>         if (process->kobj) {
>> @@ -839,9 +843,22 @@ int kfd_create_process_sysfs(struct kfd_process
>> *process)
>>           pr_warn("Creating procfs kobject failed");
>>           return -ENOMEM;
>>       }
>> -    ret = kobject_init_and_add(process->kobj, &procfs_type,
>> -                   procfs.kobj, "%d",
>> -                   (int)process->lead_thread->pid);
>> +
>> +    if (process->primary)
>> +        ret = kobject_init_and_add(process->kobj, &procfs_type,
>> +                       procfs.kobj, "%d",
>> +                       (int)process->lead_thread->pid);
>> +    else {
>> +        primary_process =
>> kfd_lookup_process_by_mm(process->lead_thread->mm);
>> +        if (!primary_process)
>> +            return -ESRCH;
>> +
>> +        ret = kobject_init_and_add(process->kobj, &procfs_type,
>> +                       primary_process->kobj, "context_%u",
>> +                       process->id);
>> +        kfd_unref_process(primary_process);
>> +    }
>> +
>>       if (ret) {
>>           pr_warn("Creating procfs pid directory failed");
>>           kobject_put(process->kobj);
>> @@ -863,6 +880,51 @@ int kfd_create_process_sysfs(struct kfd_process
>> *process)
>>       return 0;
>>   }
>>   +static int kfd_process_alloc_id(struct kfd_process *process)
>> +{
>> +    int ret;
>> +    struct kfd_process *primary_process;
>> +
>> +    if (process->primary) {
>> +        process->id = 0;
>> +
>> +        return 0;
>> +    }
>> +
>> +    primary_process =
>> kfd_lookup_process_by_mm(process->lead_thread->mm);
>> +    if (!primary_process)
>> +        return -ESRCH;
>> +
>> +    ret = ida_alloc_range(&primary_process->id_table,
>> KFD_PROCESS_ID_MIN,
>> +         (1 << KFD_PROCESS_ID_WIDTH) - 1, GFP_KERNEL);
>> +    if (ret < 0)
>> +        goto out;
>> +
>> +    process->id = ret;
>> +    ret = 0;
>> +
>> +out:
>> +    kfd_unref_process(primary_process);
>> +
>> +    return ret;
>> +}
>> +
>> +static void kfd_process_free_id(struct kfd_process *process)
>> +{
>> +    struct kfd_process *primary_process;
>> +
>> +    if (process->primary)
>> +        return;
>> +
>> +    primary_process =
>> kfd_lookup_process_by_mm(process->lead_thread->mm);
>> +    if (!primary_process)
>> +        return;
>> +
>> +    ida_free(&primary_process->id_table, process->id);
>> +
>> +    kfd_unref_process(primary_process);
>> +}
>> +
>>   struct kfd_process *kfd_create_process(struct task_struct *thread)
>>   {
>>       struct kfd_process *process;
>> @@ -1193,6 +1255,11 @@ static void kfd_process_wq_release(struct
>> work_struct *work)
>>       if (ef)
>>           dma_fence_signal(ef);
>>   +    if (!p->primary)
>> +        kfd_process_free_id(p);
>> +    else
>> +        ida_destroy(&p->id_table);
>> +
>>       kfd_process_remove_sysfs(p);
>>       kfd_debugfs_remove_process(p);
>>   @@ -1549,6 +1616,12 @@ static struct kfd_process
>> *create_process(const struct task_struct *thread, bool
>>       process->queues_paused = false;
>>       process->primary = primary;
>>   +    err = kfd_process_alloc_id(process);
>> +    if (err) {
>> +        pr_err("Creating kfd process: failed to alloc an id\n");
>> +        goto err_alloc_id;
>> +    }
>> +
>>       INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
>>       INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
>>       process->last_restore_timestamp = get_jiffies_64();
>> @@ -1599,6 +1672,8 @@ static struct kfd_process *create_process(const
>> struct task_struct *thread, bool
>>               goto err_register_notifier;
>>           }
>>           BUG_ON(mn != &process->mmu_notifier);
>> +
>> +        ida_init(&process->id_table);
>>       }
>>         kfd_unref_process(process);
>> @@ -1619,6 +1694,8 @@ static struct kfd_process *create_process(const
>> struct task_struct *thread, bool
>>   err_process_pqm_init:
>>       kfd_event_free_process(process);
>>   err_event_init:
>> +    kfd_process_free_id(process);
>> +err_alloc_id:
>>       mutex_destroy(&process->mutex);
>>       kfree(process);
>>   err_alloc_process:
--------------thPYzTbS4tZMwBd2aFAPGiP7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 9/25/2025 5:41 AM, Kuehling, Felix wrote:</pre>
    <blockquote type="cite" cite="mid:00280d51-4548-4e60-9005-34683d4068d8@amd.com">On
      2025-09-23 03:25, Zhu Lingshan wrote:
      <br>
      <blockquote type="cite">This commit introduces a new id field for
        <br>
        struct kfd process, which helps identify
        <br>
        a kfd process among multiple contexts that
        <br>
        all belong to a single user space program.
        <br>
        <br>
        The sysfs entry of a secondary kfd process
        <br>
        is placed under the sysfs entry folder of
        <br>
        its primary kfd process.
        <br>
        <br>
        The naming format of the sysfs entry of a secondary
        <br>
        kfd process is &quot;context_%u&quot; where %u is the process id.
        <br>
        <br>
        Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
        <br>
        Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; |&nbsp; 6 ++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c | 83
        +++++++++++++++++++++++-
        <br>
        &nbsp; 2 files changed, 86 insertions(+), 3 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        index d1436f1f527d..d140463e221b 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        @@ -998,6 +998,9 @@ struct kfd_process {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Tracks debug per-vmid request for debug flags */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 dbg_flags;
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; /* kfd process id */
        <br>
        +&nbsp;&nbsp;&nbsp; u16 id;
        <br>
      </blockquote>
      <br>
      Can this subsume the &quot;primary&quot; flag? E.g. process-&gt;id == 0
      could mean &quot;primary context&quot;, and all the secondary contexts could
      have non-0 IDs.&nbsp;<br>
    </blockquote>
    <pre>I will remove this primary flag and try using process-&gt;id to identify the contexts, so here 0 is not a good
default value for this process-&gt;id of the primary kfd context anymore, because 0 is the default initialized
value for all kfd contexts, I will assign another default value 0xFFFF to the primary kfd context.

This change will affect some other patches in this series, I will remove their &quot;reviewed-by&quot; tag.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:00280d51-4548-4e60-9005-34683d4068d8@amd.com"><br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t poison;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Queues are in paused stated because we are in the
        process of doing a CRIU checkpoint */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool queues_paused;
        <br>
        @@ -1012,6 +1015,9 @@ struct kfd_process {
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* indicating whether this is a primary kfd_process */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool primary;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* The primary kfd_process allocating IDs for its secondary
        kfd_process, 0 for primary kfd_process */
        <br>
        +&nbsp;&nbsp;&nbsp; struct ida id_table;
        <br>
        &nbsp; };
        <br>
        &nbsp; &nbsp; #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        index 5d59a4d994d5..8e498fd35b8c 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        @@ -54,6 +54,9 @@ DEFINE_MUTEX(kfd_processes_mutex);
        <br>
        &nbsp; &nbsp; DEFINE_SRCU(kfd_processes_srcu);
        <br>
        &nbsp; +#define KFD_PROCESS_ID_MIN 1
        <br>
        +#define KFD_PROCESS_ID_WIDTH 16
        <br>
        +
        <br>
        &nbsp; /* For process termination handling */
        <br>
        &nbsp; static struct workqueue_struct *kfd_process_wq;
        <br>
        &nbsp; @@ -827,6 +830,7 @@ static void
        kfd_process_device_destroy_ib_mem(struct kfd_process_device
        *pdd)
        <br>
        &nbsp; &nbsp; int kfd_create_process_sysfs(struct kfd_process *process)
        <br>
        &nbsp; {
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_process *primary_process;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (process-&gt;kobj) {
        <br>
        @@ -839,9 +843,22 @@ int kfd_create_process_sysfs(struct
        kfd_process *process)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quot;Creating procfs kobject failed&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp; ret = kobject_init_and_add(process-&gt;kobj,
        &amp;procfs_type,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; procfs.kobj, &quot;%d&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (int)process-&gt;lead_thread-&gt;pid);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (process-&gt;primary)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = kobject_init_and_add(process-&gt;kobj,
        &amp;procfs_type,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; procfs.kobj, &quot;%d&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (int)process-&gt;lead_thread-&gt;pid);
        <br>
        +&nbsp;&nbsp;&nbsp; else {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; primary_process =
        kfd_lookup_process_by_mm(process-&gt;lead_thread-&gt;mm);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!primary_process)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ESRCH;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = kobject_init_and_add(process-&gt;kobj,
        &amp;procfs_type,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; primary_process-&gt;kobj, &quot;context_%u&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;id);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_unref_process(primary_process);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quot;Creating procfs pid directory failed&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(process-&gt;kobj);
        <br>
        @@ -863,6 +880,51 @@ int kfd_create_process_sysfs(struct
        kfd_process *process)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        &nbsp; +static int kfd_process_alloc_id(struct kfd_process *process)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; int ret;
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_process *primary_process;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (process-&gt;primary) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;id = 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; primary_process =
        kfd_lookup_process_by_mm(process-&gt;lead_thread-&gt;mm);
        <br>
        +&nbsp;&nbsp;&nbsp; if (!primary_process)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ESRCH;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; ret = ida_alloc_range(&amp;primary_process-&gt;id_table,
        KFD_PROCESS_ID_MIN,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; KFD_PROCESS_ID_WIDTH) - 1, GFP_KERNEL);
        <br>
        +&nbsp;&nbsp;&nbsp; if (ret &lt; 0)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; process-&gt;id = ret;
        <br>
        +&nbsp;&nbsp;&nbsp; ret = 0;
        <br>
        +
        <br>
        +out:
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_unref_process(primary_process);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return ret;
        <br>
        +}
        <br>
        +
        <br>
        +static void kfd_process_free_id(struct kfd_process *process)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_process *primary_process;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (process-&gt;primary)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; primary_process =
        kfd_lookup_process_by_mm(process-&gt;lead_thread-&gt;mm);
        <br>
        +&nbsp;&nbsp;&nbsp; if (!primary_process)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; ida_free(&amp;primary_process-&gt;id_table,
        process-&gt;id);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_unref_process(primary_process);
        <br>
        +}
        <br>
        +
        <br>
        &nbsp; struct kfd_process *kfd_create_process(struct task_struct
        *thread)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *process;
        <br>
        @@ -1193,6 +1255,11 @@ static void kfd_process_wq_release(struct
        work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ef)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_signal(ef);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; if (!p-&gt;primary)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_free_id(p);
        <br>
        +&nbsp;&nbsp;&nbsp; else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ida_destroy(&amp;p-&gt;id_table);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_remove_sysfs(p);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_debugfs_remove_process(p);
        <br>
        &nbsp; @@ -1549,6 +1616,12 @@ static struct kfd_process
        *create_process(const struct task_struct *thread, bool
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;queues_paused = false;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;primary = primary;
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; err = kfd_process_alloc_id(process);
        <br>
        +&nbsp;&nbsp;&nbsp; if (err) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Creating kfd process: failed to alloc an
        id\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_alloc_id;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;process-&gt;eviction_work,
        evict_process_worker);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;process-&gt;restore_work,
        restore_process_worker);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;last_restore_timestamp = get_jiffies_64();
        <br>
        @@ -1599,6 +1672,8 @@ static struct kfd_process
        *create_process(const struct task_struct *thread, bool
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_register_notifier;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(mn != &amp;process-&gt;mmu_notifier);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ida_init(&amp;process-&gt;id_table);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_unref_process(process);
        <br>
        @@ -1619,6 +1694,8 @@ static struct kfd_process
        *create_process(const struct task_struct *thread, bool
        <br>
        &nbsp; err_process_pqm_init:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_event_free_process(process);
        <br>
        &nbsp; err_event_init:
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_process_free_id(process);
        <br>
        +err_alloc_id:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;process-&gt;mutex);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(process);
        <br>
        &nbsp; err_alloc_process:
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------thPYzTbS4tZMwBd2aFAPGiP7--
