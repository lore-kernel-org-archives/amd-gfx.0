Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A01F107526D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 07:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2237810E8B8;
	Thu, 19 Mar 2026 07:38:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wsUeEMKR";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA37F10E8B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 07:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixgYj70jeTFrholK0Isn+jLculbYLw49SZRF/TLwKnnnKueQyuJ141R4vKUcOJ3CsRuWie0ptaMkNmpyxtlBQk8ZQhwWJZoLMMxn+aTFntEO0mFoUqLqE3KoXUoV9IJMQyQldOmsf8nhnVm0mvVYRdg5+2mnenxjNBa/TwRtVT9961s49SaGu2GS7uYni9IePMA4TycwNUPeO295EHkg6fgtrKc17geywKpVom7verAI7TfUiRrrlwsgJz19l4cawAyz00DjgKT94ChHrmK09wbgRQJbtewRRbC8ofRAiuB9nGCB4z8ekbUFJzlUVMs+VG0ExExfr/2HkvKyDe/GtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJNxi4vWqnWLX5elrFXSBCzI/zF0yur3XzOQqcDZkM0=;
 b=UpOyfT1oalE0tZXADORMBDdOuJ/egssr34VIRfxChMsGvZ1KP4v31QBwiOTvQCvY0ZAn4+dA6hq1z/ElvMdQWYI9J3vVghnSbkiVDg/FUr0FhHevccvFa2Cp3mTICZ4uR0YmzPB1OUzfOicIiBT9W5kB0CMWEl0ZzEehjF/WNefZDJNLdd78fQWhqkiQG+TRf8G9iy7kdWqQbkirlZDnexOF926Zq20MqNtYY4wZKtZRXRlqGWTzOtVewd1oZcASwocGnF+z3UVoAADJPEOzMs9M4hytgOM4sStvA53B2rEM0cyQYxskLXoqaMPxBidhcu6pD8BUmtg9JUNMUWg6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJNxi4vWqnWLX5elrFXSBCzI/zF0yur3XzOQqcDZkM0=;
 b=wsUeEMKRUGF9FMlkG84WvG811vlPU5+aHh/PmlRLhd5+WTnpAxcT3kcawsbjJfFYJh7n/uhYt8GBq52UeUf4iRP9jGKDm+cmlzm5ZBqKyMbTmJkDiM786LuEd4dpTUr8iBR0fmPrwM6cZave+UgZsxlGuT5RO6t+6A5nt84Tf5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 07:38:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 07:38:04 +0000
