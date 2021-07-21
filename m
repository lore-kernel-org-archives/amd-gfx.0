Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5642DC12002
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 03:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149F160FDB
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 03:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149F160FDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9731C6E8DF;
	Wed, 21 Jul 2021 03:15:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE8726E8DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 03:15:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDI4zxbuHQdyN9hq7blppknkTunXq2GmVLTuptxF9du+L4SEe1LOPEZJr4OoGGe4oJw61DA7YBPFPwjn0Lsxa8mmlKxlG1M7/b5+ui9S6y22+QWSnai6UgAXboFC4KmkyogQzjPWKebRQ0eIHg6RnMmDAbSdP7aW6GVPROgD/Zy3bt0lOuexmVRvV9JmNzRBVb+jP4tGDBC47gAKIRhBzzdJL6FDEZwmZ3gg4ZD4avlzDqtUYynXUHSpoN2peopO2+E5NJKe7dJw9qq65ZXKCj2k9SNzgUpBIXC/48qzA29WZAJc80g9mY5IPAL5iFy9W4Ao/RIk21tEqgm1OHDcTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URcVmQhF73panjnJ06pVzzq2RcOhlLLxZ5/an2NoopY=;
 b=bslq2SIAioFRzxATm6FsMuazoM1gjbIoJDIhd9CQ8WjINZIl1tD/uJY2NDEHkfSoLkrI9LlqUjNL/28rCVtRhkFqvjpvyLBtUbICMyKdyFxwmeyOy0U9m270g5b5wjUeN4KTeh/A04+zRaiYsx96hakFkZJTBa95NMxidpHD0uWAqU2LmKToW4vu8Q/VdcYWI4XfEpyfsVXSObkudZXwRIfK3LkuG4j7VPlMLhxnEQzySsthh65dfxAYt0/zi2O1HtMgeKhdbFQ4gduxL28/u3revKqzK0DExXV07Fba/RchCO7Ct2H+MKoRvnBeNfiCnFbPUvAepa5hyLaJCdIM6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URcVmQhF73panjnJ06pVzzq2RcOhlLLxZ5/an2NoopY=;
 b=O+n1QeHOd3VHZzkkROO6Y4VsqrJh8Tv6og/O2fCvpUK4iGUq5FkL5eifrkm4MbcB/cszZzvB9zZlianKZEKmDpAj2OvFdeFrVurSmId4J57zSzIBzJuGk2OIQPmesSXEmvIIiukHqMyVgKZO9HyaRVR1ChTWc18tvpsrblhl07A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Wed, 21 Jul
 2021 03:15:02 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::c05f:7a93:601b:9861%7]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 03:15:02 +0000
Subject: Re: [PATCH 1/2] drm/amd/pm: Add information about SMU11 firmware
 version
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210720161808.18690-1-mario.limonciello@amd.com>
 <BYAPR12MB323804F0C5D873A19E7BC36CFBE39@BYAPR12MB3238.namprd12.prod.outlook.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <dc659492-3fe0-29f5-0153-8fcff7af3774@amd.com>
