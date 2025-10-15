Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636F6CCD18E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 14:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD9610E2A1;
	Wed, 15 Oct 2025 14:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kX9UQQjK";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E303A10E2A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 14:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDLOmo7uaNTVE2yusrCah3kebPsuZZKxNqpKNQKH3Z/eBxukkZ89weuhIcqsjg/G4ncix9XA6Jixd6y8ZdlKQqk6pE3RCaKGRVKgGDB6XnmtuADRArjOunZPkDSJCTinU8Lepqa0Zoz+Vvj0FAlcdU8moyoxjIRhr1TFBPwWB1QM3Rsp1deItDdoajto4nPGx8IElPpoAp+3DtE5z9p+naFwwqXHmc3cg/ektq9jfFkRpaZ5+63o4pAGvbQDHuM3j2Rhox1gLHFk4j27jN4NUZT79cxi8jGFq8U5QWvI7sOUcDiUlDCCTTVubQRRVnC1rHVYSYKSV9aM3EGHcfu26g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQl1Jmvao/jMEJ1OU79MQMg8f/cqiyiWREvD+7DCdew=;
 b=czfbUYk0POwUo/xuStak3I17n5rqVCzY/1I6w0h2Nu9hwV9Nu/PlD2yogLHX7rYZfEC6UAZlyyH+o1QnUSuvcTCuXTPUXDdf4f6IbZRSth1OSmDHQq6KPr79vZaz8swW4c7GBgheO/rt+Y9CqN8Jz/GEsse1x8GZLH+yG5cHdHhGVnTDMUe/dKw9btTUu8xr7flDArCzp8qQ6aHLNxEIsPgUik859SavULW6AFaBx7gRg3C9E4RIYS8cP7fwly/Vesp3e3AvJnx7wbrj16QiBntZUTIAdidjVY0tCPNoWcWs4EPf+69NhdJG3JBIrmkxUUrwGRm6iS9mIIK+BpTETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQl1Jmvao/jMEJ1OU79MQMg8f/cqiyiWREvD+7DCdew=;
 b=kX9UQQjKKbZ99LoAlOQeNnDyR8cb5iA2h9/b89GHa0CKOcndXLGDjbOktC1mef7AAKqGn0sxt/zjbdc71yVY9s5K6qfdlzWMLmiD7SAcOsoHfQagA0bfXh35ceAyyou3VbTi4hQPMad05bc4a90N3xZls3oX8mnGZPjm1FvEXRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 14:19:48 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 14:19:48 +0000
Message-ID: <a1465fe4-f17b-4a72-935d-df0105a45e6a@amd.com>
Date: Wed, 15 Oct 2025 10:19:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amd/display: Check if display HW is enabled in
 amdgpu_dm_atomic_check()
