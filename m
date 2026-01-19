Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84513D2ECE6
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 20:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 065C410E243;
	Mon, 19 Jan 2026 20:57:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bNpaWGNH";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F90F10E1EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 20:57:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yu3a+9jxhyAtLgrcU5C6CazgpcPzUTUh1M7xm1yBw8/qV32lFQ1UQDeiZmuPR8HWHA/FJMrmtZcewu/PfG3i9mZOJc95dV2GU9waBEiRY98CJOuxkOTjgJEZbnSg/EAAnvh7i8oS50l1UxipR8Z45SfsXt1f6xZkaECptnxwCMnIU5fgqb0WI62PdkHc1lNjOjWl1UiZX8MfdhFeVga/vEFf4uiyESQ5fXiVoJmwtvvnmuKML6XU8AVg8S3CPsfBRCZ8oahbi4qj3CEDDqfRf++dnArGp8qZDmAVyekUCAvW2NRbnpJfYxbem7lp/V1e6uSPvJWFlRQxRcPZCn1B8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xK9erJR7+Q3YYiCSnr3MDMHBQ+FtFxY2AvPLItG6UA=;
 b=yg2R1XDZSy+sCsXuQK/W72NI8cPtiBHo8GaNp6zRcHUjbh18X0BTqtgn5tLUvtfceTZ6DoHBppqjXjc4ciE2dmI8H5k72W+IK5oskj4p0pCiUtorpsc/Y9OMbCiJmKQ5b1pG04wUQkVQ0nSaynR/IOcmytx4JOwuN+pYWTBPauNnBbT5c1OjNYgubBkvnFQbMzD9WqPdTBk0nEGW4anbyaUfQRKrGkuFlbCzKbftIT1WioMFjNZZt1V/atauHSk2WsrxDVYqPRinwsAKl/ztvafBJb8KEfivSzHYwmyO1KmLADEZBfBCHE7rdlbuidZHKP7vYrtKegynXreej2d0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xK9erJR7+Q3YYiCSnr3MDMHBQ+FtFxY2AvPLItG6UA=;
 b=bNpaWGNHVPVeDvLnyfW3zQbJ7/dDzUpWbHh0qWOnhyMEM351tKSaZhSRjyg0Z2aOYdkv0X/k0MNbkU3PW6oxD2OsAsesNCuTJVceI27rIuW7HmrPhfnOHM71tDhyoZE5u1zlBaY7DGglu84bon3pYOTf2qTpNyo3AHjhPaRa4DQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Mon, 19 Jan
 2026 20:57:42 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%7]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 20:57:42 +0000
Content-Type: multipart/alternative;
 boundary="------------lEXy4uBA8E3mMmoGWno0tlt1"