Date: Tue, 20 Jul 2021 22:15:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <BYAPR12MB323804F0C5D873A19E7BC36CFBE39@BYAPR12MB3238.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: SN1PR12CA0055.namprd12.prod.outlook.com
 (2603:10b6:802:20::26) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2600:1700:70:f700:957:5838:bfa1:5c05]
 (2600:1700:70:f700:957:5838:bfa1:5c05) by
 SN1PR12CA0055.namprd12.prod.outlook.com (2603:10b6:802:20::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.22 via Frontend Transport; Wed, 21 Jul 2021 03:15:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b55e6d38-10a6-4928-fe94-08d94bf5ba8f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4509E1ED6F34F65367C794BDE2E39@SA0PR12MB4509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MI7I5hsybBxyyQu87hKtgpgkbjSDAJByBTCiiQ3eLIcPxaeqtA50X+XW8ZfUwBOLLW4ankqbU6NZ56xtZQsueiIeyVc4XNlwUGr4e9supJxE7BpC1Lo6I3g+vMia90eCwn56/5cXITGbIla7pKrOrJmXqx880LhgouwPTXZ0Ovq/xfRC/GC/If7h6+iiARBNExUQZOVlg/d0QQYAAu1HgZhWh9EnmmeDDB3tmBp6lPI3G9rphesPxRRxe6q9DuyctWg37FgYuE7cjjoAPdqHpzXg/Bo3+psQ6C/jdnKiTtLJC5fjx5C/2jAOlM4TLwjchN6hlwsq4a9QhnOEPsSOtz3QNDDs4UDgME1uWEEOXxCsMoyUtUw1EvRZYRMT+k46VXUUzenLF8xrO1CNxKFOHFzF9Rif290NoncYuL4sMCvyETA3/GvsGh/aLm2cPLrtAD/UQm+ADh8An4M3gkRTyDQKfa+yuG42Th7cwcT44Rk5uJzOGOqOk0WKukaVR9sf2l2hWYmAWGUTFszAQzaJnejIecN9k6yJJsFl1iQhNQx8F2w4s/QUgUN1/A5j580ZXhkN4OBk8GbG4+OjYhrmYbm1emcKpqg8qVRssfYACbPTokNwbhOdl0F08qnOzvK7HgVq92tdqOfefKzWSX1pwdaF+m0PX4tjcJlIl5U/GO5Jhp/zN5OVFV3UZW7P7+39w/ODXSddtK0GcecuI7Pm962TvEq+5uSkZ9plqPJKtrgSxwmV2rrcSoleR+lMbFtW8VcPx2mpW8G8B+luF5tm527sghdd5g9EzmfDnWRn+E4kwpD5SoMKwQJG4S9pwW6Z//XxHXGpoclQuY2bocKOUBeRgV7H0MjedkNY985ycE2BuVFztZIV3NordZHndQdYsK+ZxYRIiRhEWK7dgS/vcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(38100700002)(86362001)(186003)(508600001)(110136005)(45080400002)(83380400001)(36756003)(966005)(66946007)(316002)(8936002)(6486002)(31686004)(2616005)(31696002)(66476007)(66556008)(2906002)(5660300002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkQ5Y0c1dDZaTEFDdCs3dzg2VDB3ZGYxWkJocitYTHdJZkZjYUhTQzF4VW1E?=
 =?utf-8?B?RTBHRngrMTlkT3NhaUNwelkvY1Z2MXBLNkU5L2pQZ1FJOHlJUXFSbFA3QjdM?=
 =?utf-8?B?Szk0UmdGb3JYdTJ5TjJZUzVVNkNtOUd2NnFUYmNYV1pMZ2hYRHJINHVnYnlD?=
 =?utf-8?B?SEpPS0FieU5PK2ZmQlFmM1ZabGNuWG9ENGEyWjgybXNVQkZUekYzQVBhcnVm?=
 =?utf-8?B?NmE0dGh5dzhmcFVCeFVYZUxIcWROTmlENzRXSVJhckYwRzQ0V013ZTFGNG9v?=
 =?utf-8?B?VUJRZXRiVGdoR3dtTmNNSkwvUTFGdlFIL2JkN3FIaTJTMlVyeXNOYUFBVExj?=
 =?utf-8?B?L3U1OWdvaEVuZWZCMDFMdHBweEttUU0yZE5FSTRHUS9NUi9vb2dIdmY0dy91?=
 =?utf-8?B?R2tCa1ZPakZKMC9HSVIxQ244eitha0ZsOWMxdGVsd3U0TFNONHlJU0NjNzFO?=
 =?utf-8?B?TjExWllUd2hWdEhmZUU4UFJSbHBNSExFcXJ4OVFkRHZQdENEYjRSbndwNzNG?=
 =?utf-8?B?ZklBdSsrMkd6Nm5Oa1NHRTZ0aGpOWEc2M3UzV2pnbnlCT1duOEV3blM2S09h?=
 =?utf-8?B?T1lQUDNsMTZPSGxuelB0dFUxYlpWc1dPL3BEQkdtZmg5cTRJNWxVTkVTWDFn?=
 =?utf-8?B?aUhEV1BRdXE2YmNxQU5ZRGRjMTFTWmNhQ3ZiMUtyWTZoUG0rV2JmdFpMbm5p?=
 =?utf-8?B?OTVYOWhuelBENjR5bHhCOCtoLzFoV1ZHYVJwcFJ1MnhDM2diK2xEQ01KTU0z?=
 =?utf-8?B?NnhSZDZLMlFjN2VDSVhHQUowQU13bjR0U3ZhNGR4NmJkYXZoVVVORGpvZFlm?=
 =?utf-8?B?TFJlek8zWlEyQWNoc1l2aGpxZG8wVkFxZHFnbngvWTRBQi9GVXRZRWhrUThj?=
 =?utf-8?B?Mi9IYnBGMzhza2xkTHlSZy9tOEx4S0txYm8xMnRyRVY3U2JFdGkybHhqU3Z5?=
 =?utf-8?B?dFZ5VUlsYWVoQzlBc3NQaTQvZHVBOXBZUTVnSEtnM1JWNWtiNWpWeEZWM1dW?=
 =?utf-8?B?WHJYOVZkSW9MKzE4U0FVK2lOVWE3MnRKOFRwUDI4OUpKa3FRbGIxTlA4SUt2?=
 =?utf-8?B?ZkNXMUlpRDFDNEJISkVFMFduVkxCd0VyZFpPb2F5bVdxOEdCVzlGTDZnbW9V?=
 =?utf-8?B?czlsMGhLVjRPQVJKRVFhWENzN2xFOXR6MkZ0Q2RyOXFzRStPTkVmY2hCdkhK?=
 =?utf-8?B?RDFVcityQVFUaUFGVURPN28wQ2djY0toYzg1ZnY0UE5JQm1QU09XSWFBRVhz?=
 =?utf-8?B?blRiNmYwUEkrS2gwRWdmMGJxOG9ycUZFbExnTnFMWmU1N0RTdll1V09qdVZE?=
 =?utf-8?B?SURKUDcrN0dCY2FGOTZQRE1TaHQxNllwTUF6aDJVenZpbDhGRFRoTXNPOFhH?=
 =?utf-8?B?bU11bTFtNkZYQVkrTzczM0dZY1FhWnZSVnloQWhhRW9BaVk5dVExa0daT3Uy?=
 =?utf-8?B?T3VQOWZnbTBzb0F0OE1QZlFIekpXb0MzMFZzVDFLSHJUN1R5N2NBZHhyQndS?=
 =?utf-8?B?YlJyN1ZOZnFWSWxXYUZBVm1aUkxvTzZ2Yy9VVExSQThnb0R2TDNwajZTMnMr?=
 =?utf-8?B?bjFobExwK2Rjdm1kczg3amJJU2ZqalNLN0dqVzNGKzdEendZdGhCMjlvYm1H?=
 =?utf-8?B?dm5KOU9hUUgvK0RpL0RQM3NBSW8vSmlaUHY5YmZ2QmpMMWcwMTJ2NTFOZjN6?=
 =?utf-8?B?TWk4SGY2c3IyTGdqZ0dwTzFmVXdHaEpkS0RsOGIwcmJJRUdRSmNGNzRQL3hH?=
 =?utf-8?B?SzViQlV2M2E5em0vby9vdWlNWEowY3JJVG51Uk05Q3BDZkZTT1pGYS9OTnFT?=
 =?utf-8?B?U0srWC9ucWptK2kwc0VDamxEWVYwaTZDNTMreXRQK2pCdEZWeGxTaHNnMXNy?=
 =?utf-8?Q?hAkhfCrpz6Ti/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55e6d38-10a6-4928-fe94-08d94bf5ba8f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 03:15:02.0577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPeqeZHJNDSa2hUFnqZN0S7nyR5lePEw4uQxHrSsVTF89r0JSJ1BhWhDqMLJfYqOCmtpsTsm+6yMofo8CKlESw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/20/2021 22:07, Liang, Prike wrote:
> [Public]
> 
> In the SMU issue troubleshooting process we also can check the SMU version by reading MP1 scratch register and  from long term we may need put the SMC version collection in the debug sysfs amdgpu_firmware_info
> 
> In this patch fashion, we better use dev_dbg instead of dev_info for only debug purpose.

Actually SMUv13 files have it at info level, which is why it was modeled 
this way.  Perhaps v13 should also decrease this to debug then.

> 
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Mario Limonciello
>> Sent: Wednesday, July 21, 2021 12:18 AM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>
>> Subject: [PATCH 1/2] drm/amd/pm: Add information about SMU11 firmware
>> version
>>
>> This information is useful for root causing issues with S0ix.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> index 0a5d46ac9ccd..626d7c2bdf66 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>> @@ -272,6 +272,9 @@ int smu_v11_0_check_fw_version(struct
>> smu_context *smu)
>>                break;
>>        }
>>
>> +     dev_info(smu->adev->dev, "smu fw reported version = 0x%08x
>> (%d.%d.%d)\n",
>> +                      smu_version, smu_major, smu_minor, smu_debug);
>> +
>>        /*
>>         * 1. if_version mismatch is not critical as our fw is designed
>>         * to be backward compatible.
>> --
>> 2.25.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
>> reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>> gfx&amp;data=04%7C01%7CPrike.Liang%40amd.com%7C62180964b7d24208
>> b59908d94b99f971%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C
>> 637623947521949203%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
>> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdat
>> a=ACcymqjRA5e1wmQmBCPW5cwsM1tF5QXOXQRukuAgkeg%3D&amp;reser
>> ved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