To: Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20251014193036.595453-1-mario.limonciello@amd.com>
 <20251014193036.595453-2-mario.limonciello@amd.com>
 <CADnq5_P-9F0NsOK_5HG06YP98vqJH+1RXxfEnhnAhQ_U1Q=DNQ@mail.gmail.com>
 <d462f951-1b9d-4390-800f-9af09a7282d5@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <d462f951-1b9d-4390-800f-9af09a7282d5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:408:f4::10) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c2bd11-4923-4850-7ea4-08de0bf5e59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1N2OWRZR0RkWFA4ZWU2WUc0TEdHYkRSbGFsRW5EV2FyWWw1ZnpUTUJXc2xa?=
 =?utf-8?B?TDliK3QrWHNiS0M3azBFbVNaMmxGa3VUTEVsY0RoL1JNYkJxbjU5YVpySnJr?=
 =?utf-8?B?aDhzQjZYdGJpK1F5c0liU2MrRlk5dW5UTllGVHhoTG1nMjROTXJNOVhPNzVn?=
 =?utf-8?B?d2JvRXZWcDdvRFdvaVVnT3ppYmZGUDJRUlA4UlJscDZlMXhpWjk5dmNkVWFx?=
 =?utf-8?B?N0pBYk5HYjM4Qitya0FjZ3lXNGxjMGNOSDBYRUpSeFdvaWFmVHJzRzBDVnQx?=
 =?utf-8?B?dlpoMUJvdXFJY2xUemNPWi9BNkNEcmlBakxSMGVKZEtsUjFSZlhEUGI4Qkxl?=
 =?utf-8?B?RHl3RWlIZ0xYWjMwWU5keUFzL1ZRU3hHQTlZT1pDWnlIeEZ1SXRTVWp0OWNE?=
 =?utf-8?B?MnhHSHNYdmVSMjZBUGxNdTFMLzZqbnFrTFRSZ2VBTXNacU5SOStvQzlrRXhy?=
 =?utf-8?B?UGpieXdtMng2R1dGb29TaXBuaUJuQ05tbU9DV0NFN0NnVHVybXVMWFlCV3hW?=
 =?utf-8?B?a0NDL29UYUNuM2x4SXQvTmlkd0ZORWVtUHl2bzZJVVN0OTJLK0VwWHAxRndT?=
 =?utf-8?B?YnFoaHBZSnh4WjhjOEFnRlZLMXRzNUVBY0ZDdWNkQXVvYTBlM0w3LzFFK0ov?=
 =?utf-8?B?ekllNk5IRkd1RmY0QnNBNXMydHdPQjNsSklQalI3eGlSSS9mU2p2YU4rTkdw?=
 =?utf-8?B?V092S1BvSDBmY2h3dGVHUnBCQWdnYlgzUVhUQ0FpdEF3V2daOXdYSDZtdFhT?=
 =?utf-8?B?Uk1GaWNRL2l3Ykt1M3N5WVBmSU9nbkNNQ3M4UDIzWFNQTXdSM3A1NjFSOEQ3?=
 =?utf-8?B?YjVFcG1JUGtCWXo1U3FQRGw2aGVjRXVyeituSjlBdEJGc0VZL1RBcVM1Q3R0?=
 =?utf-8?B?Vkw0ZG1seE4wZ0NJVzJlb0NYVVFuSnBDVVlvQVp4Yk9XRzF2M2JUUEIvMmkw?=
 =?utf-8?B?aDNINlhPd2FCRmlGend6Sml2TVVHQ1VZRHFBTldxR2NZR2VhQmxYYjRlUzZQ?=
 =?utf-8?B?NW4yU0JkeEdWRGh4QStkSnBwVU9jUHYrS2FzQU9NdkNOQjIya2ErZG8xYm9U?=
 =?utf-8?B?NzN4cVNieGpHM1JKUVZMb1FwSVFxcy9VY25pTnFqRFkralo5U1FIMldpTzd6?=
 =?utf-8?B?OUdmK0VTcGxMZExGTGNFUCtUNUprYWI0emdZYVdoNDlrWXd1TlB6eUhjYlU0?=
 =?utf-8?B?TTQ3aG5PUFJuNmMyem9say9yT3hYNk1xM3d1RUJoOGlibEQ1Z2ZqendzOHJR?=
 =?utf-8?B?OUpIQ0VpOWlqeVBCd3Z2dzgvR2YxRkgvMlRndXM2NTNXUVZrM0M2b2cySmYv?=
 =?utf-8?B?WjdmOFdjYU95MXhHYjFTQ2oxRkl4WmRtclZaazZBTk1TeUhrdXpvNFFVOWhZ?=
 =?utf-8?B?V1pUZ0RISzNoekFRdkppMGlLUHZsY1ZYNUJUMjcyM2lQN3A5cjg5MnNZRnVM?=
 =?utf-8?B?cERUSnowc1dVUEZIWXZzL0F5bEpsN1gvM3lGbXZkYUJmNW1yclo3WTVZeDRJ?=
 =?utf-8?B?S3k2VmNnWXZCRFc3QkdVTmdvWUFLZ00rdE1nUko0TWZaS3dybWcyR1pFUE92?=
 =?utf-8?B?ZFVieFZMRDdMNlVBVzlkT1J0djhkM0c0S1NOQ0tNc1VJSzY2SHV0OVkyZTdJ?=
 =?utf-8?B?TXNVMXI0TEhDMVM4VndiUjFQM3NJWnIvK0VvUTFjOFp5bHJ0Nmc4NEduN1Z2?=
 =?utf-8?B?c3UxTmRSWDUzZGplUDk3bUJUY09JODFJdmMvUWgydWh6Ylp1TFV1VjNDY3V0?=
 =?utf-8?B?N2FwbVQ2QmlwREtJczlOdy9iaDhqRFdYRTNuQ1Nic0UvZTdJbGNuYXdpR0d1?=
 =?utf-8?B?cTVleUYwOUJ2eFY1ak9rM0xIdUZFU1lBV3BvSWNGZVJtcksxZVRwcHdMdUQ4?=
 =?utf-8?B?c1dOUUFWdFAwdmhENmM1bmluUjlrUjZXc2YwQTdha210S0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEJTSm5KdUdxTXh6ZjBXdmpza0h6K0tqTEMvRXFXWW1wTENhbTNON0ZjZG1X?=
 =?utf-8?B?UDRkOTNDU0Q4cEhNTzh1WUxOTlV0T09JV3NDYlo3a1hzUGpsRm9rRW1ZaGV4?=
 =?utf-8?B?dXZNQzB4WU1LNCtpMzN2OE4rUlRJV3hMOElaL0kvbTg2UU9yTllZK1g5bC9q?=
 =?utf-8?B?VENtMll1dnJYYkd2SjFSZ2RDSGtKWU5rYTBUVzlubEN4Qm1CTXJ6N1IrV1Fz?=
 =?utf-8?B?SUg4N3RtTWM0MVYvNDFVSVVUUm9sVG82V3E5MkhGZkl0NE13TXhCdi9zYTJm?=
 =?utf-8?B?Nm5DWEtmZktVbXBWeTZTcUgxei9UcHQ2dlhtNkZQVTBPK1REMzVBeVY5bHkz?=
 =?utf-8?B?a2VXZDk0allCWUplT2NpalZEcFkyMU5tb3VndWFkcFp6ZzhvdVZMdk5IdVYr?=
 =?utf-8?B?N1YydHJEZWJxaDB6V2xMallCWWVjejhvOWpVbGxFTExKcWd3YktMVEFEYW5W?=
 =?utf-8?B?QW9maFVTZ2lnU3FiaUdHN244RjBRbVFPWG52L2RWUlZ0YlNuOUs4cjFDSndX?=
 =?utf-8?B?bWJHeXZHMDQvSVBoUWVaUWxFcnMwM3BNMFVBRFB4NGhOcWYwMUttMjI5OUE3?=
 =?utf-8?B?ajRNSUFPaVQ1ekkrTnZpVHRwZTZJNjBUUHR0OWo1YmF4YVVHSW94bmR3dGti?=
 =?utf-8?B?aGJtV1kwMDJaNXY0ODlHQkd4SkV0RWNGTnlLdnh1ZGVqR2o4T1BDWnR4eFU1?=
 =?utf-8?B?b01aQ0RjTGNrWDFwSUd5TDl6c01EM0hjMWlFWUVVM05oK0h5VjFydmNTWTk0?=
 =?utf-8?B?WUE2TldCcDJ2VnpNajNvRGptYnhLcjJIU2tQQ3JQVTBUVThCMUV3dzlpUWZI?=
 =?utf-8?B?RFVJK3A4cjFNNDVWZTR4OWxRT3BlNSttMFVTK3RQTzliUXpuYUQ0QXdjN3FP?=
 =?utf-8?B?eUY2MHVYVVdoUGRWMWo4bmhiS1lUbnp5UGpjc05qZklycndySmdWWk9NRmJR?=
 =?utf-8?B?dGZGeDhCelU5VXJWVmpWQisyRTNpWi9mUXppZ2NhdDJKbmwxUFpFYTB2b1FF?=
 =?utf-8?B?bDZWZk5BVGZINWdYbDhzMTZqMUFDWHBMTjlWS2ZUQVU4YnB3UURHQmk5R1RU?=
 =?utf-8?B?THFzQ053ZnQrVlFJRGhINXczSEcrczl6VXNHOS9DMFF2elhZZ2I0VmVVSmF3?=
 =?utf-8?B?a1pwdjVSc2hnbjN5SVVvMUErOG81K1NtNUk3cmwrMHI1ZzZTNDhWZEFlREls?=
 =?utf-8?B?QnhOMHRndnRsbE52VGJ5YnkvMXJxTTdXZUQwUzlWZHV5amZ0eGZtOXFkN05M?=
 =?utf-8?B?c25uK3NvUE02a04zQ1daaVhIV002NFJIeDNBZzB6dlBQSVFYS2FGaFN6cmFZ?=
 =?utf-8?B?VTNaNVNRbmRzWjZXV25PbmplSzNpTll0ajNRSmEvV004TEZDQnFMTFlqUWVV?=
 =?utf-8?B?dDRnSUFsbWJzOU1mT3RwbTZSODM1UTNOMkRhZ1FaSDZVWmxnRnJPa016d0Zs?=
 =?utf-8?B?ZHpsaERlZmJ4SkgrUkRseFdNRiszQ3piUGtkdTBRMmVwZWtEOEUyMk5DRFJI?=
 =?utf-8?B?RFdMRnlSL2xkQjZhS1h4NFd6emdNSlNyUSt6Q1d1cHF3bTQzSG9iMkFJNk9X?=
 =?utf-8?B?QWQ3WWZvWDBlZmRENHRrcDlZSm03UmptQS9JaHc2cXVCV1JjNnZwRFZ2eGVm?=
 =?utf-8?B?SlB3eERMNzVNRjl3WjNFK0tiN05ZTkpBSjRDUnpJVVdFTHpNTDhtT3M3aUJ1?=
 =?utf-8?B?OFF6dHV5bDFmcFQxODNIQXNNZUxlbHNiRXlPUlFhU2RvaG4yMGQ5TVNsM2w1?=
 =?utf-8?B?YjU5MmI5S0xYSDZqQmtQTHdIc0oyd0JNVGo3Yzhza1B2QU12My9KeDEzZDV3?=
 =?utf-8?B?WnM5WHUzUFNzV2Q0bWx5UVVhaGRtQ1NnR2lRcW1ubFlKcHRlelp0UUJDMEpI?=
 =?utf-8?B?WEhSYUFVTWo1RmJUZUZLNlRFTWhjUDhQd2lVUi9qNzlSTFY1aTQ3Z29lVVov?=
 =?utf-8?B?N2poUW02eGNHeUpaK0tWTi9UaTdkZXBhUUxXb1JyNDVLYXV6R1VNVE5Bb25S?=
 =?utf-8?B?cnVTN2hJZDNBblRrUHFTVUtMbTFHTTFJemZSY3BPanhldm40cjlUdk1HQmoy?=
 =?utf-8?B?cVhCd3FrbXlJcEhYL0xQRlhPSnhERjFPbHFFYStvcVlITEtXZjlQVVJiSmFw?=
 =?utf-8?Q?yBH3KLvCDtsfHmdoXdydkSgRy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c2bd11-4923-4850-7ea4-08de0bf5e59b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 14:19:48.2848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJ1xtJZMp62EMkqJ4EOVDWhdLVQNzLyoMHUFqQ38PLeMTjE6qVb73CEFdzKMbUSDAiko5W7FzXQq6GCHtqv79w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191
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



