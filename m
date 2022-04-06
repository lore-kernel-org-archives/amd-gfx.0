Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C5AC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Apr 2022 15:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C619510EDEB;
	Wed,  6 Apr 2022 15:39:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E5810EDCF
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Apr 2022 15:39:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Si+REuEu3mMxnUxns4YRyk6CsJ1moHqjYJTOJexrRqZPFYRw4cYODuQQh+lMiPZ988WXqSfnyFsBpaWktKysiBcq8pL6DRuXqNSlQsKPxo6+kfgceWSloeg7n5LrI+YVo+XtaYPLl8+FnzdVjxKIj8gdoFUUlihvwkwUvxer+uqAsBojJ6hOppSFzpVE/yGn1bwSzhFZSxuam0CW1OF1wU6VpmTNvhcbgrqRos74v5ZzgCxIsYQZghic8OOibWZFugBR2uwNN14m9g5y/Z1dUHDqy27dSmtoEMAhoTgQnPwLEbQltoHEQjNh+IgJQ5ZTKvNMHqDEk1eaXhix/lfnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3D3VMVboJ+KXYlxy+1otw+RtlyDbWGo/wIDVQJv8xIQ=;
 b=HABRZj3U1FTs2WMV87zwebRKg4Riwd0O9f5qClTxo6YYNPEZ+4oLHIAtKTH0XxRRPgQxtiu2g0gw9sqIZDqjNdCyUPPz011JGNVRJeIA8a3SN1fIzckF1G3I+yKY8Cm8y23XUt5W3tTRCKmYiCfb6MNJ1Wqd3ToEfpMr9o87mQzYSiOSPWgpwnkp3p3Hw7jg3hFFzu1q469PT60xpgNbk3Bvf7ese3ba6KSvykKLkh3unpAAKnkvZB5R1swoDU1ZrACrFJFGqjNS4//82kEKyJR4DVSgOCoUOhzyJj9jLyMRr9UMofV3jkvndktUnrYpwZsoYu/kARLONirIIwnQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3D3VMVboJ+KXYlxy+1otw+RtlyDbWGo/wIDVQJv8xIQ=;
 b=bEFb2cLkWgGVsZr3DMbF6HEgPVeYVkX7GYFgLilu7lzoZL/WVHzaKZa6oJOta8yIqtMVXCbEbVqTQrEuXm2XSMOlFndBUMnPdCjl8Q2QEvxJTzyUeJNRJjRMZsLWBjsQnsSHo/j9RBI9nZpqW93qzoU+rqtSY0VBEEW0ylYKLVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by BYAPR12MB3574.namprd12.prod.outlook.com (2603:10b6:a03:ae::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 15:39:33 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%6]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 15:39:33 +0000
Message-ID: <6c312307-5a60-f32a-8dc0-77bc2a8a5c48@amd.com>
Date: Wed, 6 Apr 2022 11:39:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
Content-Language: en-US
To: Shuotao Xu <shuotaoxu@microsoft.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <PSAP153MB051776C60FFB06BB3278EEB4B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
 <2cdfcdee-bf4d-006a-19c1-c806feb4100d@amd.com>
 <PSAP153MB0517571E0AECDB007D90A8F3B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
 <990573e7-bc0e-0c3a-11b9-c725fdee44df@amd.com>
 <PSAP153MB05176F6C82945DE2C3443248B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <PSAP153MB05176F6C82945DE2C3443248B7E79@PSAP153MB0517.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR20CA0053.namprd20.prod.outlook.com
 (2603:10b6:208:235::22) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e953cfd4-85d4-41bf-b8d8-08da17e3a577
