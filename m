Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D38DC47077
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 18:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0173D10E060;
	Thu, 11 Jan 2024 18:23:05 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D130710E060
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 18:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdPsZKDJ1dmtT9u8tbeff7MkwFaaxbZAoyIqK7jHoHxGy9sOawhDiT4nde0CzRpdwbvzB15R/2E7mStYTvcUATJZdSrG5QhGuIlHkzHO5MsaViE3LPqiD/JQkQo3Ki0/h8UuJQWEiK9uRGVWI9wzIiqflaD8pVCwq68UtwSeyDd2rw2tiX87Yk6FIHGKiZuVFhhOUkGAx/Ltm9A2LctQEJQAsrx3BHrc0skN8QFEqZgFgCehEZccHB27vr5pa4ws5dBO1HRzrBTAneSFBz1iiGazPBJOteqxW4JI4LG0QOu/xUsY5hxL9CaHD+aV/X4gvoeJSBGLhL6mdhNOuAHuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1/26qKdgv8OfB6AL/trLfJMI+Y1uNdP7ljLSKgHqZw=;
 b=UF22A9FVnKGPDvnalW3I8Ha4jh5t7DOv4uscfeYGw1Xi2qj4Ux1AAsdQUUmaRDKpq4PzRTNMoeXp2luaMTsUI70ptaty/J+L3ThyrUjkVZ5TX4vVksPXXOk7hnrOUlzPMJbRMY4eYB1p7UwrJRHQBA7DpjHuHMP1AaOGpbDLyYx3PkLT2gBbewde6xWexWXR7hSsEkj+YnxxwNC1MFX1N1SfEy7D6q4C2255aVaIXYafFzHiTmKoNXLiuOUmABEMQL2QemsjmEyRdQpu7KrZYmJ5YgCIe26V18MwfzX4pMKzxHo/SbUVe0uciklGmoQ+5LYIP++EIU8fC8vlioEWsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1/26qKdgv8OfB6AL/trLfJMI+Y1uNdP7ljLSKgHqZw=;
 b=Q7AnTvgjV7KMFq7UJD+7u9vyHhbg3wuX63vQwNijH7t/FVrQc8GfGtduvjehdbmqevLa3q/vihHdlRBxhIYdse6ALoYGvey+V16aCuQZdcqOKMgbeNv9fdD3X83K7VIPyPpHXAFTgwrlt+gGLmRbdSDjGyV6GaC2uCydlqiyVK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4599.namprd12.prod.outlook.com (2603:10b6:a03:107::22)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.27; Thu, 11 Jan
 2024 18:23:01 +0000
Received: from BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::eab2:927a:4a27:29a5]) by BYAPR12MB4599.namprd12.prod.outlook.com
 ([fe80::eab2:927a:4a27:29a5%6]) with mapi id 15.20.7159.020; Thu, 11 Jan 2024
 18:23:01 +0000