Message-ID: <69f6c193-b0b0-4e67-8bb0-d34b9a3b34fd@amd.com>
Date: Thu, 19 Mar 2026 08:38:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Avoid NULL dereference in discovery
 topology coredump path v3
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
References: <20260318103059.1976682-1-srinivasan.shanmugam@amd.com>
 <edc9d882-76f3-4d1a-a9a5-698752984716@amd.com>
 <IA0PR12MB8208A7A18B8626B723B2D5FD904EA@IA0PR12MB8208.namprd12.prod.outlook.com>
 <01fbbf0b-72ba-4df9-a3cc-d0bce429a5be@amd.com>
 <IA0PR12MB82083457A40B3AAD336605A6904FA@IA0PR12MB8208.namprd12.prod.outlook.com>
 <SJ0PR12MB708298F39630A4EA6264DB36974FA@SJ0PR12MB7082.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SJ0PR12MB708298F39630A4EA6264DB36974FA@SJ0PR12MB7082.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: e52bdbd8-c61a-4aa2-b379-08de858a74f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info: dMTBSGwSCHx0gF0jB+2pmzwEByP2aawmmOsGrbp9uxCAjBbooeVKK4LIfIc/Dq/O/gYVinuZ1nqTZoOPr2wmhDzPxv93fT4szx2HrYdWBvCLNoQQYdRKAWYbAP3kSDN2UzOgrcjAantrR4voqtRc/MaUzXCo+1qIg8b8OekSULn8Xucqa/fZKqWukb0eKYqBsr0IaIKRY5thCA9EOUjcyaVJBUX5opAG9Gq3MFty9hnyM08Rz95yqPYeuhwCFAdGqZAszB64DUM4ei/bKV/T725tMbyDNiGoK65cpD0EAXEKksJa9udqihvFOujUDr4wlf6Xjj5Jdcu825MU68IdD0TekEUbFHHeTOShEi0DXZA/Bnmab2PG24l7AXTfvzoIsUAdbLIdGQAIGqXyzflwN4Q3/PlAVGqPfT7bt5PmupBpkuJbeQf2+6QOwIEszSwceW8UXTR/a0VSbWzj3cIr1yHePEOW/LgtMkMLmaArGsWAkhqIJ3N4Ujl6Kx0Du44KIOfyRXUbmRFGdwLl+1bEyqRaOkbuaInZWG64J2ZCltk6Vc9p8/6dFio2qYvOSUcFuGsf7xY0gdkqTJdYUq1vzohuTN5oJehNU9xRFq4U9SD/jb0fHiL9sUriy2vet6N4jaoyaz0lyl/LPm4hAP+zMKp14Dv5xHTAjfRGTasq+8faCjIJeD9gEstti+3M+rigBq2+Lyx/SEtPK3y62eDCeXV7hZ+tVskUoBHoSbrNkKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWo2ZE9ReFFYQktmOXFJNEFwdEU4VkluNlV2NnhqbTJNcENzZ2FJeURZZjlT?=
 =?utf-8?B?NkVlVmxlcC85YkcxdEU1cUpmOGtjR1FIbEx1dmZjTmxLeUlmUHkxbEtKSDVE?=
 =?utf-8?B?cHNCeGdWa3hKNHB1Q09FS0czNzNJODBwV2o1VTVwL29yblZQRE4yZ1VVYVA4?=
 =?utf-8?B?M0RHSHFqeWhzVDR2Z0ljQmdlRW5aVzJYWko4Ulp4MSt1SWFHN1I2NW1YakpB?=
 =?utf-8?B?bStIR1h3QlFVejlSODV4RTIwZkZ6TE9pQ09MMFF3V1QyeUNOUXdvWW9iRDdR?=
 =?utf-8?B?cXk5R2tSdUdENkxrMkx0VXQ5L0MxYk1mMEZabG4yUkRQM0ZMTkh1KzAyaFpV?=
 =?utf-8?B?TVU2WHlUZXZjcXZlNjA3VHFhSUZpMngwNUFXWFVVL2NRV1laUUxIdkgvVnlD?=
 =?utf-8?B?UEl1Vkw0eTF0Umlzb2J2RGwyNis0c3ZQVFJ0Z2xHekRTcXUvT3pITlRUU2Qr?=
 =?utf-8?B?ZmJEdGJNTFZ0ZGhKMU1vR1hFZlBVMkFjUDg0L3ptMUJUdkxvdDYzdnFoTFE3?=
 =?utf-8?B?aXh1SXRHRHFSVHJhc3kyeUNLSGYxYjJUa2JCZ0VrWXFDaTJ5TER4bmdDQk5G?=
 =?utf-8?B?bVdUVDdUU1NVV2VtRW5ZcVN0blgzcE53Wjloejh1NE5kMGZZVlEvY1RXV3JE?=
 =?utf-8?B?STNkbEhBNVl5akpNMm5idHFta3lGd000VjQ0TW52SEtBMFdod3kvNWt5eHN5?=
 =?utf-8?B?bjRIbkhyZHFWS3liZE5RcW95R0piTXdQTFU0TnQvWVVhT3pTL1ZjSGhtNkVl?=
 =?utf-8?B?TkMwblAvSkViZkt3R0ZCZWVYZEx5aUhaaWlsR1dFckdMQ0VTUGVsQzBlRFhN?=
 =?utf-8?B?a1lQQ0pTalF3T3kyMGhBVGNPdzMvaStQWHpZT2RWaFhBZFpjUDVzejR1dDl2?=
 =?utf-8?B?TndDRWQzWmVCOVJEc0VveDQydDAzR3M5cjl5R2pVa1J5NFVVdXNmVnR2Yk0z?=
 =?utf-8?B?cHF4bWFUNVByaXhxQmRMbVZxU1N6eUJ3dktYMTU3YlhQZHpqMlVFNktCckR3?=
 =?utf-8?B?MHUvaDBkNXl6OUtuZU56dGZ3OXB0L2xCY0dHUjEyNFJCUVkyR01OTENmZEN1?=
 =?utf-8?B?dUkrbXQ3K0kyeHZKQW5kWmJJWlJwZEFhUEtwME5naUpBRnRTOWhzZVFOYk82?=
 =?utf-8?B?QmVMbjhlbWoxOGJSOXFWL0FTMnV2STNFR21tYzQvWWR1c1Y4RWY2NWtBZGVR?=
 =?utf-8?B?bjEwaE1aOG1keVI4b1p3aEZTNHVZbCtvTFJBa0l5K0FiVUpGeGF6Z3dZeGE1?=
 =?utf-8?B?M2tuaEdtRWIwVjBLd05oTUY4T2tDSFI0ZERRV21oOHl5aXFoZktPL3IzbzMx?=
 =?utf-8?B?eEt5dWZGdmNWamtsdzA4LzMxblJWUVJrTW5jU3hpTEFBYXFqSnVuVUxpYmdC?=
 =?utf-8?B?amM1Z2JKVWs2cXROelIyanh4UEttYmVwZTRqV2E5NndjcGoxYXg2NmQzVXBK?=
 =?utf-8?B?QUcySDRuN1NObmdCM0ZPMUNiMCtYL2dHSm4vdVpNQitPaTlYa2dORjU5T1ZU?=
 =?utf-8?B?amoxZ2ZYaFJaaXFWMlB2REo0MXdndS9Bb2M2WHJObi9VL3BLRVNWZFRPUlVs?=
 =?utf-8?B?TS9QV3hxU3JlOWVtcTZuZVA4ODhYK2FjeS90V29zOVVLbzJqanh2dDRidVov?=
 =?utf-8?B?d3h1cFliQVBURHJJYjdoeE1XbUlpa1BPZmRmYlRkaWM3ODJKbE91N1pjK21V?=
 =?utf-8?B?M3JEZ1AxdlpnZEM0U3YxTEUyMHhySFB6VVU0UmF3dFE1Z2pQTE9VdXpvZE9Q?=
 =?utf-8?B?VnNnVDlMR0dld0RKMFFsd0VlTHhxbTREbnRXRWEvSWl1TmVvZkhUUGo2aGp3?=
 =?utf-8?B?Ymk5UWM4YUNBQ1diWGtZQkNQOWRrbE9COWpXZ2szQW15MTJTWU9XVWZXYkxK?=
 =?utf-8?B?cmNWWmFBYzZLdnBDQjl3RVJaM2puWnMzMG5wSXlQYlVHdUVZRXR3SlpPd2cv?=
 =?utf-8?B?NjJGdFd5b1RuLzdUQVlqSUwxQW9aRWJRRFRSMll0K3NOM2k3b09XSnR6dGpw?=
 =?utf-8?B?aGNRekdJbmFPTmpFczM5ZTJUNmYyUHVFWU5OMnArVWhZVG1CeHNPcWptWTho?=
 =?utf-8?B?dUZjSTMxK0pIemdlVlVXRnBkbzZJL3VTVzUyRVlVVzdkb0tFUlFFeTdackFr?=
 =?utf-8?B?YkpHNVFqejllQkttZTR3U2pubEJRZFNPbG4xOUx1ODc2TGF5QXk3UGFsK2kv?=
 =?utf-8?B?OXl0aTFreG9WcVR0L2U3ajk4dDB3ZmVwQjlMQUV3amxNbkQyaUpOVURWU0Ra?=
 =?utf-8?B?c3FOQ1lIL3R2Y0k0Y21SNjVPRDAwaUxZdmdDamlRZEgwd3VlYVNScTJjWml4?=
 =?utf-8?Q?hz4F3PqgJsaMSxKE/t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52bdbd8-c61a-4aa2-b379-08de858a74f9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 07:38:04.9138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1K/g0LHJkEy/LvBb6EkIMSxGYPJ1m8Jx61kqhDj7YuBiivlVyr3PpRYdpiqSju+g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
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

