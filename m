Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED3FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 07:04:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0E9F10E52C;
	Fri, 10 Dec 2021 07:04:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF7B210E1C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 07:04:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nuvo8WKl8dERcTEde0TLxGhy4XUNYGMHBHlvFSmZgxx8nY3JM12oBZyb/Jk91141yd9JXK0gRsUC8T8QT7RZjN4Z1bjE59ned+0NxRi5BVcSXpXtjpAwv4LNzOtvB+sBSz700gllFcMoWvJvLAXBFWQ0lksMU6s85DVtEae108IUHD5ZgY1uRbC5CcsDyKFzs2gea7O2dyVGeN0bidn4r7k5fx1m7csMVwkzzL2WG3aC3YfRRRrmkLvzQh/0EMr7m3lcy+Rcicj/bpsvneGRXeAF+hq0qIJ480I2ZWdEGMkp2IHr1r3Wa0NQV9OlaGyfNv7I0iTcvwjj7Y9QyjqVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXXxaKOUmz9LabYQrhZjNIUmfHgabrHJqAt36qIdtLo=;
 b=ZipIiN+ZPREwe768bqiX9zZZD588+d7fjWPConi2iDWr58CGwOWW8zSTF2s7MuXncUxOpCxvYBQG3VaZir0jaCwam4sWyFLb0Tc96dPNrho+HJxaAys40dKfXQNYI4yyJztT5Jh2YP3CtN0ikqYrBppcmmU0T5WmJ/1AqP10rfv/rHCJkSngn/VEv8PnSxl0Er8PDpd475YSdEmZDoHpeeiGqdmwD1jCkEllg9Q2ATG22iN3qb0uWZqaQq4ezuYd0F3DAwhLyrJxmPN41de5QWT+DJJK3oAeKfEcS5IA6p7EYwB/iu+8V0JksrzPMisIPcyU5FFx0/vxAAexeGPvqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXXxaKOUmz9LabYQrhZjNIUmfHgabrHJqAt36qIdtLo=;
 b=N+lbk/oOBLicbTGaRU+3wcGw2Mvn4FCleccCy++zyKLQqGqKcbsIUuEqc/K+sg+xI5KDjwPRmRX1BfNnsHrrYRWg/mWqaIZ2hfS8nRlJGwxYxx5DeQN+y4i4RaPsn6oKTE1vFyHZgtIUJoyxFSS8YE7rhOoHtwX9TXOzOUWrlKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1774.namprd12.prod.outlook.com
 (2603:10b6:300:112::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Fri, 10 Dec
 2021 07:04:11 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4%12]) with mapi id 15.20.4755.024; Fri, 10 Dec
 2021 07:04:11 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
To: Lang Yu <Lang.Yu@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>
References: <20211209084914.261889-1-lang.yu@amd.com>
 <20211209084914.261889-2-lang.yu@amd.com>
 <DM6PR12MB2619199DA5BBADDF0ED9ED0CE4719@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YbK8lwgodK5VutKA@lang-desktop>
 <DM6PR12MB2619F67E8A6A3D230A5D6E52E4719@DM6PR12MB2619.namprd12.prod.outlook.com>
 <YbLHyOypWV8FV0oc@lang-desktop>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c6151df9-1b12-e985-22df-bfd6ea32f582@amd.com>
