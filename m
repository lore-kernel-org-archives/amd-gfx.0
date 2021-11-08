Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CF6C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F72060FE8
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 14:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7F72060FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21FCE6E207;
	Mon,  8 Nov 2021 14:41:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB786E207
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 14:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbJylM4hR7ngNm7gIqOVIoPol6XxLU/Xnl3wtcSER475LKNFcAYyAf1L+jKZowTZ72PIdV7Z6qiAv7PKLSXqyssFaQ8DtiJucFRKKww2tKAqj++lNoF6jncrHrt/Y7KK3DlTKFShltKMEtZTm+6rOrVxemRBQ0DVwoSlRpXRNTEmnIx9i/Udjh22N8XudUVb6rc/nXOvDNqxc2JzgLFa28JVRmC28oSPhBPOgI/T2yq2K28o//YaPlLLUedSIiKMLKH+q9yNV24okqI89pUmNVEuAlrO+SyoyljZgB06v9eBamkUMvOgIr3MhOsU0fEP07hhouTzdTX+NBRrwG3BQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT+ahNOOzZH3FZxJbMC+UN2H9CbM/wxL0gofuPxU7rM=;
 b=M/jXwWkpycMqTSmlY8NIm7lyrp7M1QbvWX3xzmf6AitvXjK7qk0/2rA1tvq+zNVQHQi9yw1EtmUABMHU+cX+vrPu+TkEoZDuuZhs0oh2jplqwF7wqBpQfPtBM+jAkP0wGqwMRevgjr/g8/t4qEYWdy3BcR0VrtZVmneNe73+x0qDvbaS+Kq3DBMO/W2rAcZvSva/LgpzAwfPxR5LPun6Rpy4KLQtYAaF5uUSatXxZzLIOgRR/X7zLk4z//chDNiszUhF0zvsiCGIm/ZiiMidsw4aKHtPg1f3BX2dtyULCH1XJa+tqWrEfsMdafUDXsR6hrvLSb+fp0a52pvIMd7oHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT+ahNOOzZH3FZxJbMC+UN2H9CbM/wxL0gofuPxU7rM=;
 b=rVLKe8JCcbRtlpv7EcDzMmrtvT+pBJlwXYrStkvtvl3x+g96qwMf22J5psV6o2N9mwE1tg/LapvTACD2GCfPw94oBFI9pjcgX4QLmVaX7KDQ2FaiW4htZF57wM2aSeLI2WB3CJkL0FRncM5Et++QwnPpNKGWm0U1a/3FLwFvDiQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB1435.namprd12.prod.outlook.com (2603:10b6:3:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Mon, 8 Nov
 2021 14:41:27 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 14:41:27 +0000
Message-ID: <d35eca15-df36-5885-ca31-a1bd50f09fdf@amd.com>
Date: Mon, 8 Nov 2021 20:11:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/pm: avoid duplicate powergate/ungate setting
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Borislav Petkov <bp@suse.de>, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20211108044723.54716-1-evan.quan@amd.com>
 <427ace3e-ba04-bd5c-4eef-d83147ef288e@molgen.mpg.de>
 <YYkGteomN5Cbh1+C@zn.tnic> <3800b659-f0cb-2565-c525-91b5b34d1a30@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <3800b659-f0cb-2565-c525-91b5b34d1a30@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::12) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0069.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:99::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 14:41:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f759ca42-88ad-47a8-7060-08d9a2c5d85a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1435:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14355999679B0B52262457FE97919@DM5PR12MB1435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znXFKb3Mevc9U7JwESXp/+e/Q0D/YsfsSz/RE+WLy6wFzbhTZSxP1GJjRXIKahEg49JHNvXbDNJsu9bZ2UaD3BqQJRIVnzO2VpBuH+HrrgpwspykPQ9qnXwVhzSpBJIqzKiKAwBroY7fgohc1E+QgynYl6aqFPE6F0J9T283YxVKZXmQB6Pdb2EhYvrZ+Hc+LYXiqJB810iByoxHNAUXrh/UY2FeF+twqBAIEPIkAMe4SzUOzPqHldJ7VkZRVlzZWIXjWvbhvOF1jIfzj+YcVMOanVkM0MI3jQqc7d0UP0Zr9TJRe5iTyUwahEcnnmNxfI8oKRT2AYevLQPIeFBL/JqUAZF4kX1gRs6zbgSb6kVvU16+cbWlSSOXhgNfEC9B8JQhPfeErfzEs1od+5qGjf4fopH8RzuAMCjIPuC3d36pJTq6y2mKkOJ63WKaaxcPxQ+UyWoaUOq50Rv2VlCrTK2DOliY0iYT6HS2eTtNx7GPnCFONV6z4P3t7i3RvgjGtETdRvcAB8ojlLlW0BSpRNje1aUZzmF8RQ3MdxC0dIjuzwYbxOPI5wOQi8wvWLV99R1grQSt+MvEVw3x9rzVZvZTzASP9qvzjDq+8d8xKhkMM7QuDKJk9D9yte9pfU+TiDlt8ipW9pAEpH9L0wIST5BxOGBbtjiMJlP++JxUQssCxmOWMi85Dlumx2A8oRzUtaS0KoEfHQWRTLZeMtLNya+b07yEjiYpwt9Nmbz7Fv+NWtMH9NYqKm+FWm/nNS5bW/8TnOM0IEEWDgCB9X7KmYRjoAf8aVWDpOEdVmhYXopyxyeTrIYSN8nvQhRlXhLv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(66476007)(8936002)(31696002)(66574015)(316002)(16576012)(66946007)(31686004)(6666004)(8676002)(83380400001)(38100700002)(2906002)(36756003)(508600001)(4326008)(956004)(2616005)(26005)(186003)(5660300002)(86362001)(53546011)(110136005)(966005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1FEeDNnQUcxU3laUDM5RFRiNkRtWnpnSWp1czV5Qlk5WEVQL09RQXVLZjBB?=
 =?utf-8?B?VUtSaklmc3p2d00ySzNJYlB3K0htVmN1NGJ6RThQU3dhR3R4aWZZakt5KzZ1?=
 =?utf-8?B?L2UxSExlM3o2RHR0QTdzdnd1U1paRElxMENIcUhZTkxlcVFjbHA0bnQ4Umsv?=
 =?utf-8?B?UXZQa0YwYjBJOGRUNjJSTG55bXpKbzlFTk1COGVvTkRUWk9vRnEzM1I0dG9s?=
 =?utf-8?B?ZldPYkFtL05xZGp4VFZSdEh4MmxVdUZ4NGoyWm15cUwwVDh3QkVhZExTUERX?=
 =?utf-8?B?NXVZSTQ3WitjWTlWRjNXSkxnamlCc3VwdWphNUtwd0M4YmpZZnhpTGRzcUFo?=
 =?utf-8?B?eTdRalBlcUwyVmVuaVpReUVWMzl2RXRGaVQ5d1g5c1FRaFR3YjBmeWoxYnJH?=
 =?utf-8?B?S1ErTld5Y291aThxV3cwNEVTcGpTTzMyOVQrZVU0VENxc1N3WnVVMEV6akli?=
 =?utf-8?B?cVBMNU9QZjlRYjIyL2I3VDVWeFo2TmVKb1o4OXBjRTFEeWlRSWxGRmloL2li?=
 =?utf-8?B?cnVhc0RlR2ZybnE1SE9qak5oQlJyRHRMdjNhM1d3M2xqczVsZmZtZE5kOVdI?=
 =?utf-8?B?c212UllPMXl0TFFyV1YzWTQrOXY2cHR4dC9QMWxhZVN6aTNrdGFVRTlSYXFG?=
 =?utf-8?B?b0VhN2RIUHIrMFhodkxEeVpqQUVOdkl3TUFTS2xCcTBqRHBXbHc5UnlsRVRI?=
 =?utf-8?B?emU2bWRJL3ErTG8wajRpR0p2bVgwVjNNVEwwajd3akNHd20xTitRbXZ2ZEMv?=
 =?utf-8?B?REY3OWpnbE1XN3lFUTEvbmdLck8wdkpONEdURzdUSUNCK0ZVV0pkSHRVZFB4?=
 =?utf-8?B?Yy9iWUlSaWhZQUl2MDQycHRHTWxDSVA5TGlzWC9QbURpeWI5WGZrSjhYQWtH?=
 =?utf-8?B?Z090K3Y3bmdFcysyNHdIUnQxQXJaYzN6UlBzdzhwUHA2NXFXZEYrRTJsaDRH?=
 =?utf-8?B?cWNjalh3emlMc29WTlRKMmFTVXYrUjB1M2dzOUtTTks5N2d1WFMvdDlmRzla?=
 =?utf-8?B?azljcHM5TVBTYUdma0djVWdlODZqcVBqcE5tdFFMQlpya2w4MDBDdlUxM1RT?=
 =?utf-8?B?cCsxaVJPcnh3UVFuYU1ETlBUTzhldTFTS1Z2a2ZFU09HYXJ6ZXViUnBWVFpj?=
 =?utf-8?B?Y1NJdXlvZ2g2emRjVHFwYkUxZXVFQnduZmZwc3J2VDdTeER5MXFLMmJaS0Np?=
 =?utf-8?B?dEFPeEdwcWF3K0pSMjZ3enhXMjZXZTZFc1FHMHczdU40S2ljdE5UVTZESERu?=
 =?utf-8?B?RmRKcFVhT3JZbC9aUUM5czRXSitGWitRU3NpN3JsS1ovVStVa2l4S2JyUzVG?=
 =?utf-8?B?Ukd4ejJhR2VoanlBeVJOWmp0UmVveEp4QUJJQ29ud21FWmFjZG9OYktCbU9H?=
 =?utf-8?B?ZkwwVUYwZFVjazFqbWVnVWlLNUhYUkZYTjl4QXVDSXhnYzNtTUIrM2EvR0JF?=
 =?utf-8?B?L2Rzc3NMNXZBQUFDd0NFaHYvRHFpYzlBSDFPU05hUktxQjlrUnUycytkeW9v?=
 =?utf-8?B?NUhINlYzbklrdzRMbkhzTHkvRHBtekFISVBBK1Vha25lb3lQUWdkNHEwSWRx?=
 =?utf-8?B?dkxWaUNOWURIOGJqaEY2MzZhMXZ0Zkk2aDRxaDRYN2NpdUhVUzNJOCt6UWNw?=
 =?utf-8?B?RUl2U1VUcmRBNExxMHRVNjVqaW9TVkJiSnlib2dUZjlOcTdpWFJiQWl0WlpV?=
 =?utf-8?B?S3drNXJSa0dGc3VNMG5NUUVBK1VUcURtb2p4bnB1d2JRMWdjNERLYi9GWHZj?=
 =?utf-8?B?OGJWMGdZRThacVNiVXZvek9BVDBKRnZiZ3BnSDhnS3JNU0Zsc3RCYlhyZjdl?=
 =?utf-8?B?WnJRN0RpWnBiTjRHandlV2dmbC96NWdrOTdzc3ZkUFhVV0F0UVNTRTBLeHZ4?=
 =?utf-8?B?WWVGSUxIV254S2FoanVKQjZSdjRCTFpwVFR5NkhvU2h6L3Z0YVBCMk1HWENh?=
 =?utf-8?B?KzhCY3MvZDBSQkt2SjFmZUdtZW5UdUhmNjlUSloxTXM0TU1UYmhiZTN0bzZZ?=
 =?utf-8?B?UDBJQmV6L0M5YmFHSStEcWpPc1NUYnFRYUJPdDVNcnkwUFIzb3R3bFdEOTVC?=
 =?utf-8?B?N2NJRUgxc3UyY0NnRVVGWVRpOHNxSDdaU0NaVlR1eFo4UUUrSHZvWVh2Qk9k?=
 =?utf-8?Q?JAbk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f759ca42-88ad-47a8-7060-08d9a2c5d85a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:41:27.5106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIs5NyPyM34YC2LgmCoSwCjMUNzRdLEdZhcfzL8/Fn8lUR1COw6tninwS+17DUR/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1435
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/8/2021 7:44 PM, Christian König wrote:
> Am 08.11.21 um 12:15 schrieb Borislav Petkov:
>> On Mon, Nov 08, 2021 at 09:51:03AM +0100, Paul Menzel wrote:
>>> Please elaborate the kind of issues.
>> It fails to reboot on Carrizo-based laptops.
> 
> That doesn't necessary sounds like a good idea to me then.
> 
> What exactly is going wrong here? And what is the rational that we must 
> fix this by avoiding updating the current state?
> 

Reboot will trigger a suspend of IPs. As part of UVD/VCE suspend, now 
there is an added logic to power gate the IP as part of suspend 
sequence. In case of UVD/VCE, power gating would have already happened 
as part of idle work execution.

In any case, power gating is done by SMU FW. The assumption here is - 
the logic to power gate IP could involve register programming. AFAIK, 
accessing some UVD/VCE regs during powergate state could cause a hang 
unless the anti-hang mechanism is not programmed. That means either FW 
or driver needs to track the state of IP before accessing those regs and 
in this case probably FW is assuming driver to be responsible. i.e., not 
to call power off again if it's already powered down.

Though that seems to be a bad assumption on part of FW, it is still a 
possibility. Haven't seen the actual FW code, it's a very old program.

Thanks,
Lijo

> See we usually assume that updating to the already set state is 
> unproblematic and that here sounds like just trying to mitigated some 
> issues instead of fixing the root cause.
> 
> Regards,
> Christian.
> 
>>
>> Whoever commits this, pls add
>>
>> Link: https://lore.kernel.org/r/YV81vidWQLWvATMM@zn.tnic
>>
>> so that it is clear what the whole story way.
>>
>> Thx.
>>
> 