I kind of agree with Lijo.

We clearly should have a NULL pointer check, but when the information isn't=
 available it's perfectly fine to not print the section for it. That's what=
 we do when other information isn't available as well.

So just completely skipping the "drm_printf(p, "\nHW IP Discovery\n");" wou=
ld work for me as well.

Regards,
Christian.

On 3/19/26 06:00, Lazar, Lijo wrote:
> [Public]
>=20
>=20
> To run coredump logic, driver needs to be loaded first. For driver load t=
o work on all new SOCs, it needs discovery.=C2=A0
>=20
> Other SOCs which depend on pci id mechanism don't need discovery and they=
 don't have discovery section either.
>=20
> Thanks,
> Lijo
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------
> *From:* SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> *Sent:* Thursday, March 19, 2026 10:17:09 AM
> *To:* Lazar, Lijo <Lijo.Lazar@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Pell=
oux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>
> *Subject:* RE: [PATCH v3] drm/amdgpu: Avoid NULL dereference in discovery=
 topology coredump path v3
> =C2=A0
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, March 19, 2026 9:46 AM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Pelloux-Prayer, Pierre-Eric <Pierre-
>> eric.Pelloux-prayer@amd.com>
>> Subject: Re: [PATCH v3] drm/amdgpu: Avoid NULL dereference in discovery
>> topology coredump path v3
>>
>>
>>
>> On 18-Mar-26 4:41 PM, SHANMUGAM, SRINIVASAN wrote:
>> > [AMD Official Use Only - AMD Internal Distribution Only]
>> >
>> >> -----Original Message-----
>> >> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> >> Sent: Wednesday, March 18, 2026 4:28 PM
>> >> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Koenig,
>> >> Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> >> <Alexander.Deucher@amd.com>
>> >> Cc: amd-gfx@lists.freedesktop.org; Pelloux-Prayer, Pierre-Eric
>> >> <Pierre- eric.Pelloux-prayer@amd.com>
>> >> Subject: Re: [PATCH v3] drm/amdgpu: Avoid NULL dereference in
>> >> discovery topology coredump path v3
>> >>
>> >>
>> >>
>> >> On 18-Mar-26 4:00 PM, Srinivasan Shanmugam wrote:
>> >>> When a GPU fault or timeout happens, the driver creates a
>> >>> devcoredump to collect debug information.
>> >>>
>> >>> During this, amdgpu_devcoredump_format() calls
>> >>> amdgpu_discovery_dump() to print IP discovery data.
>> >>>
>> >>> amdgpu_discovery_dump() uses:
>> >>>=C2=A0=C2=A0=C2=A0=C2=A0 adev->discovery.ip_top
>> >>>
>> >>> and then accesses:
>> >>>=C2=A0=C2=A0=C2=A0=C2=A0 ip_top->die_kset
>> >>>
>> >>> amdgpu_discovery_dump() uses adev->discovery.ip_top. However, ip_top
>> >>> may be NULL if the discovery topology was never initialized.
>> >>>
>> >>> The current code does not check for this before using ip_top. As a
>> >>> result, when ip_top is NULL, the coredump worker crashes while
>> >>> taking the spinlock for ip_top->die_kset.
>> >>>
>> >>> Fix this by checking for a missing ip_top before walking the
>> >>> discovery topology. If it is unavailable, print a short message in
>> >>> the dump and return safely.
>> >>>
>> >>> - If ip_top is NULL, print a message and skip the dump
>> >>> - Also add the same check in the cleanup path
>> >>>
>> >>> This makes the coredump and cleanup paths safe even when the
>> >>> discovery topology is not available.
>> >>>
>> >>> KASAN trace:
>> >>> [=C2=A0 522.228252] [IGT] amd_deadlock: starting subtest
>> >>> amdgpu-deadlock-sdma [=C2=A0 522.240681] [IGT] amd_deadlock: startin=
g
>> >>> dynamic subtest amdgpu-deadlock-sdma
>> >>>
>> >>> ...
>> >>>
>> >>> [=C2=A0 522.952317] Write of size 4 at addr 0000000000000050 by task
>> >>> kworker/u129:5/5434 [=C2=A0 522.937526] BUG: KASAN: null-ptr-deref i=
n
>> >>> _raw_spin_lock+0x66/0xc0 [=C2=A0 522.967659] Workqueue: events_unbou=
nd
>> >>> amdgpu_devcoredump_deferred_work [amdgpu]
>> >>>
>> >>> ...
>> >>>
>> >>> [=C2=A0 522.969445] Call Trace:
>> >>> [=C2=A0 522.969508]=C2=A0 _raw_spin_lock+0x66/0xc0 [=C2=A0 522.96951=
8]=C2=A0 ?
>> >>> __pfx__raw_spin_lock+0x10/0x10 [=C2=A0 522.969534]
>> >>> amdgpu_discovery_dump+0x61/0x530 [amdgpu] [=C2=A0 522.971346]=C2=A0 =
?
>> >>> pick_next_task_fair+0x3f6/0x1c60 [=C2=A0 522.971363]
>> >>> amdgpu_devcoredump_format+0x84f/0x26f0 [amdgpu] [=C2=A0 522.973188]=
=C2=A0 ?
>> >>> __pfx_amdgpu_devcoredump_format+0x10/0x10 [amdgpu] [=C2=A0 522.97501=
2]=C2=A0 ?
>> >>> psi_task_switch+0x2b5/0x9b0 [=C2=A0 522.975027]=C2=A0 ?
>> >>> __pfx___drm_printfn_coredump+0x10/0x10 [drm] [=C2=A0 522.975198]=C2=
=A0 ?
>> >>> __pfx___drm_puts_coredump+0x10/0x10 [drm] [=C2=A0 522.975366]=C2=A0 =
?
>> >>> __schedule+0x113c/0x38d0 [=C2=A0 522.975381]
>> >>> amdgpu_devcoredump_deferred_work+0x4c/0x1f0 [amdgpu]
>> >>>
>> >>> v2: Updated commit message - Clarified that ip_top is not freed, it =
can
>> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 just be NULL if discovery was no=
t initialized.
>> >>> (Christian/Lijo)
>> >>>
>> >>> v3: Removed the extra drm_warn() for sysfs init failure as sysfs alr=
eady
>> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reports errors. (Christian)
>> >>>
>> >>> Fixes: 7083eb8982fb ("drm/amdgpu: include ip discovery data in
>> >>> devcoredump")
>> >>> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> >>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
>> >>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> >>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> >>> ---
>> >>>=C2=A0=C2=A0=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 11=
 ++++++++++-
>> >>>=C2=A0=C2=A0=C2=A0 1 file changed, 10 insertions(+), 1 deletion(-)
>> >>>
>> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> >>> index f7f37d93d0ce..6be1f971a31a 100644
>> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> >>> @@ -1395,6 +1395,9 @@ static void amdgpu_discovery_sysfs_fini(struct
>> >> amdgpu_device *adev)
>> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head *el, *tmp;
>> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kset *die_kset;
>> >>>
>> >>> +=C2=A0=C2=A0 if (!ip_top)
>> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
;
>> >>> +
>> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 die_kset =3D &ip_top->die_kset;
>> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&die_kset->list_lock);
>> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_prev_safe(el, tmp, &die_=
kset->list) { @@ -1419,9
>> >>> +1422,15 @@ void amdgpu_discovery_dump(struct amdgpu_device *adev,
>> >> struct drm_printer *p)
>> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ip_hw_instance *ip_inst;
>> >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i =3D 0, j;
>> >>>
>> >>> +=C2=A0=C2=A0 drm_printf(p, "\nHW IP Discovery\n");
>> >>> +
>> >>> +=C2=A0=C2=A0 if (!ip_top) {
>> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm_pr=
intf(p, "ip discovery topology unavailable\n");
>> >>
>> >> Is this type of printing really required or just skipping the whole
>> >> section good enough?
>> >
>> >
>> > Silently skipping the rest may look like incomplete or missing data in
>> > the coredump.
>> >
>> > Adding a one-line message makes it clear that the topology was not
>> > available, rather than leaving an empty section.
>> >
>>
>> Here is my take - Discovery is the basic requirement for SOCs which make=
 use of
>> that mechanism and it is always expected to be present for those, otherw=
ise driver
>> load will fail.
>>
>> For those which don't make use of discovery, the section will not be pre=
sent. There
>> is no special message required for that. There is no harm to keep that, =
it only adds
>> extra parsing.
>=20
> It's ok for normal cases. However, this runs in the *coredump/debug path
> during error conditions* - where the discovery topology may not be
> initialized. instead of leaving the section empty, which can be confusing
> during debugging.
>=20
> Best,
> Srini
>=20

