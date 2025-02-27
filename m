Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDCBC19F2E
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 16:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2B3510E305;
	Thu, 27 Feb 2025 16:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Oe0xc4gl";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E5010EB39
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 16:50:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tralQI9uDmOUBysF/OAOxpHG9dSCPTGXo9/eAZZdVZ4vHbv78S0pvxgl/NTUMDGovg1ncs54sn3RRbSlfs8TPbvnbJcSEboHXlwbBeNLIlUAXNWG3Yx2ynOXwfrMVOdgKizStBf6CAhURAGcq1V9F4cANVnGSw+TbUduN1hJuX6F3BzMZyabHqS/CFBnLELa8QyhwahbSCcvA6Yk2Nqp4e7+xyakYXFuCT+ifzrJxo8tZ8nusycP7XXoKOBtRoWmn8mLhLsXv0sj/9T/sI+NI5T5AeEDyq0iNVgnrIxuE4tYp1qwqT09ckR5uvrCOKaY+hg+2r2wIp+oqRTNF+93Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsYGNhTU99rOBhTtIvUvLJrJYfIx99eiIk/CE4F5Hq8=;
 b=vHSKp7QFaphtpD5oDwkW/xmkrsz/NXsVlVg6KVhbr2JXcLnDlpanS4YE9FeKI2BOGtZ5ym5aT25Led4DyFbshGJVVK8nDLV6x0Lw111X3xrxcQdl9HLque3Mu8DbALJ30KnTk3jLNFFfBWArGOhUCv/MG8yVUHa5bmERaqbODq/dUpWMedC5ipbvbmzjmKEcC5nwh1tWEffvlKrntaOpwC1K5tkgCbkpOgZSTe5WujCjZ/hx2JBEhmXWaGZ/3ZVkDu9GX/FRVXn6/GwYuM5u5PiTzMuxUddw5sXmc0O+i5KH0JVn6nGd1N8d0H6NwNQululvQoMgVZOffLVFiTYqdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsYGNhTU99rOBhTtIvUvLJrJYfIx99eiIk/CE4F5Hq8=;
 b=Oe0xc4glbEY98Gbed69Wg7Lr/aYZO+03TEx47Sl/iGpMxnX5HgPo7jJJTePhd/rQzHyMHHcnw0MCpFz//qE8bKx7665vAGxFVa9Ej0zDa64PT65LUMxS46U36PTMTRmo00HA45HgGhUArllZbo48omG+YZm4botvlelldXn5nuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) by
 PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 16:50:27 +0000
Received: from DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7]) by DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7%6]) with mapi id 15.20.8466.020; Thu, 27 Feb 2025
 16:50:27 +0000
Message-ID: <b40bb378-4651-45b2-b475-27b4076f94e2@amd.com>
Date: Thu, 27 Feb 2025 10:50:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Fix instruction hazard in gfx12 trap
 handler