Message-ID: <d4b15035-f3e3-7e49-21ad-2324ff32fc4f@amd.com>
Date: Thu, 11 Jan 2024 12:22:58 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amdkfd: Fix the shift-out-of-bounds warning
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Ma, Jun" <Jun.Ma2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240110093938.684930-1-Jun.Ma2@amd.com>
 <7fde053e-b120-4d80-82cf-0a104ed5653f@amd.com>
 <99264b52-4e47-4a2f-a930-a87feef3ac85@amd.com>
 <a172267c-55b1-4abc-935d-fbc9f3a3838b@amd.com>
 <CY8PR12MB74355DC4D9A386D93023EB4E85682@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <CY8PR12MB74355DC4D9A386D93023EB4E85682@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0116.namprd05.prod.outlook.com
 (2603:10b6:803:42::33) To BYAPR12MB4599.namprd12.prod.outlook.com
 (2603:10b6:a03:107::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4599:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: efa6cba6-0901-4341-5ddd-08dc12d25834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oOJOVktsiNSYxNd4lvLWXD964Sn7wpDt5Nz2BMwI8JInXZ9x5NS/SHMf84aDDeRN348T9pzfftb+QiI/NJL0QfGDuiyxOqLjMEMn9kCXAdRRJcb8mhnAPPJ/QB3B3+6AjlakJJmlwBH3tO7AOpFNCKgq28seCJ0GciNV9gqXa5YYiR7udbOfPiZrMkmjZUU3CywlgYxSqQpp5nckFmHjXy87+80zOE/Z+/kDCcs0DMlOgc3Q8ym7w6DscJMZxfl8C86+wfYL7v00r4T4WM0xliosI7aGcoiEGlF/C5WVUjFkaEV533Ia3QsoSGKA7Fkd+2ZMCNSSmzrIC0QNa2euoWyfEEP20YblpBQiVIn8Ch2C9HzhaxSA9pk/R2hKDIANvjb6i0/0jtZRdxAmoJmrSHrwysbaEc+bn0VtxOHEedQRVufvjm6P72G4oVoOXTmDDKoRsqqdb5kiSzrF7MDvfIL/WArLlDJXGl8+QJ1Y6W/XaYBC+57YpJZZtHgpZkKUDhPCyuJpU+X/VkMRTwviC0iwli+rLcbbLsV5uAdDQowAOSpqpLtQG8064FT0uYmlFVefFG9jPJp0p4Zdfl8D0lw1t8a+3svOHLt16ts6+M7OKhF7NQl9exyNIzCsxrNrXr+MPJIWXxjamsItVZ8GnEDQBQdAZonnFb5SPdRgAl/psl3T4ERQwKO5zB1cQUEi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(136003)(39860400002)(376002)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(31686004)(6666004)(6506007)(53546011)(6512007)(2616005)(26005)(478600001)(38100700002)(31696002)(86362001)(36756003)(41300700001)(44832011)(5660300002)(83380400001)(110136005)(66476007)(8676002)(66946007)(316002)(6486002)(66556008)(8936002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXFMa1dBSlZGaXp2MDdXRTFhc1RHbEpxLzk3NGJldUlWRkFzN2ZQMGx1aWY0?=
 =?utf-8?B?NGtYV3UxaHROa0ZNY1haaHBoQ3hOT2FTSHZPVlp6bG9lS21BNG5YYXRod21O?=
 =?utf-8?B?YnhvL1NQK2E2UnJUVTBvOHMvbGFDY0JYNkxwTHJubVZxVzZrREhwMkRDMW0v?=
 =?utf-8?B?KzJsU2t5RWFvOXVpTEtibk9WZ3pRcXFPdFBDNFBLOGdGZjVYMitDd3d2aWxM?=
 =?utf-8?B?ejNtbWFKTVAwQ2NNUnQ5WUVPOHFZdjM0MHdYSlE4QzRXZHd5SGVpakxQL1hm?=
 =?utf-8?B?V1dDOXpWWnhrUTBoQnlxcFRvQUdwS0FSZWV5dExNWWlRRlNod3lBb2lyLzUx?=
 =?utf-8?B?Wk4valRsM2dEVXYyNjBSWm00OEtMSW5PTC94ZGJ5aFJ2dHhiV2IrZXlkeVFz?=
 =?utf-8?B?WE0wODhqRGtCazNWYVBOVG90OGx4OWdsdUM4WEFxRU15MXpRNXhGVUpWRGFu?=
 =?utf-8?B?cHRkSk5aYzJDSmRzaWtPUEUrNGdrUFJjMERVczM5cSs2K3MwZzRhaDlPQXdM?=
 =?utf-8?B?MmxnYnRxRTZ2azJQdXBRd1dLQWk1b0lxRVZzY0FJS003eW1UUU5UZnFZUEcy?=
 =?utf-8?B?MmdvdEZzSFYybGpXWDFOZ3M5cUR5VytQV0ZBTUgwNjFNN293UXBpK2VqdHl5?=
 =?utf-8?B?Y1ZscWFtaFVKVW5Na2duWHBocEhCTVhweGQ3OTdIK0VVdHV2alh6YmdWQmwr?=
 =?utf-8?B?Zmoyd0NXVjVNZXcxYUdOL01SRWdiTTZLSFkxSC9GNWVrdzZWaldLUlp0aFZ0?=
 =?utf-8?B?aW5GeDNhOXhwakRCRThFcSs5dVVrVUZwWVp1eWxJUkorM0RaVXhudjBPWDZO?=
 =?utf-8?B?S2pEZTFOd3QycndWT3A0eG1USi82bjVaTlAyTzBZT1BuNTl3VTZVa0RDdGpi?=
 =?utf-8?B?TytHRGtPeEFqQWhHRXdpUzhBZTdINnFObEN6bzBoUFlCYVZTK1ZMZUYyQmZL?=
 =?utf-8?B?eG45NDBqeWVtZWZZM3kyaFhYWmRSQ2lmdjlYR2NRb3lhYWRwV2tZc3dTZHVB?=
 =?utf-8?B?UjcxaEZ0bE5BU2N4akMzMjhua0NXTW1XRUUvc0tpQmFTb0dWaVhUZ1R0UUpy?=
 =?utf-8?B?ME13a1M1anV5QlM2LzhueTgrVktUNkNvR1EwVFUvc0pXN0taeTQwcGFMYTVi?=
 =?utf-8?B?eUFteHhud3QvZ3B3WFRndTNQalFkeUdwUStoWFFibW9ValM2T2Z1U3kzdlpL?=
 =?utf-8?B?S2FCTFVreXgzcmt6VFpFUkxmd2tKMnN3YXl5Z2tBa0U1T2pWdXhiK0VJa0Q3?=
 =?utf-8?B?ZCtCSFBKbmJySklRMFZpWUZzbHdpdy9mdFZMWXFWc0doaVhCQ3RHMkh5OHJP?=
 =?utf-8?B?OWJWKzJKYUgrc2dRQ0NYb3Z0N200Rm9yeFh4QjM4UHBGSElPZVorTmFQT2N3?=
 =?utf-8?B?dk9ydVNJVm1vbnIydEVxaHpNZ0pFRkc1aWJBMVNxZElVOWdJRk5PM2E1RnRh?=
 =?utf-8?B?SlRkckphc2RMbG91YmI0c3hYTzB5WUZaVDRibHNWSVh0Z3ZoL09NU1pwZGJZ?=
 =?utf-8?B?bzJZSU5jcWVnN3dQazJqWEp4bzJUN0pBOUx4RkI2eTVDTWRVbHNZMTA5aUVX?=
 =?utf-8?B?VGlQTjNBakdqVnMxWEJaZlJHNy9LRWtHcVJpTWJuSmJ5WGV1TTRyUzFLUDZC?=
 =?utf-8?B?Y0dBQjFsVnp3Ti9KUk1tdlN6Z2doZW5iSDVHeUJDSGxQci9tWG1nQ1FsdTA5?=
 =?utf-8?B?aHdxait4b3dDZXhzNjRBUi9ua3htcENSemg3cWxjcktxWFdIa1pGckkyRWtK?=
 =?utf-8?B?SWxaL0V0WWFXNmZybDhZRzJ2VVBab0F2UFZLeEdQT0VkQTB3SHJLc0xmZzZw?=
 =?utf-8?B?VG5OeDgvOHFVZk42dGFpbGJpTjM1eEMzZ3FqWTBPcmwrSEUycEVCamVBc09k?=
 =?utf-8?B?eXlyNzQvQnRHeFE2MW9GZUd4T2RlTkhocEJkMzVQRDNhTlkyeU1Td2RyVExI?=
 =?utf-8?B?OUkvTFFwZlU2cndidVNHejg3bXdjdGdmVlQxUTR5K0RjVXl5UmRxYmVrSngv?=
 =?utf-8?B?eHBicWpyUFNlMmJCanNvc3Y2c3g5Q0F2MmpXQjk4TEh0YkNMN3BIRlQ4UEc3?=
 =?utf-8?B?YlZiMDhnU0VpcWc1OFhjY2tpbHpuUEtodkFNVWVJYVdPUGxpUWcxbm9iTjdU?=
 =?utf-8?Q?iTibu8FETyL2WoIgs4sAxvyHc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa6cba6-0901-4341-5ddd-08dc12d25834
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 18:23:01.4085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8YP1SYMGdJTWMX05FHdb79QZOL6vnAjcObnTaHKdiBYIG0wQ9ngQf1r/gFfcoGRgONrGeuJ0t4KYbTbt6yJhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532
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

On 1/11/2024 11:25, Kim, Jonathan wrote:

>> This looks OK. The compiler must be warning about a potential problem
>> here, not a definite one.
>>
>> Question for Jon, how does the firmware encode the error code in the
>> context ID? I see these macros:
>>
>> #define KFD_DEBUG_CP_BAD_OP_ECODE_MASK          0x3fffc00
>> #define KFD_DEBUG_CP_BAD_OP_ECODE_SHIFT         10
>> #define KFD_DEBUG_CP_BAD_OP_ECODE(ctxid0) (((ctxid0) &                  \
>>                                  KFD_DEBUG_CP_BAD_OP_ECODE_MASK)         \
>>                                  >> KFD_DEBUG_CP_BAD_OP_ECODE_SHIFT)
>>
>> It looks like we have 16 bits for the ECODE. That's enough to have a bit
>> mask. Do we really need KFD_EC_MASK to convert an error number into a
>> bitmask here?
> 
> Added Jay for confirmation.
> I could be wrong but IIRC (and I'm quite fuzzy on this ... probably should document this), unlike the wave trap code interrupt mask (bit mask) the CP bad op code is a single error code that directly points to one of the exception code enums that we defined in the user API header.
> If that's the case, the KFD_EC_MASK is convenient for the kfd debugger code to mask the payload to send to the debugger or runtime.
> If that's been wrong this whole time (i.e. the bad ops code is actually a bitwise mask of ecodes), then I'm not sure how we were able to get away with running the runtime negative tests for as long as we have and we'd need to recheck those tests.

That's right. Queue errors are serialized. The error code is recorded directly.

Wavefront errors may occur concurrently within a wavefront. Those are recorded as a bitmask.

>> In the code above, if ecode is 0, that would lead to calling
>> kfd_set_dbg_ev_from_interrupt with a event mask of 0. Not sure if that
>> even makes sense. Jon, so we need special handling of cases where the
>> error code is 0 or out of range, so we can warn about buggy firmware
>> rather than creating nonsensical events for the debugger?
> 
> That makes sense.  Again, deferring to Jay if a NULL cp bad op code is expected under any circumstances.
> Either way, raising undefined events to the debugger or runtime isn't useful so range checking to filter out non-encoded cp bad op interrupts would be needed.

On AQL queues this interrupt carries an error code beginning from 16.