Message-ID: <4012256e-1553-4737-95dc-732be663ff88@amd.com>
Date: Mon, 19 Jan 2026 15:57:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: add mask for debug trap flag setting
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Zhu, James" <James.Zhu@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Six, Lancelot" <Lancelot.Six@amd.com>
References: <20260119171503.624080-1-James.Zhu@amd.com>
 <CY8PR12MB74355E60D1AF872BD2E6E9DA8588A@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <CY8PR12MB74355E60D1AF872BD2E6E9DA8588A@CY8PR12MB7435.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR0101CA0271.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::32) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|DM4PR12MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b7951b-8122-40c3-8515-08de579d6337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|18082099003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDFwaVlYcXhURHJqQlZFOXBudmowbEVMUkpTZS9nM3prQVFiKzRkTWJOT0V5?=
 =?utf-8?B?WU5paHFjaVRIRER3ZDg0Nkl2QUNMYXFzMXlNODZCT1pZQW1xbnJZYXNFTGdM?=
 =?utf-8?B?UXRwTTFoL3JJNFBPeFF5SlRBNjJzc1BQZkoyeXRaL1lxYUQ3M2xSK2VMOXl3?=
 =?utf-8?B?cUMzRXZTTGxCRDEzOFd0TFMvTzhDVmMvRWIrSmxkTjNCMlBOSGlVYUY2OVFZ?=
 =?utf-8?B?ak5nYVNobUQ5cjQ2OUtBNkVtcmNLQ0cweFk2d2VnNWZCWEdtaXhwdEhmaGRX?=
 =?utf-8?B?MGtnSUdycnJiTmhlQ2hUWExRT1owUFlmR3hJSHNIdlJWYVBHQy9KanUrR3Fy?=
 =?utf-8?B?S3BNMXlxUWFmRDZodFFIMFNhazdlbGtJb1lXSXR0YS9hbFQweGFobEZnOFpM?=
 =?utf-8?B?a0lxY0ozY2M4ZzhBYTl5Ky82WVMxL3dCT1IyVS8vTHQ5SGhqbzhIWE8xSVhM?=
 =?utf-8?B?dlhYSXZkYXRpM2FwT3hxS0ROV3c2SFNsUTB1cjVoYmZiVDhEbG9JdjJSZm5P?=
 =?utf-8?B?dFF0ek1lWit0WDhZNnhKQ3ZZMmlDWHd4QVJyeFJDYkZKcjNpRmJNS0EvbkQr?=
 =?utf-8?B?MFNlMnpTNExpbUpibi9pcEppcWFIbWZrVlp3bENZSFBQVkw5a1ZURXY1NnF6?=
 =?utf-8?B?Q1duNVl6M1p1R0lzbmdqSmh2ZU8yWUVlWlRkcGV6MkRQd3ZwRFNMcmEwTEVu?=
 =?utf-8?B?S0J5NWVpVUdFaWt0UmxzMWg0TkU4UENJSUJOcld1cy9vd0FPU3lhem90enNh?=
 =?utf-8?B?VmhkZExvcmxLNk9xZGp5MDR0MDh2SmV4bjZ2Q3p1dW5OTmpuK01SQmxKRUhO?=
 =?utf-8?B?bDZ4dzlWanRQMnlDanFnalE3STUxTXRxUXRzdHpUOVY0RTVaWXpBaGRGMlBJ?=
 =?utf-8?B?WjhkZkNGMWd0dlAxKzdubDQ0Ym5yOVBsSkxyQ0FCalZXMmoySXIzWi9MWm9V?=
 =?utf-8?B?bkRraUcyb0JxZURZN1d6S2JlblpjUTdLcEFOQmo2a3E3amtsUk0zSW96Vzcw?=
 =?utf-8?B?aEQ3akViYi96Y1pTS1VTV1R3dmt3L0plZnVXUGE1bWFrSUVBTnAzNXNITUJS?=
 =?utf-8?B?WXlsdWZzbHNyQlkrd05ha1RoVTZ6QTVjcjlJSlAwaVF2MTJUOWpkZ01rM0Vu?=
 =?utf-8?B?OEpRaGdPV2t0N2JkYVpZSjQ3cUpxUk55SURhemE2clZ1dGxmVS9oUldwNG9P?=
 =?utf-8?B?ZDRRRnBaWGgvZ1VGc3hpaStSbk5wcFErNnNKbVY0VGdTbmlQNlhnc1ZjQVNW?=
 =?utf-8?B?bXBnVm9NYWZZakxBaEJrY3Zoc2RzS1VReUJ6RlpuRTBSNEdnR3NZSU9UZVpy?=
 =?utf-8?B?QzJ6aGRtL3NHUm1PMkViUWd3ZWdUMkE2VVgvUnlKY2hKektzeWtid29zbEQz?=
 =?utf-8?B?dHVXL0JHRXdaTXFpcE0rV3dVaGxxRG5EZFBRRGZSR21LeXBFTDMwQ0h5Y05l?=
 =?utf-8?B?bWNrT05yR1VJVkRmNzRWY2wxaWwrN2FvclRBT2k1WUhsNGI5NGs3aTlRRStR?=
 =?utf-8?B?TkJacWEzNEE1MkdiVkdiKytZOE9lNVR3QWp5ZDNSdUhrOFFla0d6eE9IdGVj?=
 =?utf-8?B?RithY2UvZklpcUNzUEZ0WFBaa3JhN3ZKZ29uSm1CazFPMk9qR2tmMUU5d285?=
 =?utf-8?B?N3JDNWhhb1haeVpqMVdzVUpvTGVvYU9RQVR2RHAxQTljQmJkSUxxcU9ObFUr?=
 =?utf-8?B?bUhmTGxibjlENGJSOVQrd3dSRTNqVVNPbFBzR254bGROOXpheENIUU00aFE2?=
 =?utf-8?B?Skh4d2RVWTVpblpubGgzZGk2VFBHb3RmclZ6Vm5MV3lTZWFyK0llSU9OczhF?=
 =?utf-8?B?YkcveVo0NXZmNko1K05qQlFpRStxZVlNUnNCd1l3OWF2QW83NnFad1kzZ09S?=
 =?utf-8?B?MkJ6OTFjK3lya3hLWncwMXdXTnk0VTc0aUJ4akxCbmlMc3JXbVdpT2ZNdUtU?=
 =?utf-8?B?R0w3d3czYWM0Y1dlMDdQbFB2VUZIeEg4R21kUVNrWmFwdDBKVFd6MDltY2Ri?=
 =?utf-8?B?YjlqaWRBa29JZThUN1hRREMxeGFNaGV6azFmdHdnbU5uN3dNU1YyWVdNVWt1?=
 =?utf-8?B?MTVZTkJOdC91OG1hZ3FzdHBKRTNVdnB3UjlYOVRTTEFDQjkrUjhuOG84UFY3?=
 =?utf-8?Q?FuTk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(18082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emU0ejNMZmtBb1BDbG1XaDVqVkY5NytrTC9rUWFOblNSMFFENldNaGJnZ1hD?=
 =?utf-8?B?QTQ1TWJXUkU1OVRWaWRveEg2RGpWWGNvRmF0elV2SlNIQWFpT2o0cGpTZWF4?=
 =?utf-8?B?RlQvYVJ1NXJpRDNHUjQ4VnN6R1V4aFBORWdnYW9zZ3FMTFdLRmFzMnJ4UkNs?=
 =?utf-8?B?SUZxNjlTM3EzSVF3L1lNWnlqRFNKOGx2ZWtTd2pPckZ1bzFFb0pvcC9qV2pj?=
 =?utf-8?B?VUdtMk9NQzZxc0JmeTdUSVJkdUpmMzRLcXp0NGQxaFhhdUZ4cndNaXhaUzM5?=
 =?utf-8?B?SkZLczFFUEdQU2h3L0wza3ZpZlBWaU42NWcxU0t2emx1T0QxU2ZEMkNBL0dW?=
 =?utf-8?B?L3FmRk9tbktkRkttTE0rUVE3ZXRrMGtUSEx2cXZhajVNMlBwZnJHWWJock5z?=
 =?utf-8?B?T0VaTFI3UzFnTXdrZ0MxRmt0cjBSTE4vTmFvcnlMVStESnZkdkVHZWtVeW1w?=
 =?utf-8?B?YVozaGFhcFlRZUtPdVJFOEhBazF4VE1kMmZmbkdyQUNROGEwbFZFQWtoaGhF?=
 =?utf-8?B?V3lSbEwxcVlqUmZpeVVIYzNOTjQzLzA4aGxlaTMrTmxmdmwvUXdCRTE2MmpK?=
 =?utf-8?B?dk9zdHdHaFd3MldqTi9panl3eExiOXRlTy9YMGhKVkhQeXJRc25sN0FVSGtW?=
 =?utf-8?B?dHYzdnlyL1hzR1RpRFJLbDhZV1ZYa1MwNHlHcEtoRnAwcWZlZm1kdFA1aXRz?=
 =?utf-8?B?M3hUV05XcXB1OUFtZXcwRW9vN1JBUExvT25lbW1aaDBYaWlNblRPT1REK0Jn?=
 =?utf-8?B?V3p6V3BOSHRaV2U4aUM2aElBU1hjdGQ5V0dTNWNxajBQaGNiS0swRkhXOHNS?=
 =?utf-8?B?SGNVZGpWUEhrQ1Q5MlgyL2JZVWVlM3Y5dUtXdUFpU01PM0ttbGtPYkRIaW9a?=
 =?utf-8?B?cWIzNTBHdVE3WjA1YTdnR2t3ak9JTTlQd0w4NXBRZjdmM2FOM09UN29FTG9J?=
 =?utf-8?B?N1RIdTFuZjVXK3hSbnpsYTk3VFUxY0RDT0lMY2FlNnJpNWw3Z3E5b2xOR1Z5?=
 =?utf-8?B?cXRIRFlXSmVaRmEvN1NvS2tiaFVFWENYeGhVQzVKQUNyNlRvYWtZRUJmSVdv?=
 =?utf-8?B?VGliUm84VlJmK3Y2MGhzNisvM2dYbk5KdHBiSGZlaEp3RGVZMVJQbzUzUVJR?=
 =?utf-8?B?a20wenROR2xTUGhZZXpnNlZERzllUndyZDZTSGs4a2hYL1J6NFpFSm1GRFFp?=
 =?utf-8?B?SjdTekVVcThzUWtPcVRseUtjYU1Sbm03THRTd0NQaHlqS2h4NDY4RUdEZExQ?=
 =?utf-8?B?RElUK2V6OUp2TnoxLzBTcnhXdmlKUU5ibUtRc1V0VDk2QjlxTTdXTmsyMzFB?=
 =?utf-8?B?VUJDMzY3T05RU0lGWGE0NlFjblJsakh3MXRZc244ZXJYUzRQYWIyYWFJZ0hs?=
 =?utf-8?B?RkhETUJ1a2hXRHNBQTNqc0J6MW1jNjE2RDdVMHdFSTJaU2RQelhYbmRONVha?=
 =?utf-8?B?ZkVNdXRnZFM1bWU4cTB6ZTI0b2U3VW1vMVE3UUwxdHdaQjBjSldjYWRYbTlv?=
 =?utf-8?B?cTY3aS9EU2E0RzBrMEZjK3BzcG5YSmxvL1B5RE1iODRuN3RscURqbHVRUUZj?=
 =?utf-8?B?UFErT1pwbDRMdGcyYzFoeXVUdkF2dlFjWi9wRTA0Ri9RcHhVK1RFTXZBeWhl?=
 =?utf-8?B?UCtKZ2c1aE92cEFIMTJ1M2JmNkVjTlF1N0RIRXFLb3dQRzNMdjFlTnlhYUpW?=
 =?utf-8?B?RGxRV0doeDRBWWNxZjVIWVdwU0xGdTU3RnFvWG4xVzB6YnJubmF0QUdsSUs2?=
 =?utf-8?B?eHUwS05mdjZWaEJXTG5MTkxqOFErZGU3dXZxaStWbE5nWGNEMmRzWHN4amZW?=
 =?utf-8?B?M0NxTmNFdTFwQ1BBaDgzUTV3ZHI0MTdGTk81TlJNSW4xQzRBempsNUExdnRV?=
 =?utf-8?B?N2tjNHlvV0dqRlhRWEJXUG9uQkRkYys1aUtWYkU5TkZDT2xKMXNmWml0SW92?=
 =?utf-8?B?VEVkNXh1b1JOT2ErYnRsVzExeFNZRjVuSG93Z2NOQTVmYzg0QmR3aFFNOUFi?=
 =?utf-8?B?b2dpOW5yc3pacm9aM2FVQTJMMS9pWFlzSlh6dGwzdllXM3NicGNFbkwzQ3k2?=
 =?utf-8?B?aDd4QUk2UjdZZEF5UFFocG5kcDJBbEJZOEFsdXB3aEo4VzY5MHAxZk94dU9I?=
 =?utf-8?B?Q0RyZ2M3dG1GZndwOXpHelRQcngvYlFWQk41MTcxeEJ5clM2U1RDK0RjSmpI?=
 =?utf-8?B?SjFIUXg1T3hwZTc5bkhoNGtBL0x1VVJISWgxeVByQjN1aWxGV3NwcVY3VzBm?=
 =?utf-8?B?VjQvalNGMVArQWNZMjc1UWwxYUd0U0hoejJqZ251ZWgyYXhBaUp2TDFIa25i?=
 =?utf-8?Q?J9vIeweqf9KRA1JVcB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b7951b-8122-40c3-8515-08de579d6337
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:57:42.1648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpY/kagndTHXYJMXpJTyMALWzO0kfUm15jSj4z8Nf3f0vWYv3WTkX5oHzkPOFDZy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6085
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

--------------lEXy4uBA8E3mMmoGWno0tlt1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jon,

thanks!

Answers are in line.

Best Regards!

James Zhu

On 2026-01-19 14:28, Kim, Jonathan wrote:
> [Public]
>
>> -----Original Message-----
>> From: Zhu, James<James.Zhu@amd.com>
>> Sent: Monday, January 19, 2026 12:15 PM
>> To:amd-gfx@lists.freedesktop.org
>> Cc: Six, Lancelot<Lancelot.Six@amd.com>; Kim, Jonathan
>> <Jonathan.Kim@amd.com>; Zhu, James<James.Zhu@amd.com>
>> Subject: [PATCH] drm/amdkfd: add mask for debug trap flag setting
>>
>> to specify which bits are valid setting on flags.
> Can you elaborate?
> Without mask setting, Need read current flags 1st, any update flags'

specified bits, others bits keep unchanged, then send absolute flags 
value to  system.

mask can indicate which bits in flags are need to been touched, we can 
put value(0 or 1) into

those specified bits, and send to system directly without read back 
operation.
For example. flags = 0x2 mask =0x3, will keep MSB31-MSB2 unchanged, LSB1 
set to 1,LSB0 set 0.

Will update  messages to:

*/apply masked bit update on debug trap flags/*

*/The implementation uses an XOR-AND-XOR pattern to atomically update 
bits within the 'set_flags->mask' range./*

*/Logic: /*

*/- Difference: (target_flags->flags ^ set_flags->flags) identifies bit 
mismatches. /*

*/- Filtering: The result is masked by 'set_flags->mask' to restrict 
changes. /*

*/- Application: XORing back to 'target_flags->flags' flips only the 
mismatched bits to the desired state./*

*/This approach avoids multiple assignment steps and preserves all bits 
outside of the mask./*

>
>> Signed-off-by: James Zhu<James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 48 ++++++++++++------------
>>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  3 +-
>>   include/uapi/linux/kfd_ioctl.h           |  3 +-
>>   4 files changed, 30 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 79586abad7fd..fd43ef7c9076 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -3377,7 +3377,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep,
>> struct kfd_process *p, v
>>                                args->clear_node_address_watch.id);
>>                break;
>>        case KFD_IOC_DBG_TRAP_SET_FLAGS:
>> -             r = kfd_dbg_trap_set_flags(target, &args->set_flags.flags);
>> +             r = kfd_dbg_trap_set_flags(target, &args->set_flags);
>>                break;
>>        case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
>>                r = kfd_dbg_ev_query_debug_event(target,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> index a04875236647..279160ca71a9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>> @@ -512,38 +512,42 @@ static void
>> kfd_dbg_clear_process_address_watch(struct kfd_process *target)
>>                        kfd_dbg_trap_clear_dev_address_watch(target-
>>> pdds[i], j);
>>   }
>>
>> -int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
>> +int kfd_dbg_trap_set_flags(struct kfd_process *target,
>> +     struct kfd_ioctl_dbg_trap_set_flags_args *set_flags)
>>   {
>>        uint32_t prev_flags = target->dbg_flags;
>>        int i, r = 0, rewind_count = 0;
>>
>> +     if (!((set_flags->flags ^ prev_flags) & set_flags->mask))
> Does this block old debuggers from setting debug mode if pad is 0?
> [JZ] Yes, this logical can been moved down after target->dbg_flags gets updated
> if (target->dbg_flags == prev_flags) return 0;
>> +             return 0;
>> +
>>        for (i = 0; i < target->n_pdds; i++) {
>>                struct kfd_topology_device *topo_dev =
>>                                kfd_topology_device_by_id(target->pdds[i]-
>>> dev->id);
>>                uint32_t caps = topo_dev->node_props.capability;
>>                uint32_t caps2 = topo_dev->node_props.capability2;
>> +             struct amdgpu_device *adev = target->pdds[i]->dev->adev;
>>
>> -             if (!(caps &
>> HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
>> -                     (*flags & KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
>> -                     *flags = prev_flags;
>> -                     return -EACCES;
>> -             }
>> -
>> -             if (!(caps &
>> HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &&
>> -                 (*flags & KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP)) {
>> -                     *flags = prev_flags;
>> -                     return -EACCES;
>> -             }
>> -
>> -             if (!(caps2 &
>> HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED) &&
>> -                 (*flags &
>> KFD_DBG_TRAP_FLAG_LDS_OUT_OF_ADDR_RANGE)) {
>> -                     *flags = prev_flags;
>> +             if (set_flags->mask == 0xFFFFFFFF && !set_flags->flags)
>> +                     break;
> Seems like this is only for a deactivation system call.
> Probably don't want to let users abuse this with a magic number then.
> Maybe breakout into new static call in deactivation or just device loop deactivate directly there since this logic is starting to get complicated.
[JZ] Yes, only for deactivation system call.
>
>> +             if ((!(caps &
>> HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &&
>> +                     (set_flags->mask &
>> KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) ||
>> +                     (!(caps &
>> HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &&
>> +                 (set_flags->mask & KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP))
>> ||
>> +                     (!(caps2 &
>> HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED) &&
>> +                 (set_flags->mask &
>> KFD_DBG_TRAP_FLAG_LDS_OUT_OF_ADDR_RANGE))) {
> Please vertically indent align "caps" and "set_flags" underneath each other for legibility.
[JZ] sure
>
>> +                     set_flags->flags = prev_flags;
>> +                     dev_dbg(adev->dev, "Debug Trap set mask 0x%x caps
>> 0x%x caps2 0x%x",
>> +                             set_flags->mask, caps, caps2);
>>                        return -EACCES;
>>                }
>>        }
>>
>> -     target->dbg_flags = *flags;
>> -     *flags = prev_flags;
>> +     target->dbg_flags ^= (target->dbg_flags ^ set_flags->flags) & set_flags-
>>> mask;
> I assume we can only set/unset 1 flag at a time, which is why this works.
> Otherwise, maybe I don't have enough background on this, but please do elaborate.

[JZ] Here is not just for set/unset 1 bit. ^ is bitwise XOR.

target->dbg_flags ^ set_flags->flags can find which bits are changed

(set those bits to 1 if not equal), & set_flags-mask can filter out 
unrelated bits.

target->dbg_flags ^= can change related bits accordingly.

> mask

>
>> +     pr_debug("Debug Trap previous flags 0x%x set flags 0x%x set mask 0x%x
>> target flags 0x%x",
>> +             prev_flags, set_flags->flags, set_flags->mask, target-
>>> dbg_flags);
>> +
>> +     set_flags->flags = prev_flags;
>>        for (i = 0; i < target->n_pdds; i++) {
>>                struct kfd_process_device *pdd = target->pdds[i];
>>
>> @@ -555,10 +559,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target,
>> uint32_t *flags)
>>                else
>>                        r = kfd_dbg_set_mes_debug_mode(pdd, true);
>>
>> -             if (r) {
>> -                     target->dbg_flags = prev_flags;
> Doesn't rewind require the previous value for something to rewind to?
[JZ] Yes, since after break,  it will rewind flags over there when check 
r value at the end.
>
>> +             if (r)
>>                        break;
>> -             }
>>
>>                rewind_count++;
>>        }
>> @@ -596,7 +598,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target,
>> bool unwind, int unwind
>>        int i;
>>
>>        if (!unwind) {
>> -             uint32_t flags = 0;
>> +             struct kfd_ioctl_dbg_trap_set_flags_args set_flags = {0,
>> 0xFFFFFFFF};
> Similar to 3 comments above.  Just call a new static or loop directly to reset debug mode (i.e. all flags clear).
> i.e. you don't have to rewind on preemption failure here because deactivation itself is a rewind we're pretty much out of luck at this point if we fail.
[JZ] I will send out v2 soon, See if your concern gets addressed or not.
>
> Jon
>
>>                int resume_count = resume_queues(target, 0, NULL);
>>
>>                if (resume_count)
>> @@ -606,7 +608,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target,
>> bool unwind, int unwind
>>                kfd_dbg_clear_process_address_watch(target);
>>                kfd_dbg_trap_set_wave_launch_mode(target, 0);
>>
>> -             kfd_dbg_trap_set_flags(target, &flags);
>> +             kfd_dbg_trap_set_flags(target, &set_flags);
>>        }
>>
>>        for (i = 0; i < target->n_pdds; i++) {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
>> index 894753818cba..34d27eb500a5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
>> @@ -62,7 +62,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct
>> kfd_process_device *pdd,
>>                                        uint32_t watch_address_mask,
>>                                        uint32_t *watch_id,
>>                                        uint32_t watch_mode);
>> -int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags);
>> +int kfd_dbg_trap_set_flags(struct kfd_process *target,
>> +             struct kfd_ioctl_dbg_trap_set_flags_args *set_flags);
>>   int kfd_dbg_trap_query_exception_info(struct kfd_process *target,
>>                uint32_t source_id,
>>                uint32_t exception_code,
>> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
>> index e9b756ca228c..0522fe7344e4 100644
>> --- a/include/uapi/linux/kfd_ioctl.h
>> +++ b/include/uapi/linux/kfd_ioctl.h
>> @@ -1515,6 +1515,7 @@ struct
>> kfd_ioctl_dbg_trap_clear_node_address_watch_args {
>>    *     Sets flags for wave behaviour.
>>    *
>>    *     @flags (IN/OUT) - IN = flags to enable, OUT = flags previously enabled
>> + *     @mask  (IN)     - IN = specified debug trap operation bits on flag
>>    *
>>    *     Generic errors apply (see kfd_dbg_trap_operations).
>>    *     Return - 0 on SUCCESS.
>> @@ -1522,7 +1523,7 @@ struct
>> kfd_ioctl_dbg_trap_clear_node_address_watch_args {
>>    */
>>   struct kfd_ioctl_dbg_trap_set_flags_args {
>>        __u32 flags;
>> -     __u32 pad;
>> +     __u32 mask;
>>   };
>>
>>   /**
>> --
>> 2.34.1
--------------lEXy4uBA8E3mMmoGWno0tlt1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Jon,</p>
    <p>thanks!</p>
    <p>Answers are in line.</p>
    <p>Best Regards!</p>
    <p>James Zhu<br>
    </p>
    <div class="moz-cite-prefix">On 2026-01-19 14:28, Kim, Jonathan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CY8PR12MB74355E60D1AF872BD2E6E9DA8588A@CY8PR12MB7435.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">[Public]

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Sent: Monday, January 19, 2026 12:15 PM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Six, Lancelot <a class="moz-txt-link-rfc2396E" href="mailto:Lancelot.Six@amd.com">&lt;Lancelot.Six@amd.com&gt;</a>; Kim, Jonathan
<a class="moz-txt-link-rfc2396E" href="mailto:Jonathan.Kim@amd.com">&lt;Jonathan.Kim@amd.com&gt;</a>; Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Subject: [PATCH] drm/amdkfd: add mask for debug trap flag setting

to specify which bits are valid setting on flags.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Can you elaborate?
Without mask setting, Need read current flags 1st, any update flags'</pre>
    </blockquote>
    <p>specified bits, others bits keep unchanged, then send absolute
      flags value to&nbsp; system.</p>
    <p>mask can indicate which bits in flags are need to been touched,
      we can put value(0 or 1) into&nbsp;</p>
    <p>those specified bits, and send to system directly without read
      back operation.<br>
      For example. flags = 0x2 mask =0x3, will keep MSB31-MSB2
      unchanged, LSB1 set to 1,LSB0 set 0.<br>
      <br>
      Will update&nbsp; messages to:<br>
      <br>
      <b><i>apply masked bit update on <span style="white-space: pre-wrap">debug trap flags</span></i></b></p>
    <p><b><i>
          The implementation uses an XOR-AND-XOR pattern to atomically
          update bits within the 'set_flags-&gt;mask' range.</i></b></p>
    <p><b><i>Logic:&nbsp;</i></b></p>
    <p><b><i>- Difference: (target_flags-&gt;flags ^
          set_flags-&gt;flags) identifies bit mismatches.&nbsp;</i></b></p>
    <p><b><i>- Filtering: The result is masked by 'set_flags-&gt;mask'
          to restrict changes.&nbsp;</i></b></p>
    <p><b><i>- Application: XORing back to 'target_flags-&gt;flags'
          flips only the mismatched bits to the desired state.</i></b></p>
    <p><b><i>This approach avoids multiple assignment steps and
          preserves all bits outside of the mask.</i></b></p>
    <blockquote type="cite" cite="mid:CY8PR12MB74355E60D1AF872BD2E6E9DA8588A@CY8PR12MB7435.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 48 ++++++++++++------------
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  3 +-
 include/uapi/linux/kfd_ioctl.h           |  3 +-
 4 files changed, 30 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 79586abad7fd..fd43ef7c9076 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3377,7 +3377,7 @@ static int kfd_ioctl_set_debug_trap(struct file *filep,
struct kfd_process *p, v
                              args-&gt;clear_node_address_watch.id);
              break;
      case KFD_IOC_DBG_TRAP_SET_FLAGS:
-             r = kfd_dbg_trap_set_flags(target, &amp;args-&gt;set_flags.flags);
+             r = kfd_dbg_trap_set_flags(target, &amp;args-&gt;set_flags);
              break;
      case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
              r = kfd_dbg_ev_query_debug_event(target,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index a04875236647..279160ca71a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -512,38 +512,42 @@ static void
kfd_dbg_clear_process_address_watch(struct kfd_process *target)
                      kfd_dbg_trap_clear_dev_address_watch(target-
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">pdds[i], j);
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre"> }

-int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
+int kfd_dbg_trap_set_flags(struct kfd_process *target,
+     struct kfd_ioctl_dbg_trap_set_flags_args *set_flags)
 {
      uint32_t prev_flags = target-&gt;dbg_flags;
      int i, r = 0, rewind_count = 0;

+     if (!((set_flags-&gt;flags ^ prev_flags) &amp; set_flags-&gt;mask))
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Does this block old debuggers from setting debug mode if pad is 0?</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:CY8PR12MB74355E60D1AF872BD2E6E9DA8588A@CY8PR12MB7435.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">[JZ] Yes, this logical can been moved down after target-&gt;dbg_flags gets updated
if (target-&gt;dbg_flags == prev_flags) return 0;</pre>
    </blockquote>
    <blockquote type="cite" cite="mid:CY8PR12MB74355E60D1AF872BD2E6E9DA8588A@CY8PR12MB7435.namprd12.prod.outlook.com">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+             return 0;
+
      for (i = 0; i &lt; target-&gt;n_pdds; i++) {
              struct kfd_topology_device *topo_dev =
                              kfd_topology_device_by_id(target-&gt;pdds[i]-
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">dev-&gt;id);
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">              uint32_t caps = topo_dev-&gt;node_props.capability;
              uint32_t caps2 = topo_dev-&gt;node_props.capability2;
+             struct amdgpu_device *adev = target-&gt;pdds[i]-&gt;dev-&gt;adev;

-             if (!(caps &amp;
HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &amp;&amp;
-                     (*flags &amp; KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) {
-                     *flags = prev_flags;
-                     return -EACCES;
-             }
-
-             if (!(caps &amp;
HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &amp;&amp;
-                 (*flags &amp; KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP)) {
-                     *flags = prev_flags;
-                     return -EACCES;
-             }
-
-             if (!(caps2 &amp;
HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED) &amp;&amp;
-                 (*flags &amp;
KFD_DBG_TRAP_FLAG_LDS_OUT_OF_ADDR_RANGE)) {
-                     *flags = prev_flags;
+             if (set_flags-&gt;mask == 0xFFFFFFFF &amp;&amp; !set_flags-&gt;flags)
+                     break;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Seems like this is only for a deactivation system call.
Probably don't want to let users abuse this with a magic number then.
Maybe breakout into new static call in deactivation or just device loop deactivate directly there since this logic is starting to get complicated.</pre>
    </blockquote>
    [JZ] Yes, only for <span style="white-space: pre-wrap">deactivation system call</span>.
    <blockquote type="cite" cite="mid:CY8PR12MB74355E60D1AF872BD2E6E9DA8588A@CY8PR12MB7435.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+             if ((!(caps &amp;
HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED) &amp;&amp;
+                     (set_flags-&gt;mask &amp;
KFD_DBG_TRAP_FLAG_SINGLE_MEM_OP)) ||
+                     (!(caps &amp;
HSA_CAP_TRAP_DEBUG_PRECISE_ALU_OPERATIONS_SUPPORTED) &amp;&amp;
+                 (set_flags-&gt;mask &amp; KFD_DBG_TRAP_FLAG_SINGLE_ALU_OP))
||
+                     (!(caps2 &amp;
HSA_CAP2_TRAP_DEBUG_LDS_OUT_OF_ADDR_RANGE_SUPPORTED) &amp;&amp;
+                 (set_flags-&gt;mask &amp;
KFD_DBG_TRAP_FLAG_LDS_OUT_OF_ADDR_RANGE))) {
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Please vertically indent align &quot;caps&quot; and &quot;set_flags&quot; underneath each other for legibility.</pre>
    </blockquote>
    [JZ] sure<br>
    <blockquote type="cite" cite="mid:CY8PR12MB74355E60D1AF872BD2E6E9DA8588A@CY8PR12MB7435.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+                     set_flags-&gt;flags = prev_flags;
+                     dev_dbg(adev-&gt;dev, &quot;Debug Trap set mask 0x%x caps
0x%x caps2 0x%x&quot;,
+                             set_flags-&gt;mask, caps, caps2);
                      return -EACCES;
              }
      }

-     target-&gt;dbg_flags = *flags;
-     *flags = prev_flags;
+     target-&gt;dbg_flags ^= (target-&gt;dbg_flags ^ set_flags-&gt;flags) &amp; set_flags-
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">mask;
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I assume we can only set/unset 1 flag at a time, which is why this works.
Otherwise, maybe I don't have enough background on this, but please do elaborate.</pre>
    </blockquote>
    <p>[JZ] Here is not just for set/unset 1 bit.&nbsp;&nbsp; <span style="color: rgb(32, 33, 34); font-family: sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(248, 249, 250); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">^
        is bitwise XOR<span> .</span></span></p>
    <p><span style="color: rgb(32, 33, 34); font-family: sans-serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(248, 249, 250); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;"><span>&nbsp;</span></span><span style="white-space: pre-wrap">target-&gt;dbg_flags ^ set_flags-&gt;flags can find which bits are changed</span></p>
    <p><span style="white-space: pre-wrap">(set those bits to 1 if not equal), </span><span style="white-space: pre-wrap">&amp; set_flags-mask can filter out unrelated bits.</span></p>
    <p><span style="white-space: pre-wrap"> target-&gt;dbg_flags ^= can change related bits accordingly.</span></p>
    <blockquote type="cite">
      <pre wrap="" class="moz-quote-pre">mask</pre>
    </blockquote>
    <p></p>
    <blockquote type="cite" cite="mid:CY8PR12MB74355E60D1AF872BD2E6E9DA8588A@CY8PR12MB7435.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+     pr_debug(&quot;Debug Trap previous flags 0x%x set flags 0x%x set mask 0x%x
target flags 0x%x&quot;,
+             prev_flags, set_flags-&gt;flags, set_flags-&gt;mask, target-
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">dbg_flags);
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">+
+     set_flags-&gt;flags = prev_flags;
      for (i = 0; i &lt; target-&gt;n_pdds; i++) {
              struct kfd_process_device *pdd = target-&gt;pdds[i];

@@ -555,10 +559,8 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target,
uint32_t *flags)
              else
                      r = kfd_dbg_set_mes_debug_mode(pdd, true);

-             if (r) {
-                     target-&gt;dbg_flags = prev_flags;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Doesn't rewind require the previous value for something to rewind to?</pre>
    </blockquote>
    [JZ] Yes, since after break,&nbsp; it will rewind flags over there when
    check r value at the end.<br>
    <blockquote type="cite" cite="mid:CY8PR12MB74355E60D1AF872BD2E6E9DA8588A@CY8PR12MB7435.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+             if (r)
                      break;
-             }

              rewind_count++;
      }
@@ -596,7 +598,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target,
bool unwind, int unwind
      int i;

      if (!unwind) {
-             uint32_t flags = 0;
+             struct kfd_ioctl_dbg_trap_set_flags_args set_flags = {0,
0xFFFFFFFF};
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Similar to 3 comments above.  Just call a new static or loop directly to reset debug mode (i.e. all flags clear).
i.e. you don't have to rewind on preemption failure here because deactivation itself is a rewind we're pretty much out of luck at this point if we fail.</pre>
    </blockquote>
    [JZ] I will send out v2 soon, See if your concern gets addressed or
    not.<br>
    <blockquote type="cite" cite="mid:CY8PR12MB74355E60D1AF872BD2E6E9DA8588A@CY8PR12MB7435.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">

Jon

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">              int resume_count = resume_queues(target, 0, NULL);

              if (resume_count)
@@ -606,7 +608,7 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target,
bool unwind, int unwind
              kfd_dbg_clear_process_address_watch(target);
              kfd_dbg_trap_set_wave_launch_mode(target, 0);

-             kfd_dbg_trap_set_flags(target, &amp;flags);
+             kfd_dbg_trap_set_flags(target, &amp;set_flags);
      }

      for (i = 0; i &lt; target-&gt;n_pdds; i++) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 894753818cba..34d27eb500a5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -62,7 +62,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct
kfd_process_device *pdd,
                                      uint32_t watch_address_mask,
                                      uint32_t *watch_id,
                                      uint32_t watch_mode);
-int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags);
+int kfd_dbg_trap_set_flags(struct kfd_process *target,
+             struct kfd_ioctl_dbg_trap_set_flags_args *set_flags);
 int kfd_dbg_trap_query_exception_info(struct kfd_process *target,
              uint32_t source_id,
              uint32_t exception_code,
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index e9b756ca228c..0522fe7344e4 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -1515,6 +1515,7 @@ struct
kfd_ioctl_dbg_trap_clear_node_address_watch_args {
  *     Sets flags for wave behaviour.
  *
  *     @flags (IN/OUT) - IN = flags to enable, OUT = flags previously enabled
+ *     @mask  (IN)     - IN = specified debug trap operation bits on flag
  *
  *     Generic errors apply (see kfd_dbg_trap_operations).
  *     Return - 0 on SUCCESS.
@@ -1522,7 +1523,7 @@ struct
kfd_ioctl_dbg_trap_clear_node_address_watch_args {
  */
 struct kfd_ioctl_dbg_trap_set_flags_args {
      __u32 flags;
-     __u32 pad;
+     __u32 mask;
 };

 /**
--
2.34.1
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------lEXy4uBA8E3mMmoGWno0tlt1--