Date: Fri, 10 Dec 2021 08:04:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YbLHyOypWV8FV0oc@lang-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0033.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::46) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (87.176.191.248) by
 AM0PR02CA0033.eurprd02.prod.outlook.com (2603:10a6:208:3e::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21 via Frontend Transport; Fri, 10 Dec 2021 07:04:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d8a1a6a-576b-4a44-0d9d-08d9bbab4464
X-MS-TrafficTypeDiagnostic: MWHPR12MB1774:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1774DB73FE8FDE927626F92B83719@MWHPR12MB1774.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCUrqNn2OGvqNXd3Xz8SpmXDPDEWfVZIt+CpGM4xRMzBTyDJp/tcEMVngHdLxwPj3JIms8RbpUGjlXUcB4ymYaVfEbUnJf/Z0YIW9dlrhekxUIcrsKW8ByU/gXDheV9kpCE2A0chmi4GvrCvwer3xOSnho43wKB7HL0a2KjYuSWZSJZG/fajIPP3i3uDhtmdxfzK20JUUmlJWK2FCJul4P57FhxwqsMZpvzAU1ob6VFaDusip9H4jeWZ07kMe7AQqE8fOerTp+FJV6Eu12/gSqI2V2847vxWegweY5MErPTY5wul8fEtubDAdBHpu94Q/UeBk2f5CiF/TXshaYzpZEBJqDs+Z+faLwxrt9kfyYefRAPiFO8uLKL9NFfmF4RnOGaphLTWRi6IGAiITx0yZv8f7wLBNMY8S5OcoCIrBDz2jIwpz/QSNla2++/Y+gBNOVXbRYcCsOZ2XCIaHTKHxvjIYXE4CtZehqgV423ADS8kwTbEqQngAP3+R+fyx8hi3VbhPyZJEjn+cVWgX0NhK+pyY1QLixe+AyMvyg0VWJw9/UGFVHDc2xHysYRQFdBsbtj6XCTFczAKYEMITwp7/9AnwUZPwUypbTAn7pPRTWCze/uknsKCaypoTNL1vxDojWG1n7xWXs3YOURInzjdHDglAe0fdu2XuvxoOfUusJSviZRwl0H7qYeurug0fSlBslC+rVH0kVASmrzwAtawf8X/PG/YW19ScpTUldXA2lxBJIXkxKYFVmHcNf0Scfzf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66556008)(16576012)(66946007)(86362001)(186003)(53546011)(26005)(508600001)(8676002)(316002)(6666004)(6636002)(83380400001)(36756003)(31686004)(8936002)(38100700002)(110136005)(54906003)(2616005)(2906002)(5660300002)(31696002)(4326008)(956004)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTVxaS9VNlk2Mno4ZFpRUllROHR4VU8xWVN2aTY5SG1ZTlNER1ZpdEh5S295?=
 =?utf-8?B?cTNCRmxjS0cyN0NGOGlzcUNhMEJwSC9MRitkR295NC9FbFFMdWFicUtBWDMw?=
 =?utf-8?B?NmJpOFlHU3kwQkdnUTI0NGxaVG9GdENwQWd2NWlXV3FqbitsV0JFTDhSSHdF?=
 =?utf-8?B?SmdxR2VmZTJDRnhmKy9hVStlSFBRSmlzY1gyQmt4azRkV095eC91SXdhWjZ4?=
 =?utf-8?B?Z0QzdjMrRzRHamNETEVmeUl3SkYyVzdNYWp1dFJ1S0lnQVB2T0poT04zTEF6?=
 =?utf-8?B?U2twc2tyKzBRVTg5VEtLOTZjeGFPTkJ5WHM0Q1VMb0xDOW9ESTJ3cHZudzh3?=
 =?utf-8?B?MDJrak82SE5CakloanU0Y3lweVFhZzUvUUJqcWdNTEkrTkc3c3huazVhNnpt?=
 =?utf-8?B?RHp0alpPS3RKTDFkcjJ2QzZ5Y0FBNi9ZT0hyUHRvbjAyZ2pxTVdUL2tINGJO?=
 =?utf-8?B?Mk0xUVQ1RmlYT1VDOHNrWXZpTyt5eGk0WFYwM2p6Qy9zc3Z4Mi9sQmtFQzFN?=
 =?utf-8?B?Q1hSVW0xVzB2Y3Avb3hKSVRWdlUzdS9QcjZWdEdQVWt2ZVI5dW5hLzRidlN3?=
 =?utf-8?B?a3RGS2h3aW9oemsxc2Z5YVI4MjdOMlNYOHlwOU1wdjVzNXpjMGFXYU9BVng0?=
 =?utf-8?B?dXVERWtCekMxNlVUUDhqSVZlaGdsRjd2Z3dKSm1wb2FsWFUvd25XV3lsWnJm?=
 =?utf-8?B?Umdoay9jeHh5S3U0T2FhQ3lPeFYxZU1ReW5IRVhaT3A1TEpFWncyd29lTk9u?=
 =?utf-8?B?bWs3MW5pWlRWMjRxbEdSblhCNms4RDJkb3BoOFFvWWpFeG5lNzlkaS9QcEFB?=
 =?utf-8?B?R3YwM2wzMWRKOFY2K2dxNjhVWnFON3BGSEZtRXlTajJ4cGV5dDVzNXhmSFlK?=
 =?utf-8?B?ekdhZzdGOFpGQVpEcFFNaVpIVS9YcG8zTnV0MnlsbmQzUGVrRWNkRCtYY2dj?=
 =?utf-8?B?VmlNNWJQcCtvcXRXZUg5eGdWa0ZiTEdQc2lEdi9XaHFuV0grN01LcVB4VzBR?=
 =?utf-8?B?WVgrZHd1ZVNsSnl5Q2MzaU9EWE1RL0UxOTFNL3lGUk9Xanh5VjY1K2tESjVr?=
 =?utf-8?B?Mkh3NUhoTWFmVEp5RHBjcDROMHZUM3g5NHlJMmFucXRCSDdmSHNRRU4xdWR3?=
 =?utf-8?B?SUVjZzBUVXNvREhvS21HYmZUVHhhblZwNkVTQXNZYTJGKy92N2RWYmtRNFpM?=
 =?utf-8?B?bWRTUE12UDhITjZzMFRFU1FRcWVMVk5PNnFHekd2bUZSd1dVWVZSL0RRTnRh?=
 =?utf-8?B?MzVaRGtzdlg3RmpzemNZRzhzYnRrL1huTWRVWkJ5VWF4OTZsc2VGckVHb2c1?=
 =?utf-8?B?dVJra1NXZEo0SnhiRzVJYk1Xam1VU3JqZzVWTGNEQ0R3NTUvczVmN0VoYUdE?=
 =?utf-8?B?bmlkY3pVV201bHNGQmtqL1RMMHcvNnNmZVdJeGtGZDRRYzJLcEZTSDRzb1Rt?=
 =?utf-8?B?ZXl2K2ZNcmhpYkVkd3BFZEVHK2xRajNVM3Y0NmcvNU16TjhPR014cE15aUxF?=
 =?utf-8?B?bEtrR3hJaHZOYTBWbUduU1FnUG9veG9IeW16NUhycHpFWjVaeWFNSzlUeHdQ?=
 =?utf-8?B?Q29US0EzY0xkRzNlcGdkMEIxQWErY09oTURGQTF6cExjQ0VCaW93R055S01U?=
 =?utf-8?B?OWZQUVMrQXVSZXU4OVh6MlJmRkp5c0poci9JUzFVSnQvMmx2ZWhUYnBVQ3Ex?=
 =?utf-8?B?SzNHaWMxZTNndWFUYmFoUk1xRG9VRStPc0NUdzhlTFVzQS85c1p1T3lyZ2RX?=
 =?utf-8?B?eS9QdTdHVTRDbjYwWUxSMkIzd2VCOW82OGNXa3EzSGlXRkRFZldxRURQL21N?=
 =?utf-8?B?ZW9jYXlhalJ4SmpQdm5jRlU3R0QzL1B6bkNKVHc0eklCUDRYbXQzQ1ZRS3Vt?=
 =?utf-8?B?ZDRnT0ltTndRSzdGZWVtYWx1VVdwcW14MXBSbzZZK3lZRXE3MEFyd3R0QXhp?=
 =?utf-8?B?cXJMekRhRGExNmRuaVJzNjRxRkNuUVBTbzZ0T1l3MTlCcEkvZFV1eXdCZFU5?=
 =?utf-8?B?Z2p6bHRoaGpCVjdzYmM4L09pSnJycFQ3LzJwOFdQNExGL01WTk1ZY0ZrQW4z?=
 =?utf-8?B?RVhVYzQvWTFnMGRMS1puUmtESHB4dHIvaFNyODhzV1FXUzZ6bTFZM1RZT245?=
 =?utf-8?Q?eJ50=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8a1a6a-576b-4a44-0d9d-08d9bbab4464
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 07:04:11.4423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/XzhEQTFRQ51MQWevbb3ECI1Ibj4Nl3zq55ZoV9V+OOJDOA4XS1oIgz9r38CktO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1774
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.12.21 um 04:21 schrieb Lang Yu:
> On 12/10/ , Quan, Evan wrote:
>> [AMD Official Use Only]
>>
>>
>>
>>> -----Original Message-----
>>> From: Yu, Lang <Lang.Yu@amd.com>
>>> Sent: Friday, December 10, 2021 10:34 AM
>>> To: Quan, Evan <Evan.Quan@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey
>>> <Andrey.Grodzovsky@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Huang,
>>> Ray <Ray.Huang@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>
>>> Subject: Re: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
>>>
>>> On 12/10/ , Quan, Evan wrote:
>>>> [AMD Official Use Only]
>>>>
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>>> Lang Yu
>>>>> Sent: Thursday, December 9, 2021 4:49 PM
>>>>> To: amd-gfx@lists.freedesktop.org
>>>>> Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Lazar, Lijo
>>>>> <Lijo.Lazar@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Deucher,
>>>>> Alexander <Alexander.Deucher@amd.com>; Yu, Lang
>>> <Lang.Yu@amd.com>;
>>>>> Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Subject: [PATCH 2/2] drm/amdgpu: add support for SMU debug option
>>>>>
>>>>> SMU firmware guys expect the driver maintains error context and
>>>>> doesn't interact with SMU any more when SMU errors occurred.
>>>>> That will aid in debugging SMU firmware issues.
>>>>>
>>>>> Add SMU debug option support for this request, it can be enabled or
>>>>> disabled via amdgpu_smu_debug debugfs file.
>>>>> When enabled, it brings hardware to a kind of halt state so that no
>>>>> one can touch it any more in the envent of SMU errors.
>>>>>
>>>>> Currently, dirver interacts with SMU via sending messages.
>>>>> And threre are three ways to sending messages to SMU.
>>>>> Handle them respectively as following:
>>>>>
>>>>> 1, smu_cmn_send_smc_msg_with_param() for normal timeout cases
>>>>>
>>>>>    Halt on any error.
>>>>>
>>>>> 2,
>>> smu_cmn_send_msg_without_waiting()/smu_cmn_wait_for_response()
>>>>> for longer timeout cases
>>>>>
>>>>>    Halt on errors apart from ETIME. Otherwise this way won't work.
>>>>>
>>>>> 3, smu_cmn_send_msg_without_waiting() for no waiting cases
>>>>>
>>>>>    Halt on errors apart from ETIME. Otherwise second way won't work.
>>>>>
>>>>> After halting, use BUG() to explicitly notify users.
>>>>>
>>>>> == Command Guide ==
>>>>>
>>>>> 1, enable SMU debug option
>>>>>
>>>>>   # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>>>>>
>>>>> 2, disable SMU debug option
>>>>>
>>>>>   # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
>>>>>
>>>>> v4:
>>>>>   - Set to halt state instead of a simple hang.(Christian)
>>>>>
>>>>> v3:
>>>>>   - Use debugfs_create_bool().(Christian)
>>>>>   - Put variable into smu_context struct.
>>>>>   - Don't resend command when timeout.
>>>>>
>>>>> v2:
>>>>>   - Resend command when timeout.(Lijo)
>>>>>   - Use debugfs file instead of module parameter.
>>>>>
>>>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  3 +++
>>>>>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h     |  5 +++++
>>>>>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 20
>>>>> +++++++++++++++++++-
>>>>>   3 files changed, 27 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> index 164d6a9e9fbb..86cd888c7822 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> @@ -1618,6 +1618,9 @@ int amdgpu_debugfs_init(struct
>>> amdgpu_device
>>>>> *adev)
>>>>>   	if (!debugfs_initialized())
>>>>>   		return 0;
>>>>>
>>>>> +	debugfs_create_bool("amdgpu_smu_debug", 0600, root,
>>>>> +				  &adev->smu.smu_debug_mode);
>>>>> +
>>>>>   	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>>>>   				  &fops_ib_preempt);
>>>>>   	if (IS_ERR(ent)) {
>>>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>> index f738f7dc20c9..50dbf5594a9d 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
>>>>> @@ -569,6 +569,11 @@ struct smu_context
>>>>>   	struct smu_user_dpm_profile user_dpm_profile;
>>>>>
>>>>>   	struct stb_context stb_context;
>>>>> +	/*
>>>>> +	 * When enabled, it makes SMU errors fatal.
>>>>> +	 * (0 = disabled (default), 1 = enabled)
>>>>> +	 */
>>>>> +	bool smu_debug_mode;
>>>> [Quan, Evan] Can you expand this to bit mask(as ppfeaturemask)? So that
>>> in future we can add support for other debug features.
>>>>>   };
>>> OK.
>>>
>>>>>   struct i2c_adapter;
>>>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> index 048ca1673863..84016d22c075 100644
>>>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
>>>>> @@ -272,6 +272,11 @@ int smu_cmn_send_msg_without_waiting(struct
>>>>> smu_context *smu,
>>>>>   	__smu_cmn_send_msg(smu, msg_index, param);
>>>>>   	res = 0;
>>>>>   Out:
>>>>> +	if (unlikely(smu->smu_debug_mode) && res && (res != -ETIME)) {
>>>>> +		amdgpu_device_halt(smu->adev);
>>>>> +		BUG();
>>>> [Quan, Evan] I agree amdgpu_device_halt() is a good idea. Christian and
>>> Andrey can share you more insights about that.
>>>> Do we still need the "BUG()" then?
>>> The BUG() is used to explicitly notify users something went wrong.
>>> Otherwise userspace may not know immediately.
>>> FW guys request this in ticket.
>> [Quan, Evan] Won't drm_dev_unplug() and pci_disable_device() used in amdgpu_device_halt throw some errors(on user's further attempt to communicate with our driver)?
>> Also if the purpose is to raise user's concern, WARN() may be a more gentle way?
>  From my testing and observation, it depends on what the driver will do next.
> Probably trigger a page fault. If we don't connect a monitor but SSH access.
> We don't know what happended until something like a page fault is triggered.
>
> But here what I want to do is throwing the error immediately to userspace.
> If using WARN(), the user need to poll dmesg to see if something went wrong.

I agree with Evan as well. Please use WARN() or WARN_ON() here instead.

BUG() and BUG_ON() is only allowed when you prevent further data 
corruption by intentionally crashing the kernel thread. But that is 
really invasive because for example locks are not necessarily dropped 
and so can crash the whole system.

Regards,
Christian.

>
> Regards,
> Lang
>
>> BR
>> Evan
>>> Regards,
>>> Lang
>>>
>>>> BR
>>>> Evan
>>>>> +	}
>>>>> +
>>>>>   	return res;
>>>>>   }
>>>>>
>>>>> @@ -288,9 +293,17 @@ int smu_cmn_send_msg_without_waiting(struct
>>>>> smu_context *smu,
>>>>>   int smu_cmn_wait_for_response(struct smu_context *smu)  {
>>>>>   	u32 reg;
>>>>> +	int res;
>>>>>
>>>>>   	reg = __smu_cmn_poll_stat(smu);
>>>>> -	return __smu_cmn_reg2errno(smu, reg);
>>>>> +	res = __smu_cmn_reg2errno(smu, reg);
>>>>> +
>>>>> +	if (unlikely(smu->smu_debug_mode) && res && (res != -ETIME)) {
>>>>> +		amdgpu_device_halt(smu->adev);
>>>>> +		BUG();
>>>>> +	}
>>>>> +
>>>>> +	return res;
>>>>>   }
>>>>>
>>>>>   /**
>>>>> @@ -357,6 +370,11 @@ int
>>> smu_cmn_send_smc_msg_with_param(struct
>>>>> smu_context *smu,
>>>>>   	if (read_arg)
>>>>>   		smu_cmn_read_arg(smu, read_arg);
>>>>>   Out:
>>>>> +	if (unlikely(smu->smu_debug_mode) && res) {
>>>>> +		amdgpu_device_halt(smu->adev);
>>>>> +		BUG();
>>>>> +	}
>>>>> +
>>>>>   	mutex_unlock(&smu->message_lock);
>>>>>   	return res;
>>>>>   }
>>>>> --
>>>>> 2.25.1