On 2025-10-14 17:38, Mario Limonciello wrote:
> 
> 
> On 10/14/2025 4:27 PM, Alex Deucher wrote:
>> On Tue, Oct 14, 2025 at 3:46 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>> [Why]
>>> If userspace hasn't frozen user processes (like systemd does with
>>> user.slice) then an aborted hibernate could give control back to
>>> userspace before display hardware is resumed.  IoW an atomic commit could
>>> be done while the hardware is in D3, which could hang a system.
>>
>> Is there any way to prevent this altogether?  
> 
> The obvious way is that userspace should be freezing user processes. That's what systemd does.
> 
>> This seems like a recipe
>> for trouble for any driver.
> 
> If we want to uplevel this kind of check I think we would need some helper to report hardware status into drm and drm would have to call that.
> 
> Most distros use systemd, and this only happened in an aborted hibernate.  I guess I'd like to see how much this warning actually comes up before deciding if all that plumbing is worth it.

I was briefly thinking about a generic solution as well and don't
think it's worth it at this point. This is mostly about internal
driver/HW state.

Harry

>>
>> Alex
>>
>>>
>>> [How]
>>> Add a check whether the IP block hardware is ready to the atomic check
>>> handler and return a failure. Userspace shouldn't do an atomic commit if
>>> the atomic check fails.
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> Cc: Harry Wentland <harry.wentland@amd.com>
>>> v2:
>>>   * Return -EBUSY instead (Harry)
>>> ---
>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 6446ec6c21d4..f5cd9982af99 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -12010,6 +12010,11 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>
>>>          trace_amdgpu_dm_atomic_check_begin(state);
>>>
>>> +       if (WARN_ON(unlikely(!amdgpu_device_ip_is_hw(adev, AMD_IP_BLOCK_TYPE_DCE)))) {
>>> +               ret = -EBUSY;
>>> +               goto fail;
>>> +       }
>>> +
>>>          ret = drm_atomic_helper_check_modeset(dev, state);
>>>          if (ret) {
>>>                  drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() failed\n");
>>> -- 
>>> 2.49.0
>>>
> 