X-MS-TrafficTypeDiagnostic: BYAPR12MB3574:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3574EBD4DE61F7BC6F198DDEEAE79@BYAPR12MB3574.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+B7Jv+3Nckbmx+X2vwts/jSaUJVSbT4eZScgEbZPnCKmaYnrJ8UeRVx7bk4FWJSm/PiTSSyifWRLvDSUkUBRqT5rEk0xSCoFCaYZ3sM6r7Ev99L1zdgXxcd8OrsvCY/gLL7qL12xeunPdPhFI9lG8j0Hywik94M4e1JBbUObACuPFBwfo+azBHjDszBBwwhIT/GCFD+sm7cPlDalak8u2Odgdhi+ljgH3zehohKHiYOscWA+ltqVNAq01VU+TkZs/5ICl2/v9K7sdWNnbk7tPih2wvF/8pw8Tzb78vda/0EXr6y7V1GoAFpBhwJNp+6rIefZtSkatbkX3PTxYjt8hURXhFPfK/GzUX1tu0BoUFeLIOzq55CbVaIKzDU9WABmy2/GvJsEjaOmsteK4cu1SA23XIo6KwYGvAje3yQS1A0kqtv4J/zt4ipV0jvuNvU/lSoFtu2lulsCgrXXEBIZWaNWXF4hquIFxH2/dAJOTWqHf/ZE8JbTmeM3iUoLc2fYulBgjBlBo2TRLfUdNEIzxVbkAsoSrRZBXnugfAE8iuag08InsZHll9abW56W50Ir+/saFcvSejcnaWp3aWnaPGAyBLSR27twExBuhK6U7SW/NiCj0C3yErbs0hULbPSoMuoIkcuzny2eyIfiPbq+7K0KPcqbHcdyugl6A40V8A69R7UyiuJ6+gaP+VWdaOZxCCq5a17heXWQJrULGCqU4ARNpgbT+nYHzoONlfwU/osSwNbqR/2eQ0S7H0r3Tj44RAEt6UoAtUfN9B+8BuGjShPatAUW3IEVa86TTzoAY5M1o/5LxBkh+H7sBgyYlhUse8w8B3/mJ1WvCpvyHGkHG4NAT+lb8tat9sLkusS5tKAZT24NRb6PjP6qDCoKbbOsN/1EAcUVi7pPKGiihnSgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(110136005)(6486002)(54906003)(16799955002)(31686004)(966005)(83380400001)(186003)(44832011)(45080400002)(31696002)(6636002)(5660300002)(8676002)(6512007)(4326008)(86362001)(8936002)(316002)(30864003)(66556008)(66946007)(66476007)(6506007)(36756003)(2616005)(508600001)(53546011)(45980500001)(43740500002)(10090945011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGxWbUl6TlROWFYwVGVMVzdzaUJXYUF6NVVPWTZac1BGdit4STdBRW9sV2Jl?=
 =?utf-8?B?Mk12b3BLVGw2WkZieHJ6aWlRL1VjZnE0QjF5cy9POHUyKzRMSDJMemRyN1F0?=
 =?utf-8?B?Q1dJTjRuQlFEQTMvYmgwUlZuZUZYaGU4NmxQd2RUUFBETzNJUlpUZUVoOFpw?=
 =?utf-8?B?dVpXNFlMU29mM0F4cHRja0wxT0FDaDEyYkJiQis3SnFZSUszWWlIRTUzWmxk?=
 =?utf-8?B?T3NmcFMzaDBLMzdtVFU4Z0lhTUdPV0NQSktOU01WVnpoS2xVTG9ZRENaanRv?=
 =?utf-8?B?Nk4zUEJYeityMmI5ZUJrSWZZcGtTRFpkWXg1bE9zYlMrV0ZXczhZa1JjY2M2?=
 =?utf-8?B?R1Z1ZVB0Smg5QUdQZy9KTFQ3Q1dSeXBXeVdrZjNiS1hBRUc2SUhIOUp0QTVE?=
 =?utf-8?B?TGlxR3RtSUpwZm4zdFVRbWJpNzBZSUtOa096RkhPTUJlcVFwbitPQlg5TDYr?=
 =?utf-8?B?SklOSHJkbXAyejZzVW5QUXJMdVl1NUdqSWdyakFqTWdMRDBsVHNGRS9TRHJQ?=
 =?utf-8?B?d3pjczVuSkVseGt0RDl3eHVkTnhhRVdwMVF1b0xxY0tiMURFSTdBYnlydUhD?=
 =?utf-8?B?T3VQcXlBSzU4VTVBY1FuNHd5WVV3SWE0NDVHRE1WbHc4TFdaamxqQ2o2QTk4?=
 =?utf-8?B?ck1MMkY5bWQvSHo4U2dtZjRRd2lSZDlRRE1kaW44WVNOUXNtanpFZFUyTUNF?=
 =?utf-8?B?TlNPVjR4VTJQRjgySFI1VG1OU3Q2K1NuaWtiTjg5aVc4d1RuV0tJYldldFpW?=
 =?utf-8?B?R2I4cFNBeVhwcndHTmNEeHpVcHNVa0JFQ1V5eUorczZkTjBjVFc0MFJJL1la?=
 =?utf-8?B?RkxzUDlETlMwNi95d29wZXFhQ2pvc1B1Z09yVGVYRy84VG40aGhIRFkyRXY0?=
 =?utf-8?B?S25WUVNxVERBblBQbUlCTUlMNGhkOTBNWHBpWisxNjJsaG1FU1M3TEd0cng5?=
 =?utf-8?B?UDlZNHQzN2xyazZTd01zM2FzUTZjUTcrSG93Q0dwY1ovajh0UU85b0hseFQv?=
 =?utf-8?B?eEd0bVVqWnB0Z1EwT3phWjYzWkZlNEJFQnRkVXc4d01ManlnVUdSYi9pL21I?=
 =?utf-8?B?YnZJMjQ4SzFOT091T0YwT0JyZGhUSDU1TGZXeTRBOEhoSnU0bDNRaG9wZlNt?=
 =?utf-8?B?L2VuUFg2QVRPc01DRXNCanJxNFVFUkhoVTZkZ1lrTU0vdlJpZjlLOE5aM1R2?=
 =?utf-8?B?b1o5NVJ3OGZaL3lUL3Y0ekRMT2E4Tk96MFZuV3FjUzA2dnJmU0RtMHBIVlIx?=
 =?utf-8?B?RHRTWEd6dXBYVmVHcEpSTlRYWitTbEowcTlHWUluQXFvcnJYYjJFVVA3WjNG?=
 =?utf-8?B?V1NTenlHTitOSmEvREROYWdraHRQTi9LNGNtOXhKUWlrQUt2VWh6VEY1VGpx?=
 =?utf-8?B?MWhSeGc3WmpMWVlJUnVIdnlkTXd4SzJUUEMrbmV2OWxpeHJXaWdCVHYxYjds?=
 =?utf-8?B?QXZUbURlUEQ4enpuZGVQdGJRVGYxNTdPQmFzUWxnQmZzcG1LbHNTN2k3YVdO?=
 =?utf-8?B?enFxTlZ6RDN3ODEwY2JORWMrZTExZERPdGNlblc0OTdQMlhNdGtSSGJOVjc4?=
 =?utf-8?B?SVVEVzdKdmxjNDYxZWlCQjFyU05lZ3RJbWJiSDA5SGR6ZkZWNFN0c20wWEdQ?=
 =?utf-8?B?Yi9JVEpudW40dkRQRjJjRFJKMC9CVWtHRGtDNFU3QklOczFVR2w5cjVEOG9C?=
 =?utf-8?B?UFdLNFFoZWgwTExQS0N2QU1JUVA1NnYzekE5WFFQYWZKaTVFK0pMaWFHcDJm?=
 =?utf-8?B?djZGeGVDN1lDNHI4cy9hd3Z0OURMaFpZUzdhWFpPMGxick1KVno2NmQwRklt?=
 =?utf-8?B?d0pIN24vSmFWWmorZDk2dldDZ0dzZmtkVW1CeVVSY29JMUdwUWUrZUlIVU5P?=
 =?utf-8?B?WndIMmUydGZDUitEQ1pnaGdTTkRodE1xV3B5YUZITVlBL2o2UjBGV1FiNktX?=
 =?utf-8?B?ZnJUcjdaTWQwL2JGSVdRQTJScWd1YjJrSmtIT25aMFRNbDFlZmpCRW1oZkIy?=
 =?utf-8?B?eWUzOHZpdkN1VlZiMFAwd0gzS3lZNTJtSk1Ia2JkZkhqYVl5NDJZQ1ZQSkFq?=
 =?utf-8?B?QWhyRTRXS3Y4NndQU05JUzFDNm9HUHV2ZElFbUhZRXZ0SmV0ZGtabUdOWDMy?=
 =?utf-8?B?ZEJOS3g2RTZSaDZCNlVtYXpwRUtZS1huai9CYWN0WkZUcDVkMHpnYmd5MUVk?=
 =?utf-8?B?cVd3Mm1VNTlTSnNtc2dYUzdEVGVRU0RwWmZVQS9zMGpzZitVOUZqZlFHcFJU?=
 =?utf-8?B?NUJrZXBHNldJMlNGdkI4ZWE5eXVZM1U5Zk5yRWNZYzg4cmNCZ3NZcytPd0k4?=
 =?utf-8?B?SVRBemZoSEErbUk3Yk9Kb3lWei9NSTVsMzVIeXR1MUJ5QllDZzd2SnlHK0xH?=
 =?utf-8?Q?8cckNfQHO16NFzKVN8OZrCG4Ag3jwfHlof0GTocdUxhwh?=
X-MS-Exchange-AntiSpam-MessageData-1: 9Uz4qPekE619vA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e953cfd4-85d4-41bf-b8d8-08da17e3a577
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 15:39:32.9635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s03lLrc9EmCwuGoK8hpoRJ3KgK77bSBzu9ZFLhQ5tvA++tJulNXP9vvoGzvP5sg48aztkZ/qukKSr57kqKMT/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3574
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
Cc: Ziyue Yang <Ziyue.Yang@microsoft.com>, Lei Qu <Lei.Qu@microsoft.com>,
 Peng Cheng <pengc@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+ Felix

On 2022-04-06 11:11, Shuotao Xu wrote:
> Hi Andrey,
> 
> Thanks for your kind comment on linux patch submission protocol, please 
> let me know if there is anyway to rectify it.

Just resend your patch to amd-gfx mailoing list using
git-send (see here how to use it - 
https://burzalodowa.wordpress.com/2013/10/05/how-to-send-patches-with-git-send-email/)

I suggest adding --cover-letter so you will be able to explain the
story behind the patch.

> 
> dmesg is fine except with some warning during pci rescan after pci 
> removal of an AMD MI100.
> 
> The issue is that after this rocm application will return segfault with 
> the amdgpu driver unless the entire amdgpu kernel module is unloaded and 
> loaded, which we did not meet our hotplug requirement. The issues upon 
> investigation are
> 
> 1) kfd_lock is locked after hotplug, and kfd_open will return fault 
> right away to libhsakmt .

I see now, kfd_lock is static and so single isntance across all devices
and so not going away after device removal but only after driver unload.
In this case I am not sure it's the best idea to just decrement kfd_lock
on device inint since in multi GPU system this might be locked on 
purpuse because another device is going through reset for example right
at this moment.

Felix, kgd2kfd_suspend is called also during device pci remove meaning
unblalanced decrement of the lock. Maybe we should not decremnt I
adding drm_dev_enter guard in kgd2kfd_suspend to avoid decrment of
kfd_locked if we are during PCI remove.


> 
> 2) iolink/p2plink has anormalies after hotplug, and libhsakmt will found 
> such anomalies and return error.