To: amd-gfx@lists.freedesktop.org
Cc: Lancelot Six <lancelot.six@amd.com>
References: <20250207233837.2738432-1-jay.cornwall@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <20250207233837.2738432-1-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0189.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::15) To DS0PR12MB8413.namprd12.prod.outlook.com
 (2603:10b6:8:f9::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8413:EE_|PH7PR12MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 22646635-9043-4679-d46a-08dd574ed620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1F4c2lMcUx2NllDMit6MnJZQXg3MXl3N0JMakN5WDJmbFJHbVF0OXZTMHQ0?=
 =?utf-8?B?T0hxN2I1aENwY1Y4bnh3RDl6dlMzYmQ3ZHZUd05pRHExT1BiT2hPMElNZHRH?=
 =?utf-8?B?M2FyN0VvUVZpTGZ0anR4ZkdveWswdFIwVmROekd1bVFFUzNBM3hsUGdDMEpO?=
 =?utf-8?B?YjJIa0xQT0s4a1c2OXUrOXlUQlpETXJkcjBRMk43WmZWU25qUXVUSjlEZzdh?=
 =?utf-8?B?ajJtRldwSW1tVVA0bG0vdis3YUlyVTNZV01VTkRhRW14UkNSUmo2aXgwSjdt?=
 =?utf-8?B?RXlHRTJkT0ZrZFJvcXhEVTRsdGdURFRIaFhwakdCMmZxU00zVExEdnNYNnYr?=
 =?utf-8?B?WGZIc3I4UFNsdzlYQ3VjckpIQWJ4N3JHQURucVNUZkFiVGo3UnhRZWd4QWl2?=
 =?utf-8?B?OE9odGUvbS9wWndXQzZhako4NGxUdmVMaWowc3N3UXgzYk4yNk5UZ08yZUI1?=
 =?utf-8?B?bXZwSXptaktjWHFVNWY1M1p5OGhCN1dYVHVpc21CNVFzMUVYV1NEcEp1NVo4?=
 =?utf-8?B?Ym9nSFNVTUlyWkQ0R2FXRDVaT3NUbUc1S21qSUVuY1BQR3JGdG9ZK1M1R1hB?=
 =?utf-8?B?c1NtUFJJNko0Q0FBL3kzRDY3WGY5dm5Pb1lTd1pEVlQ0VzdYeHVsa05Nbi9Q?=
 =?utf-8?B?UG5NWmRHLzJiOFNTOFNOR2QxNE5yWFRVL05LM3d1ZzVuRGNLOXozdm9UMzhW?=
 =?utf-8?B?TmErZXFWOGwvbHRTU3ZNMnJDaFo1ZndWYm1sejVON0cxVi9GZzNOdVB3SHhV?=
 =?utf-8?B?SVd6WEFtSkh4dzZIQWtKTC8zdVdKTC83VDYyOEdVdWYxYjlaUzZscnJpUEFr?=
 =?utf-8?B?ek5oNWtHOURNS3E5YWZ6aXJWQXZxU1JjMWg0UXpJKzM0cWltcml5dUo3SlRm?=
 =?utf-8?B?VHowbXkvU0lmdVRaUFd3TW1Ud2xXM3N5bkMwenBFMGQ3MUR0WlFVSVZ4YlYw?=
 =?utf-8?B?ejRySVcxOC9HRlprSXduRTBpeTZPZWpXNXRyRm00ajZISk5HUVZvWVp3WFF0?=
 =?utf-8?B?N1JoWklVeHlHZGFWL0dkN3I2QU5ZekFrMWxLcFdhWlNydkFRbWt5YWREVDZt?=
 =?utf-8?B?VkFWNEYzUy9ENm1TS3BqNFBiS2JVUWo5U0JMaitpNkxJWkU5T3BaTHd0bkVX?=
 =?utf-8?B?TmNKSXpBQUNseHk0QWNVaUdzOUlZYVhDRWJYdERjc1NTdzBsd0F5YWZyTm1O?=
 =?utf-8?B?OHRRVlc3YWd1dTIrU2lrVGZub2xFbGhHa2s2K0FPQ296SXFnVjZqSTRiU2dL?=
 =?utf-8?B?Y2JXLzVxOHExNXFxTlBCNXNjYksvZ0piMDE2QnZ3UEZUYy9YcFlQQlhDeGJX?=
 =?utf-8?B?elp3ZVEyc01CL3BmaUltTXN3aWNMSW90SzNtVnZiRUV0S3dlanRyQm5BUmc1?=
 =?utf-8?B?anM0RXJwTmlLdVhObjZVSjRMRVBmSW5SZHJGRFlXbk40UDREUWs0RXo0Z3Vy?=
 =?utf-8?B?NVdGeDQwQzJNSlUwSVZEV0ZJeitIdUhoczlvYW9iZlZtdGNLUmhidlBKNGE5?=
 =?utf-8?B?eHNCeERNdDRVTldUVXhjRFNjeU1Ndkl0My95QU83aEt5ckFlT1BodWhhc1FD?=
 =?utf-8?B?V0Z0eDFoWmhIcWZjU3VPUDJMK3hoWDBpaEpJdlVWUHcxMFZGZXFLWlVKelZw?=
 =?utf-8?B?U2wvcnZjNmFaZG16cEowNTdrTmRDN0lVUVZvQ0NtelR0K0UyeHdmVkJBV0Fy?=
 =?utf-8?B?emlkQ01acm85UVBxVmlyRllDMldmNDRBdW1Tdlg3bk5iQWFWaXFFTnkyL3lp?=
 =?utf-8?B?ZW5UVytINTFBSWhESlVIeHZabll0c3E2bWxMODdQNWc1OFR4ekEyNEd5ZUls?=
 =?utf-8?B?NXV5UkpaeU5DRlB4eHBWTGM3NVhrNTVxTVVaallhSzhESG5YZmFvVUswcEtI?=
 =?utf-8?Q?kst4+FLnic1jv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXM0U2ZObGZHaGNmVmIzZUhuWTJXdGYveFN2K2pHdElJS0NocjlMUXIzd1I1?=
 =?utf-8?B?R3NUaVRIMmlBRzNkM283UW9JcXdBN2dlTUFSOEtXcE5XRk5hY0ZuTHBzTTN0?=
 =?utf-8?B?Q2o4dzFiWU45aU5lMDZrUHk3T3JlZWI4WkNsOWp1clRZTE4rNnFxb05EYzJj?=
 =?utf-8?B?d1U3NkdUKzNVdjNpZWFNdG9NWEVaYXBMVi82M1loZFA1QXdCRzZkdERRdDZX?=
 =?utf-8?B?QWt4bzI0b1ZmUkw3VElRSE5vL0dzMCt5cU5XcE9QQ3kzaUFOLzZnY05JZW5l?=
 =?utf-8?B?NWliZ2hiNVY5VGdyajVGQzRUZnRsVTZlSVhVLzh3ZFUzYkVUTmZMN2RpSWdh?=
 =?utf-8?B?R01jcnFDVmF4VTlnWi9wNDk5b0hjR0YwUmtxL1hTajQ5K0tDZkNCTXkvd1p3?=
 =?utf-8?B?dm1IckpaZ3NCSng5blE1OFRMYngwaTU5bndDSFk1M1ZTNXF5T21Sb2hoUFk5?=
 =?utf-8?B?Q0NCU2RFRTNncnZQRlV6T25WQkNvV01IaWdCazdWK2ZTSnFOTDZ2UUM5Yk9N?=
 =?utf-8?B?cnhzbnBzK0creWlqWjBWTURObHVEUEFYN3FiUmVSVDhIQ2kvQitUYWdVMDVL?=
 =?utf-8?B?U1RJQWhha2RoamdQMm52UTV2L0NzY2FFVTNZTnFyVkdvdDQxMTg1bFZKYWxa?=
 =?utf-8?B?NTZxUDd2Y1o2Um1lcWdJNm9BcTk0UFAydktmZ3NvVEhCMENqRkdqVDBoaHEv?=
 =?utf-8?B?ZXdUTVMwTFczSTNIclFQNkpzUy9WWmRTTHQzbUV6TDg0OUxnbXBCNk9HRi9x?=
 =?utf-8?B?MWFNN0ZEM0MwU0piRmh4Um1mSkhPK1hZY2I0ZHRTZmNKcUJTaVZpdW0xbmwr?=
 =?utf-8?B?T2kyMXFlV0hTRlVrMmE3L0R4RXU2TU5xelVwVEZSVVoyWFFMYUtwOW5TOHNp?=
 =?utf-8?B?YlhSNHZOa2pYdU5EcFFHQmR3a3VEdEduQ0lBWnB1Ykk2NFFrQS9xWlZIZ1RC?=
 =?utf-8?B?ZTVFUWZJSTNEWGEvaWl1Rnp6OVVraUhJVlVpYVpoTzA2ZkFyWFdTOUtiNUlU?=
 =?utf-8?B?YXQ2TGk1ZUpmVVZiWldtS001c0Q2Wk1sZ0trLzQrRjdXdFdrMzc4UG9zLzBQ?=
 =?utf-8?B?OHREOFdJY0pRQm1kK3lySnE5d3FGSTJnd0ZvZUNxUmlwSTJPdUx6aUFMWmdU?=
 =?utf-8?B?aTlJdVRML2xTbTA0OWRQVm4vcnRGTEg2TzVDbTRJQUV2SWpnc3c2a2dabWg3?=
 =?utf-8?B?bDg2ZjNibDRQQWFaOGhEcWJqQjN2UnMwSTlndVkxaFVkdWZBMTQ0b1ZIQWx2?=
 =?utf-8?B?K0Z3dythTTJNREhhdGpGY1ZBT0hreVdtV2xOODM3d0VsVy83TWxSdjdNd2pt?=
 =?utf-8?B?TlJoZnhTcVRxTEFxLzByMkttNGdHMkhJcXdudW1CM25Pd04wWE1XUGlSdGp2?=
 =?utf-8?B?TEVLeEQwOGtSeGpJS0kycWNGQ2RZVDVlbHArRW5WRnRDTWEzUG8zdHIzZ1hE?=
 =?utf-8?B?cXU4SDZyN0J6MGxxbGFPMUMwYlZzNnNIQUFZUWNwb2JVS016azRIbkdMT1Z0?=
 =?utf-8?B?L0VLSE1PZGtyTFNnVXFEK3I4ZlVVdFFEZ21XQzA1aGdNZVpBVGlrQ1IwTXg3?=
 =?utf-8?B?VERMaXdjNW8vNG5QUTdaTjBjQUFSaENCYnFDRGlab09ncG9LUkJmZ3g3TzJX?=
 =?utf-8?B?TGpVQnQ4SUdEdER5d2MzMlRJb1Zuampsd00wL1pBeUs2bFZ6N2hkditXeGsy?=
 =?utf-8?B?YVBuOFQ0c2RJWlBEVWsyeDhoLzdyRTRZNkVtWlc5WFVOdytlODRwMEdXdzNW?=
 =?utf-8?B?TGh6UkJzWWt1Z294cUVzSkFZYWpNeGcvN0RmQVVhZnNQS0t4UlVvYjh6eGJs?=
 =?utf-8?B?OVUzUjYvWlpXd05ITzdVT08venptVWVFc0FxdHZzN2lsbWRMWEhOT1dndGZK?=
 =?utf-8?B?cktGQW1JbUwwQm93NUZvVkhQbzdzNzBuZEtjYmxTOUdqK2pBdzJ1K0Fsd2I5?=
 =?utf-8?B?dmV1L3U5cFVlM1VTUjRjalphZlBzUUdxV3pzUTJQQm5hOWMvbVIvUGNLNnN6?=
 =?utf-8?B?cXdJeEw5ZGNaek5Rc1A2OU1NOVRudE1ZUExXZjYrcDNJTnpkSUpLd1VQcmp1?=
 =?utf-8?B?c082V0JTMXJ1ZnBUcGhaTU5EZ0d2d3NKUmd3WmlPL3R2Y2pkWW1FeFExOVVG?=
 =?utf-8?Q?u4eltY0mq14091oR61FPkUYzS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22646635-9043-4679-d46a-08dd574ed620
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:50:27.0838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZVthkOro4UK3WPzsmWsxYqQXmPMQo5PrGT2F/9DjNvEIAaWueDZDq3T7kE8W5oiTJzayFz4S7aBVCacmTbZ3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330
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

On 2/7/2025 17:38, Jay Cornwall wrote:

> VALU instructions with SGPR source need wait states to avoid hazard
> with SALU using different SGPR.
> 
> v2: Eliminate some hazards to reduce code explosion
> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>

Ping.