Can you point to what abnormalities ? Part of PCI hot unplug we clean
all sysfs files and this looks like part of it, do you see sysfs file
already exsist error on next pci_rescan ?


> 
> Our patch has been tested with a single-instance AMD MI100 GPU and 
> showed it worked.

Exactly, for multi GPU system arbitrary decrementing kfd_lock on device load
can be problematic.

Andrey

> 
> I am attaching the dmesg after rescan anyway, which will show the 
> warning and the segfault.
> 
> [  132.054822] pci 0000:43:00.0: [1002:738c] type 00 class 0x038000
> 
> [  132.054856] pci 0000:43:00.0: reg 0x10: [mem 
> 0x38b000000000-0x38b7ffffffff 64bit pref]
> 
> [  132.054877] pci 0000:43:00.0: reg 0x18: [mem 
> 0x38b800000000-0x38b8001fffff 64bit pref]
> 
> [  132.054890] pci 0000:43:00.0: reg 0x20: [io  0xa000-0xa0ff]
> 
> [  132.054904] pci 0000:43:00.0: reg 0x24: [mem 0xb8400000-0xb847ffff]
> 
> [  132.054918] pci 0000:43:00.0: reg 0x30: [mem 0xb8480000-0xb849ffff pref]
> 
> [  132.055134] pci 0000:43:00.0: PME# supported from D1 D2 D3hot D3cold
> 
> [  132.055217] pci 0000:43:00.0: 63.008 Gb/s available PCIe bandwidth, 
> limited by 8.0 GT/s PCIe x8 link at 0000:3c:14.0 (capable of 252.048 
> Gb/s with 16.0 GT/s PCIe x16 link)
> 
> [  132.056001] pci 0000:43:00.0: Adding to iommu group 73
> 
> [  132.057943] pci 0000:43:00.0: BAR 0: assigned [mem 
> 0x38b000000000-0x38b7ffffffff 64bit pref]
> 
> [  132.057960] pci 0000:43:00.0: BAR 2: assigned [mem 
> 0x38b800000000-0x38b8001fffff 64bit pref]
> 
> [  132.057974] pci 0000:43:00.0: BAR 5: assigned [mem 0xb8400000-0xb847ffff]
> 
> [  132.057981] pci 0000:43:00.0: BAR 6: assigned [mem 
> 0xb8480000-0xb849ffff pref]
> 
> [  132.057984] pci 0000:43:00.0: BAR 4: assigned [io  0xa000-0xa0ff]
> 
> [  132.058429] ======================================================
> 
> [  132.058453] WARNING: possible circular locking dependency detected
> 
> [  132.058477] 5.16.0-kfd+ #1 Not tainted
> 
> [  132.058492] ------------------------------------------------------
> 
> [  132.058515] bash/3632 is trying to acquire lock:
> 
> [  132.058534] ffffadee20adfb50 
> ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: __flush_work+0x2f5/0x470
> 
> [  132.058554] [drm] initializing kernel modesetting (ARCTURUS 
> 0x1002:0x738C 0x1002:0x0C34 0x01).
> 
> [  132.058577]
> 
>                 but task is already holding lock:
> 
> [  132.058580] ffffffffa3c62308
> 
> [  132.058630] amdgpu 0000:43:00.0: amdgpu: Trusted Memory Zone (TMZ) 
> feature not supported
> 
> [  132.058638]  (
> 
> [  132.058678] [drm] register mmio base: 0xB8400000
> 
> [  132.058683] pci_rescan_remove_lock
> 
> [  132.058694] [drm] register mmio size: 524288
> 
> [  132.058713] ){+.+.}-{3:3}, at: rescan_store+0x55/0x90
> 
> [  132.058773]
> 
>                 which lock already depends on the new lock.
> 
> [  132.058804]
> 
>                 the existing dependency chain (in reverse order) is:
> 
> [  132.058819] [drm] add ip block number 0 <soc15_common>
> 
> [  132.058831]
> 
>                 -> #1 (
> 
> [  132.058854] [drm] add ip block number 1 <gmc_v9_0>
> 
> [  132.058858] [drm] add ip block number 2 <vega20_ih>
> 
> [  132.058874] pci_rescan_remove_lock
> 
> [  132.058894] [drm] add ip block number 3 <psp>
> 
> [  132.058915] ){+.+.}-{3:3}
> 
> [  132.058931] [drm] add ip block number 4 <smu>
> 
> [  132.058951] :
> 
> [  132.058965] [drm] add ip block number 5 <gfx_v9_0>
> 
> [  132.058986]        __mutex_lock+0xa4/0x990
> 
> [  132.058996] [drm] add ip block number 6 <sdma_v4_0>
> 
> [  132.059016]        i801_add_tco_spt.isra.20+0x2a/0x1a0
> 
> [  132.059033] [drm] add ip block number 7 <vcn_v2_5>
> 
> [  132.059054]        i801_add_tco+0xf6/0x110
> 
> [  132.059075] [drm] add ip block number 8 <jpeg_v2_5>
> 
> [  132.059096]        i801_probe+0x402/0x860
> 
> [  132.059151]        local_pci_probe+0x40/0x90
> 
> [  132.059170]        work_for_cpu_fn+0x10/0x20
> 
> [  132.059189]        process_one_work+0x2a4/0x640
> 
> [  132.059208]        worker_thread+0x228/0x3f0
> 
> [  132.059227]        kthread+0x16d/0x1a0
> 
> [  132.059795]        ret_from_fork+0x1f/0x30
> 
> [  132.060337]
> 
>                 -> #0 ((work_completion)(&wfc.work)){+.+.}-{0:0}:
> 
> [  132.061405]        __lock_acquire+0x1552/0x1ac0
> 
> [  132.061950]        lock_acquire+0x26c/0x300
> 
> [  132.062484]        __flush_work+0x315/0x470
> 
> [  132.063009]        work_on_cpu+0x98/0xc0
> 
> [  132.063526]        pci_device_probe+0x1bc/0x1d0
> 
> [  132.064036]        really_probe+0x102/0x450
> 
> [  132.064532]        __driver_probe_device+0x100/0x170
> 
> [  132.065020]        driver_probe_device+0x1f/0xa0
> 
> [  132.065497]        __device_attach_driver+0x6b/0xe0
> 
> [  132.065975]        bus_for_each_drv+0x6a/0xb0
> 
> [  132.066449]        __device_attach+0xe2/0x160
> 
> [  132.066912]        pci_bus_add_device+0x4a/0x80
> 
> [  132.067365]        pci_bus_add_devices+0x2c/0x70
> 
> [  132.067812]        pci_bus_add_devices+0x65/0x70
> 
> [  132.068253]        pci_bus_add_devices+0x65/0x70
> 
> [  132.068688]        pci_bus_add_devices+0x65/0x70
> 
> [  132.068936] amdgpu 0000:43:00.0: amdgpu: Fetched VBIOS from ROM BAR
> 
> [  132.069109]        pci_bus_add_devices+0x65/0x70
> 
> [  132.069602] amdgpu: ATOM BIOS: 113-D3431401-X00
> 
> [  132.070058]        pci_bus_add_devices+0x65/0x70
> 
> [  132.070572] [drm] VCN(0) decode is enabled in VM mode
> 
> [  132.070997]        pci_rescan_bus+0x23/0x30
> 
> [  132.071000]        rescan_store+0x61/0x90
> 
> [  132.071003]        kernfs_fop_write_iter+0x132/0x1b0
> 
> [  132.071501] [drm] VCN(1) decode is enabled in VM mode
> 
> [  132.071964]        new_sync_write+0x11f/0x1b0
> 
> [  132.072432] [drm] VCN(0) encode is enabled in VM mode
> 
> [  132.072900]        vfs_write+0x35b/0x3b0
> 
> [  132.073376] [drm] VCN(1) encode is enabled in VM mode
> 
> [  132.073847]        ksys_write+0xa7/0xe0
> 
> [  132.074335] [drm] JPEG(0) JPEG decode is enabled in VM mode
> 
> [  132.074803]        do_syscall_64+0x34/0x80
> 
> [  132.074808]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> [  132.074811]
> 
>                 other info that might help us debug this:
> 
> [  132.074813]  Possible unsafe locking scenario:
> 
> [  132.075302] [drm] JPEG(1) JPEG decode is enabled in VM mode
> 
> [  132.075779]        CPU0                    CPU1
> 
> [  132.076361] amdgpu 0000:43:00.0: amdgpu: MEM ECC is active.
> 
> [  132.076765]        ----                    ----
> 
> [  132.077265] amdgpu 0000:43:00.0: amdgpu: SRAM ECC is active.
> 
> [  132.078649]   lock(pci_rescan_remove_lock);
> 
> [  132.078652]                                
> lock((work_completion)(&wfc.work));
> 
> [  132.078653]                                lock(pci_rescan_remove_lock);
> 
> [  132.078655]   lock((work_completion)(&wfc.work));
> 
> [  132.078656]
> 
>                  *** DEADLOCK ***
> 
> [  132.078656] 5 locks held by bash/3632:
> 
> [  132.078658]  #0: ffff9c39c7b89438
> 
> [  132.079612] amdgpu 0000:43:00.0: amdgpu: RAS INFO: ras initialized 
> successfully, hardware ability[7fff] ras_mask[7fff]
> 
> [  132.080089]  (
> 
> [  132.080602] [drm] vm size is 262144 GB, 4 levels, block size is 
> 9-bit, fragment size is 9-bit
> 
> [  132.081082] sb_writers
> 
> [  132.081601] amdgpu 0000:43:00.0: amdgpu: VRAM: 32752M 
> 0x0000008000000000 - 0x00000087FEFFFFFF (32752M used)
> 
> [  132.082102] #6
> 
> [  132.082630] amdgpu 0000:43:00.0: amdgpu: GART: 512M 
> 0x0000000000000000 - 0x000000001FFFFFFF
> 
> [  132.083152] ){.+.+}-{0:0}
> 
> [  132.083687] amdgpu 0000:43:00.0: amdgpu: AGP: 267878400M 
> 0x0000008800000000 - 0x0000FFFFFFFFFFFF
> 
> [  132.084210] , at: ksys_write+0xa7/0xe0
> 
> [  132.085708] [drm] Detected VRAM RAM=32752M, BAR=32768M
> 
> [  132.086205]  #1:
> 
> [  132.086733] [drm] RAM width 4096bits HBM
> 
> [  132.087269] ffff9c5959011088
> 
> [  132.087890] [drm] amdgpu: 32752M of VRAM memory ready
> 
> [  132.088389]  (
> 
> [  132.088972] [drm] amdgpu: 32752M of GTT memory ready.
> 
> [  132.089572] &of->mutex
> 
> [  132.090206] [drm] GART: num cpu pages 131072, num gpu pages 131072
> 
> [  132.090804] ){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x103/0x1b0
> 
> [  132.090808]  #2: ffff9c39c882a9e0 (kn->active#423){.+.+}-{0:0}, at: 
> kernfs_fop_write_iter+0x10c/0x1b0
> 
> [  132.091639] [drm] PCIE GART of 512M enabled.
> 
> [  132.092117]  #3:
> 
> [  132.092801] [drm] PTB located at 0x0000008000000000
> 
> [  132.093480] ffffffffa3c62308
> 
> [  132.094566] amdgpu 0000:43:00.0: amdgpu: PSP runtime database doesn't 
> exist
> 
> [  132.094822]  (pci_rescan_remove_lock){+.+.}-{3:3}, at: 
> rescan_store+0x55/0x90
> 
> [  132.094827]  #4: ffff9c597392b248 (&dev->mutex){....}-{3:3}, at: 
> __device_attach+0x39/0x160
> 
> [  132.094835]
> 
>                 stack backtrace:
> 
> [  132.097098] [drm] Found VCN firmware Version ENC: 1.1 DEC: 1 VEP: 0 
> Revision: 21
> 
> [  132.097467] CPU: 47 PID: 3632 Comm: bash Not tainted 5.16.0-kfd+ #1
> 
> [  132.098169] amdgpu 0000:43:00.0: amdgpu: Will use PSP to load VCN 
> firmware
> 
> [  132.098839] Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, 
> BIOS 2.1 08/14/2018
> 
> [  132.098841] Call Trace:
> 
> [  132.098842]  <TASK>
> 
> [  132.098843]  dump_stack_lvl+0x44/0x57
> 
> [  132.098848]  check_noncircular+0x105/0x120
> 
> [  132.098853]  ? unwind_get_return_address+0x1b/0x30
> 
> [  132.112924]  ? register_lock_class+0x46/0x780
> 
> [  132.113630]  ? __lock_acquire+0x1552/0x1ac0
> 
> [  132.114342]  __lock_acquire+0x1552/0x1ac0
> 
> [  132.115050]  lock_acquire+0x26c/0x300
> 
> [  132.115755]  ? __flush_work+0x2f5/0x470
> 
> [  132.116460]  ? lock_is_held_type+0xdf/0x130
> 
> [  132.117177]  __flush_work+0x315/0x470
> 
> [  132.117890]  ? __flush_work+0x2f5/0x470
> 
> [  132.118604]  ? lock_is_held_type+0xdf/0x130
> 
> [  132.119305]  ? mark_held_locks+0x49/0x70
> 
> [  132.119981]  ? queue_work_on+0x2f/0x70
> 
> [  132.120645]  ? lockdep_hardirqs_on+0x79/0x100
> 
> [  132.121300]  work_on_cpu+0x98/0xc0
> 
> [  132.121702] [drm] reserve 0x400000 from 0x87fec00000 for PSP TMR
> 
> [  132.121947]  ? __traceiter_workqueue_execute_end+0x40/0x40
> 
> [  132.123270]  ? pci_device_shutdown+0x60/0x60
> 
> [  132.123880]  pci_device_probe+0x1bc/0x1d0
> 
> [  132.124475]  really_probe+0x102/0x450
> 
> [  132.125060]  __driver_probe_device+0x100/0x170
> 
> [  132.125641]  driver_probe_device+0x1f/0xa0
> 
> [  132.126215]  __device_attach_driver+0x6b/0xe0
> 
> [  132.126797]  ? driver_allows_async_probing+0x50/0x50
> 
> [  132.127383]  ? driver_allows_async_probing+0x50/0x50
> 
> [  132.127960]  bus_for_each_drv+0x6a/0xb0
> 
> [  132.128528]  __device_attach+0xe2/0x160
> 
> [  132.129095]  pci_bus_add_device+0x4a/0x80
> 
> [  132.129659]  pci_bus_add_devices+0x2c/0x70
> 
> [  132.130213]  pci_bus_add_devices+0x65/0x70
> 
> [  132.130753]  pci_bus_add_devices+0x65/0x70
> 
> [  132.131283]  pci_bus_add_devices+0x65/0x70
> 
> [  132.131780]  pci_bus_add_devices+0x65/0x70
> 
> [  132.132270]  pci_bus_add_devices+0x65/0x70
> 
> [  132.132757]  pci_rescan_bus+0x23/0x30
> 
> [  132.133233]  rescan_store+0x61/0x90
> 
> [  132.133701]  kernfs_fop_write_iter+0x132/0x1b0
> 
> [  132.134167]  new_sync_write+0x11f/0x1b0
> 
> [  132.134627]  vfs_write+0x35b/0x3b0
> 
> [  132.135062]  ksys_write+0xa7/0xe0
> 
> [  132.135503]  do_syscall_64+0x34/0x80
> 
> [  132.135933]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> [  132.136358] RIP: 0033:0x7f0058a73224
> 
> [  132.136775] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 
> 00 00 00 66 90 48 8d 05 c1 07 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 
> 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 41 54 55 49 89 d4 53 48 89 f5
> 
> [  132.137663] RSP: 002b:00007ffc4f4c71a8 EFLAGS: 00000246 ORIG_RAX: 
> 0000000000000001
> 
> [  132.138121] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 
> 00007f0058a73224
> 
> [  132.138590] RDX: 0000000000000002 RSI: 000055d466c24450 RDI: 
> 0000000000000001
> 
> [  132.139064] RBP: 000055d466c24450 R08: 000000000000000a R09: 
> 0000000000000001
> 
> [  132.139532] R10: 000000000000000a R11: 0000000000000246 R12: 
> 00007f0058d4f760
> 
> [  132.140003] R13: 0000000000000002 R14: 00007f0058d4b2a0 R15: 
> 00007f0058d4a760
> 
> [  132.140485]  </TASK>
> 
> [  132.183669] amdgpu 0000:43:00.0: amdgpu: HDCP: optional hdcp ta ucode 
> is not available
> 
> [  132.184214] amdgpu 0000:43:00.0: amdgpu: DTM: optional dtm ta ucode 
> is not available
> 
> [  132.184735] amdgpu 0000:43:00.0: amdgpu: RAP: optional rap ta ucode 
> is not available
> 
> [  132.185234] amdgpu 0000:43:00.0: amdgpu: SECUREDISPLAY: securedisplay 
> ta ucode is not available
> 
> [  132.185823] amdgpu 0000:43:00.0: amdgpu: use vbios provided pptable
> 
> [  132.186327] amdgpu 0000:43:00.0: amdgpu: smc_dpm_info table 
> revision(format.content): 4.6
> 
> [  132.188783] amdgpu 0000:43:00.0: amdgpu: SMU is initialized successfully!
> 
> [  132.190039] [drm] kiq ring mec 2 pipe 1 q 0
> 
> [  132.203608] [drm] VCN decode and encode initialized 
> successfully(under DPG Mode).
> 
> [  132.204178] [drm] JPEG decode initialized successfully.
> 
> [  132.246079] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
> 
> [  132.327589] memmap_init_zone_device initialised 8388608 pages in 64ms
> 
> [  132.328139] amdgpu: HMM registered 32752MB device memory
> 
> [  132.328784] amdgpu: Virtual CRAT table created for GPU
> 
> [  132.329844] amdgpu: Topology: Add dGPU node [0x738c:0x1002]
> 
> [  132.330387] kfd kfd: amdgpu: added device 1002:738c
> 
> [  132.330965] amdgpu 0000:43:00.0: amdgpu: SE 8, SH per SE 1, CU per SH 
> 16, active_cu_number 72
> 
> [  132.331725] amdgpu 0000:43:00.0: amdgpu: ring comp_1.0.0 uses VM inv 
> eng 0 on hub 0
> 
> [  132.332296] amdgpu 0000:43:00.0: amdgpu: ring comp_1.1.0 uses VM inv 
> eng 1 on hub 0
> 
> [  132.332856] amdgpu 0000:43:00.0: amdgpu: ring comp_1.2.0 uses VM inv 
> eng 4 on hub 0
> 
> [  132.333414] amdgpu 0000:43:00.0: amdgpu: ring comp_1.3.0 uses VM inv 
> eng 5 on hub 0
> 
> [  132.333965] amdgpu 0000:43:00.0: amdgpu: ring comp_1.0.1 uses VM inv 
> eng 6 on hub 0
> 
> [  132.334507] amdgpu 0000:43:00.0: amdgpu: ring comp_1.1.1 uses VM inv 
> eng 7 on hub 0
> 
> [  132.335057] amdgpu 0000:43:00.0: amdgpu: ring comp_1.2.1 uses VM inv 
> eng 8 on hub 0
> 
> [  132.335594] amdgpu 0000:43:00.0: amdgpu: ring comp_1.3.1 uses VM inv 
> eng 9 on hub 0
> 
> [  132.336137] amdgpu 0000:43:00.0: amdgpu: ring kiq_2.1.0 uses VM inv 
> eng 10 on hub 0
> 
> [  132.336679] amdgpu 0000:43:00.0: amdgpu: ring sdma0 uses VM inv eng 0 
> on hub 1
> 
> [  132.337234] amdgpu 0000:43:00.0: amdgpu: ring sdma1 uses VM inv eng 1 
> on hub 1
> 
> [  132.337790] amdgpu 0000:43:00.0: amdgpu: ring sdma2 uses VM inv eng 4 
> on hub 1
> 
> [  132.338343] amdgpu 0000:43:00.0: amdgpu: ring sdma3 uses VM inv eng 5 
> on hub 1
> 
> [  132.338906] amdgpu 0000:43:00.0: amdgpu: ring sdma4 uses VM inv eng 6 
> on hub 1
> 
> [  132.339448] amdgpu 0000:43:00.0: amdgpu: ring sdma5 uses VM inv eng 0 
> on hub 2
> 
> [  132.339987] amdgpu 0000:43:00.0: amdgpu: ring sdma6 uses VM inv eng 1 
> on hub 2
> 
> [  132.340519] amdgpu 0000:43:00.0: amdgpu: ring sdma7 uses VM inv eng 4 
> on hub 2
> 
> [  132.341041] amdgpu 0000:43:00.0: amdgpu: ring vcn_dec_0 uses VM inv 
> eng 5 on hub 2
> 
> [  132.341570] amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv 
> eng 6 on hub 2
> 
> [  132.342101] amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv 
> eng 7 on hub 2
> 
> [  132.342630] amdgpu 0000:43:00.0: amdgpu: ring vcn_dec_1 uses VM inv 
> eng 8 on hub 2
> 
> [  132.343152] amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_1.0 uses VM inv 
> eng 9 on hub 2
> 
> [  132.343657] amdgpu 0000:43:00.0: amdgpu: ring vcn_enc_1.1 uses VM inv 
> eng 10 on hub 2
> 
> [  132.344136] amdgpu 0000:43:00.0: amdgpu: ring jpeg_dec_0 uses VM inv 
> eng 11 on hub 2
> 
> [  132.344610] amdgpu 0000:43:00.0: amdgpu: ring jpeg_dec_1 uses VM inv 
> eng 12 on hub 2
> 
> [  132.378213] amdgpu: Detected AMDGPU 6 Perf Events.
> 
> [  132.387349] [drm] Initialized amdgpu 3.46.0 20150101 for 0000:43:00.0 
> on minor 1
> 
> [  132.388530] pcieport 0000:d7:00.0: bridge window [io  0x1000-0x0fff] 
> to [bus d8] add_size 1000
> 
> [  132.389078] pcieport 0000:d7:00.0: BAR 13: no space for [io  size 0x1000]
> 
> [  132.389600] pcieport 0000:d7:00.0: BAR 13: failed to assign [io  size 
> 0x1000]
> 
> [  132.390091] pcieport 0000:d7:00.0: BAR 13: no space for [io  size 0x1000]
> 
> [  132.390568] pcieport 0000:d7:00.0: BAR 13: failed to assign [io  size 
> 0x1000]
> 
> [  155.359200] HelloWorld[3824]: segfault at 68 ip 00007f4c979f764e sp 
> 00007ffc9b3bb610 error 4 in 
> libamdhip64.so.4.4.21432-f9dccde4[7f4c979b3000+2eb000]
> 
> [  155.360268] Code: 48 8b 45 e8 64 48 33 04 25 28 00 00 00 74 05 e8 b8 
> c7 fb ff 48 8b 5d f8 c9 c3 f3 0f 1e fa 55 48 89 e5 48 89 7d f8 48 8b 45 
> f8 <48> 8b 40 68 5d c3 f3 0f 1e fa 55 48 89 e5 48 89 7d f8 48 8b 45 f8
> 
> Best regards,
> 
> Shuotao
> 
> *From: *Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> *Date: *Wednesday, April 6, 2022 at 10:36 PM
> *To: *Shuotao Xu <shuotaoxu@microsoft.com>, 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc: *Ziyue Yang <Ziyue.Yang@microsoft.com>, Lei Qu 
> <Lei.Qu@microsoft.com>, Peng Cheng <pengc@microsoft.com>, Ran Shu 
> <Ran.Shu@microsoft.com>
> *Subject: *Re: [EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
> 
> [You don't often get email from andrey.grodzovsky@amd.com. Learn why 
> this is important at http://aka.ms/LearnAboutSenderIdentification.] 
> <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Faka.ms%2FLearnAboutSenderIdentification.%255d&data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ccf05d2033d264aef772508da17dfc58c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637848547134165533%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=gS%2BhMp165sXmPjg22lVa42oUSwZXfuhAoj2OcOmwRuk%3D&reserved=0>
> 
> Can you attach dmesg for the failure without your patch against
> amd-staging-drm-next ?
> 
> Also, in general, patches for amdgpu upstream branches should be
> submitted to amd-gfx mailing list inline using git-send which makes it
> easy to comment and review them inline.
> 
> Andrey
> 
> On 2022-04-06 10:25, Shuotao Xu wrote:
>> Hi Andrey,
>>
>> We just tried kernel 5.16 based on
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=jz51aMtsG7PIEfLy1jLvLGd%2BsBREvOFf9Gc6BZlmsmU%3D&amp;reserved=0 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ccf05d2033d264aef772508da17dfc58c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637848547134165533%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=%2Bl6rD8x7VDD1sq54XEi3rmhgGbgun0PabfIRFaG8S88%3D&reserved=0>
>> <https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=jz51aMtsG7PIEfLy1jLvLGd%2BsBREvOFf9Gc6BZlmsmU%3D&amp;reserved=0 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ccf05d2033d264aef772508da17dfc58c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637848547134165533%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=%2Bl6rD8x7VDD1sq54XEi3rmhgGbgun0PabfIRFaG8S88%3D&reserved=0>>
>> amd-staging-drm-next branch, and found out that hotplug did not work out
>> of box for Rocm compute stack.
>>
>> We did not try the rendering stack since we currently are more focused
>> on AI workloads.
>>
>> We have also created a patch against the amd-staging-drm-next branch to
>> enable hotplug for ROCM stack, which were sent in another later email
>> with same subject. I am attaching the patch in this email, in case that
>> you would want to delete that later email.
>>
>> Best regards,
>>
>> Shuotao
>>
>> *From: *Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> *Date: *Wednesday, April 6, 2022 at 10:13 PM
>> *To: *Shuotao Xu <shuotaoxu@microsoft.com>,
>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc: *Ziyue Yang <Ziyue.Yang@microsoft.com>, Lei Qu
>> <Lei.Qu@microsoft.com>, Peng Cheng <pengc@microsoft.com>, Ran Shu
>> <Ran.Shu@microsoft.com>
>> *Subject: *[EXTERNAL] Re: Code Review Request for AMDGPU Hotplug Support
>>
>> [You don't often get email from andrey.grodzovsky@amd.com. Learn why
>> this is important at http://aka.ms/LearnAboutSenderIdentification.] 
> <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Faka.ms%2FLearnAboutSenderIdentification.%255d&data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ccf05d2033d264aef772508da17dfc58c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637848547134165533%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=gS%2BhMp165sXmPjg22lVa42oUSwZXfuhAoj2OcOmwRuk%3D&reserved=0>
>> <https://nam06.safelinks.protection.outlook.com/?url=http%3A%2F%2Faka.ms%2FLearnAboutSenderIdentification.%255d&amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=HfSwu6SWfoCYyscJqGFdKHBPtaj%2BKB4lyo13zkm6hi4%3D&amp;reserved=0 
> <https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Faka.ms%2FLearnAboutSenderIdentification.%255d&data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ccf05d2033d264aef772508da17dfc58c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637848547134165533%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=gS%2BhMp165sXmPjg22lVa42oUSwZXfuhAoj2OcOmwRuk%3D&reserved=0>>
>>
>> Looks like you are using 5.13 kernel for this work, FYI we added
>> hot plug support for the graphic stack in 5.14 kernel (see
>> https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unplug&amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=4l9mT8zNR%2FvqsEFr7noIDqKf16IGN8xmO2T6jnpipzo%3D&amp;reserved=0) 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unplug&data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ccf05d2033d264aef772508da17dfc58c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637848547134165533%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=LSwOIrmGXU8Ne7E6wlIo%2FXbJcacyWbd%2FltwJSMP2Ofw%3D&reserved=0>
>> <https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unplug&amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=4l9mT8zNR%2FvqsEFr7noIDqKf16IGN8xmO2T6jnpipzo%3D&amp;reserved=0 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.phoronix.com%2Fscan.php%3Fpage%3Dnews_item%26px%3DLinux-5.14-AMDGPU-Hot-Unplug&data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ccf05d2033d264aef772508da17dfc58c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637848547134165533%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=LSwOIrmGXU8Ne7E6wlIo%2FXbJcacyWbd%2FltwJSMP2Ofw%3D&reserved=0>>
>>
>>
>> I am not sure about the code part since it all touches KFD driver (KFD
>> team can comment on that) - but I was just wondering if you try 5.14
>> kernel would things just work for you out of the box ?
>>
>> Andrey
>>
>> On 2022-04-05 22:45, Shuotao Xu wrote:
>>> Dear AMD Colleagues,
>>>
>>> We are from Microsoft Research, and are working on GPU disaggregation
>>> technology.
>>>
>>> We have created a new pull requestAdd PCIe hotplug support for amdgpu by
>>> xushuotao · Pull Request #131 · RadeonOpenCompute/ROCK-Kernel-Driver
>>> (github.com)
>>> <https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=qEeZR6R95jrjAaltd1MnpyFedOiVZaNQuCxcoNog90g%3D&amp;reserved=0
>> <https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&amp;data=05%7C01%7Cshuotaoxu%40microsoft.com%7C93f1fcb8f60541f7b87308da17dae167%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637848526184858564%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=qEeZR6R95jrjAaltd1MnpyFedOiVZaNQuCxcoNog90g%3D&amp;reserved=0 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FRadeonOpenCompute%2FROCK-Kernel-Driver%2Fpull%2F131&data=04%7C01%7Candrey.grodzovsky%40amd.com%7Ccf05d2033d264aef772508da17dfc58c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637848547134165533%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&sdata=0WQ9S94HsQYwhgoM5MhqtkZOP1mfsaiLrDqoEZh1YkU%3D&reserved=0>>>in
>>> ROCK-Kernel-Driver, which will enable PCIe hot-plug support for amdgpu.
>>>
>>> We believe the support of hot-plug of GPU devices can open doors for
>>> many advanced applications in data center in the next few years, and we
>>> would like to have some reviewers on this PR so we can continue further
>>> technical discussions around this feature.
>>>
>>> Would you please help review this PR?
>>>
>>> Thank you very much!
>>>
>>> Best regards,
>>>
>>> Shuotao Xu
>>>
>>
> 
