Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1186C9EC8D
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 14:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6110210E217;
	Mon, 12 Jan 2026 14:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cErvCJLK";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013034.outbound.protection.outlook.com
 [40.93.196.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBBF510E217
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 14:33:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFN05E68tvkPG+pTICxBMvubg+kW5pvzAGQn/J/Nv+zer5Jj0nMTajo5aZaiHl8pa3HeYUj8vpcv5+EX6+4aQ2846/QHNSgOw0dQIkluNKzNHl8YL1csbxE8QaC0CWaACtqKcJfiI4HGEzTyx4ubVI5NtB3rf4b4dla2lN/jl3alX66tShOOtM6My6madD+Pc9sRSNn/JZk+oRJ/1lJpzopPgjP0mXJKef4VeJDa/BRVpr/jGGrNaQ2SeoFmXyMoxCiCJU6oY5yFydvZYLCkP0E6L9BGTGJZt2QLrDi0dP+pxnjw6JLdovylSIpPqttPL23DyV/a+vYfQxDU4Hvl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5WbDbtBX1f/wJomiGU3U90jpPFcGl2wVd4OLqra6UI=;
 b=vMdkilA4Lz/PpXnCXzyPcCPykG2a/mPwcZzzhQdCCl7p+iYeU9xOs+2CQvVBxP/At4zUVotmP0hIqsryzv003sygI1Qnq0rORl47aWF2dE3rHAF0Zak1MosfpQxQTIqth/FOuGQUUWHAPK34sf6G42H5rRzT46BzzhpR5/dEEjjwp5YlKQRhLHmTNmYXVhfxKWf4KZz4/Tm1WRMfGSQAx2F/tMIHslCmgRhOBCGGhw/kWfM9BDDFaeHn7pyXWtkNGL6q+p0uSj9idW6VGq3k2JQLkDjUa8pPADpNcJg4yacf+5YJVmFUAcp5OI7e6QDCac37RiaRH/YRJlf2RB0KPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5WbDbtBX1f/wJomiGU3U90jpPFcGl2wVd4OLqra6UI=;
 b=cErvCJLKmm/+e0ychiPtvzfaO8KslvY4use6nSNkjkvGf5E+wxx1El1qDSwIh0e+GmKWfjveB7+Vvdv2QnyU9a/jvh5f9D3iT85jC9b02oSdekQAxny0LtqOXIkksHHO/eD9gGinlpRlVX3/7U7SG47FAX0tD1mL/xflRabNHv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Mon, 12 Jan
 2026 14:33:13 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%7]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 14:33:13 +0000
Content-Type: multipart/alternative;
 boundary="------------u0BMhzK253GTghXgLB37DnEc"
Message-ID: <ddf53e33-4d67-49a8-83aa-150ba12e947e@amd.com>
Date: Mon, 12 Jan 2026 09:33:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix gfx11 restrictions on debugging
 cooperative launch
To: amd-gfx@lists.freedesktop.org
References: <20251217161015.1666802-1-jonathan.kim@amd.com>
 <CY8PR12MB74352CEF0FBAA12EF95627108581A@CY8PR12MB7435.namprd12.prod.outlook.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <CY8PR12MB74352CEF0FBAA12EF95627108581A@CY8PR12MB7435.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQZPR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::8) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d917430-f71e-4ecf-ea6a-08de51e78440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjN0bVl0RUxrRFpVbnpJWkk5STdmOHZOOTRNa3BFN21DQzFuVnJGSWVwaE9F?=
 =?utf-8?B?dlNZamluZFREQnNTN3Z2QkFITHNvSEp1WGRoZU16V2tRdXVheVBoQ1RNME1x?=
 =?utf-8?B?cS92VUQxN2p1NkFmcUJHd0FjYTVkbVZLRmU5bnRKU3pQeWJGWFlDTG5YMWl3?=
 =?utf-8?B?NWdUa3J4US9ZQ29UeWdRU2NvOU5GRERCbzZ1V0l0eFcyQldJODNUVTNQaWtR?=
 =?utf-8?B?K1pxdjl4cWJISnptOTI0d2hGWTJzSXBFYWx3dFJlUTFiUGYrSmk0dmtMUENx?=
 =?utf-8?B?Yk9DTytpaDJ4UFdIRUN2TkJuMGtnVlJDZkR4MEk3cklMQlljYkJYYzh1VVZX?=
 =?utf-8?B?cTFtaFYvQmllN0NjNW1lRjl5VTVlbzEyN1dHMk5JMWxBZ0lGMkVqb0N5WXY1?=
 =?utf-8?B?NHRtWG45KzhaR1g2dlNFRUNTbVFjenc0NTF4ejE1Nm9rNkkrNDhZS2htVXNB?=
 =?utf-8?B?SzFMU3EzTndoeGtTZHAzcWJjZ1l4eC9nVURTSHFsRjBZN2FrYzJZbjJFUlQ4?=
 =?utf-8?B?MFVPckJnSXpTcG5kVGNES3R5RkFPMWg1NGdON0pHTnFZandpOFJGcjNkMWt6?=
 =?utf-8?B?emxyVko0V1hYdXVKQVJidXNpdkRMK3gwSmJtS2ZmRWVkcTFyUE1kN052bVJ6?=
 =?utf-8?B?aU1vTS80ZnJwSXhDbkVYbDdKVElSek55eG81RWRmTHkzUWtWbU5wb1dPMkxP?=
 =?utf-8?B?TDF6UWo3TXZycFV3S0VGQjJWUitBZEh5NmMxSWxlNmhYTmFiNmdQVXFHUjJo?=
 =?utf-8?B?SHUwT3pNWXpMYlRIZVhoSjdyQkRXT0RlL29weVF6RDNObjVTNjN4eXp1SWFU?=
 =?utf-8?B?MkhGSWc5TGJDcGZ1emc0c2NBUGY0MGtvRjJuN3EzOERRdDR5TjlqeWVTcEhV?=
 =?utf-8?B?MGt3dVZ6L1d3MmcwSFp2Vy92NDhUM3RqRktrWThhUFhVOWplclEwU2JIeHFo?=
 =?utf-8?B?VjUwMDFOUTBZdlEwWkZscGlxZVBNdzE2VXBPejdNUzhxbjZNSTF3UTJvVFJi?=
 =?utf-8?B?N0pHRDBQT0hzeHFkVGFlTWlORWJMamVVWGlXYVB5aUMvOHpHQWR3RElwNllG?=
 =?utf-8?B?bmdzSXBvTnVLQzMvY1pZWFJDbjFDSjlibjVwM1hLOFpVbmpYeUlOTVREVDg1?=
 =?utf-8?B?TVM5cnZLcUJPRFJHSCt6cm5VYTRqcm43MDJwajlnZTBhSGFDbyt3RHB4clNS?=
 =?utf-8?B?Vzg2V0lFQmVNcTZOUlJTQndjSkVBL3ptR1Y2U0V5MnZIQU9mZ3VFODFCUGI5?=
 =?utf-8?B?R3djYTk4ZGE2aTlXeUhWZUVWYUhGQkFqSC9xMkNYOEk1WVI1S241a0xBZlZk?=
 =?utf-8?B?ZFpvZVF4K00reXV0SDlaMXl0dFZ1dGk2TVdqR3ZXWGdYeVQ5bnRBVE9VMFlI?=
 =?utf-8?B?VE5Ed2Myc213V1RiTUJKczJLVldoVldjYUhkL21ZMHhPOU5mbmZ2R0dYSG5Z?=
 =?utf-8?B?cmlPb1dMc0sxdnI2QTY0TVZ6L0NVbTdhYzNLQWNJZ2w3UWdVYnF6VXJZNW1o?=
 =?utf-8?B?akVuVlhwRDc2SnhZYlRPS0FaeEgxanVGcmRCZ0FHSmYvQ1lOUzVSWjM2QThE?=
 =?utf-8?B?cTdVM2ZoNVVOdDFDWFlqTFBsOHBvcEM0NjBYeEJtYldoUEJBOHdyT1I4RzFs?=
 =?utf-8?B?NXlRY3gvQ0VNNzNTUkxSSEFsS29xaStCeFYzMzF5a2JTWjI2Q1JCZUllQm44?=
 =?utf-8?B?ZzN4aVVXN0lFZE9JNmtSbDRReFVkQ3BvWW1RZ25mSGRvOUM1bzkreG0rZ2p3?=
 =?utf-8?B?bkVvUlRCciszKzZsSTh6a1BlVzltOHBzTE1vSVhkaENIeDNLejBZTlBxR0pm?=
 =?utf-8?B?cVAra3FSQ2RkeGpFcjZBYnhkNUtmWlF4eVRCdUJHYW4wQnFDQ2s4Z1dKSENJ?=
 =?utf-8?B?bS9zZStxOTZzd0NBa2NWaGtsUk5VckFFUkJ2OVVMbmVTamJabEFaY2Z6ckpx?=
 =?utf-8?Q?lil3UYKOL9w79AQi5S/YqkGm70f5i1he?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QklkOHB6bGQ4VEx6RnFFZ012MzBnUTUzc0JsdG5pRkpYWTdUcG5pU0Y0bVVw?=
 =?utf-8?B?L2g5U21CTWFzRWM0VnNFMFEvTGJTYUJlSCtGVjFGUzBZdy9yWGozU3FKUEFZ?=
 =?utf-8?B?Yk1NUkN3TndkaUd6WDRwV1plaDFpSTh2OHVlMU55cjFjekhxVkcvZk9pV2tO?=
 =?utf-8?B?b2lFZWY1K2ZXY2JpKzdSaFl4RmhaTzJ3Wmo0Um1Ca1A5aHlFQTd3eHl4bUd3?=
 =?utf-8?B?UlZFdW9LUm1KTUFiTEc0Zk8rZmZleWlIOFhReE5pV2U1RU82eHEycEdHSURa?=
 =?utf-8?B?V0NIYnJrdzRVcHIvNHBnbWZveVYwaVNqd1NXaXJ3UzVvQllhTlllb0NVaWgr?=
 =?utf-8?B?YVg3WlpNb1UxNGtkMmdnWm0yZ3VtKzIreVk1NEMwUXVxY2NMNis4Q1ZTdDJm?=
 =?utf-8?B?cnRYOUVKRk1aNnZDWjBuZXNOMk9Lb25Mc0lla2ZRRWhhT3E3M3dGcTNpc1RR?=
 =?utf-8?B?MDE1VjZDYXM3dVNBNlFQN3I0d0xta2N2YUovbG1wdWVLQWYxREtQTXJzS1pz?=
 =?utf-8?B?UE5zYm1hWjh4U3psMnZPRzB4QlkySUJSdEhSekdWU0syMWNvZzRQbHJ5R2sz?=
 =?utf-8?B?NGwxT0l1OEFaZGNHSVo4U3BaclRnMWRGVW5YUWt2dmFsOGxCSmlFWjhPTkJY?=
 =?utf-8?B?cEI5U3NxS05UaEl0ZWMvTHlzRDBOVEttUGtHUXBuaFdxeU5pNjB4WFd2eFFP?=
 =?utf-8?B?SEdBanQ2bGVqZGhYaEprdUhUbDJiU0Y4bHVrRCt4VXh0YktnYjlaT0RyT3A4?=
 =?utf-8?B?RS9sbUU3MnZHVUxvWlh2Nnh0RFI4YldIKzZyY1NyUVljOW9nOW1HK0NmWnEr?=
 =?utf-8?B?SFJrdGU4UFpKeTdwNUpSRHNFaDVhb05OYzZVNVFSSmJSejhxWTNNRndBSU85?=
 =?utf-8?B?UEkwaXRXRTBTTFdsS1d4cjMzbk1ZQnBlUHJBRE4wUThNdmtjV2VPVjlTVTN1?=
 =?utf-8?B?bUFXd3VHakxSZnlKOCtIWlJTYVFvRy8ray9SOE1LT3dyTVVhRU4zTGlWVGgv?=
 =?utf-8?B?bi9jWnkvSHJLQURpbnlpZVYvZVdCZjgzRTBCNkp4WVdPNit1ZVBQSC9vTkVF?=
 =?utf-8?B?bWxhYXh1YStCOTdXR1lNYnRoMUYwc09icStFOWlOTkxXSVhZcHVkeDEwZnN0?=
 =?utf-8?B?NUkwbUhURWdRQzBpK3IzNW1yTmgxN1c0aXpKbVFJY0daRjhUNHRXN3IyZkZv?=
 =?utf-8?B?K1VDVktudnVJdUdIS1duNUU0UDdmMm1xZDBybzl1WUM4UGJyYTYxTlFXOEVk?=
 =?utf-8?B?amdCWW9EbzNFUnBNQzdwMnM5NjFRK05HbjduRWR3eThqVGVMS1cvNWNBaXVx?=
 =?utf-8?B?TnJZU0doZXowaWFWK3JWcUlkV1ZnKzRxaG44Smo3eXA3bTNHMXFnSFlYdFlW?=
 =?utf-8?B?VjlpRUJIKzR5RTdha2p1NnNyTUhzUUN4QzdrbXR6VTdlanNpaUZKM24waTN4?=
 =?utf-8?B?QjJRSWtHY1pLM05YYWgxOGxJYWo5QXhobmJnMGYreUpubkJSbXlRSUdjK3FU?=
 =?utf-8?B?VDNhakFEQzdiUnQ2MmxlWnFoTDhYUk95Mm4zdjV0akNnV1BXY0VuN0xGRVZs?=
 =?utf-8?B?SmRGMHlWWmtaTzdYL3pKemY0Rm5sK1BKSGNacW8xTlNDM0VqR3ppVENMSm90?=
 =?utf-8?B?RkZ0RGJSOTA3eDkzTFZDNlQ3Y1ZnQWxlMTFjRGZEYWo2TE1LaW0yZkhxd0Ju?=
 =?utf-8?B?U1BLaWZPalBRSDZVeUpkN1U5d21lQ2piMVc4dmZGQ21XbUh1aVUrZmRtTGZY?=
 =?utf-8?B?OXZsODZ4NnQ5RCs4WFRvOE51b3U4L1phRjRsM2padTZuQlJONmFsamg2QzVy?=
 =?utf-8?B?QlZFNkJScDRVekNWL0h0NDcxTG5MM21KSmdpaDFWZUtmY1p5MEN4NEdlU3JJ?=
 =?utf-8?B?WWNXU3FQWGNEbU5vOWdXU2tlbWQ1TjZKN0dXTmtCcEp0MUM3emhQa2NETFUz?=
 =?utf-8?B?cjZZWGdSWFgvSGNIOWZaYlFJZTMvUWFFcmx0VGdLRjczaGxLOGY1ZHZCUzBw?=
 =?utf-8?B?MU9NSHB3SmtmS1E2NEc3eGp0UUVJMjBYSGQyKzhpWE45aUF5cDJQcGFaTVNO?=
 =?utf-8?B?bXpON3lmQU11R0s1THlWczBleVk1eGkvblNrc291RHVmSHJOWDZDb0k2cFcz?=
 =?utf-8?B?cjQ0R3o3RlR1ZjNEdnkrZzFiK28vQUlIV3dSSnpLY0p3RzQwQzVIUEtuQjNP?=
 =?utf-8?B?Y05oNTNUVWhteXZ1Ny9MMEYxdU9QZytIRXh0dnJlaEk4MVVpTjlaMjFlMFhz?=
 =?utf-8?B?TSsxaFFoaWR6UzQ5blZlTndET25oQ2lNOVFUWlE5eXp1cHVTdlBPaU00SUZT?=
 =?utf-8?Q?QUMGzVS64HKq9ZDnzL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d917430-f71e-4ecf-ea6a-08de51e78440
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 14:33:13.3763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: He+cylAQpJp5Ij7kcX+tVErVhLId+49OyK9dWQTG4YJ6q/FRvFGSzewYkBk3yFit
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
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

--------------u0BMhzK253GTghXgLB37DnEc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

ThispatchisReviewed-by:JamesZhu<James.Zhu@amd.com>

On 2026-01-12 09:27, Kim, Jonathan wrote:
> [Public]
>
> Ping for review.
>
> Jon
>
>> -----Original Message-----
>> From: Kim, Jonathan<Jonathan.Kim@amd.com>
>> Sent: Wednesday, December 17, 2025 11:10 AM
>> To:amd-gfx@lists.freedesktop.org
>> Cc: Kim, Jonathan<Jonathan.Kim@amd.com>
>> Subject: [PATCH] drm/amdkfd: fix gfx11 restrictions on debugging cooperative
>> launch
>>
>> Restrictions on debugging cooperative launch for GFX11 devices should
>> align to CWSR work around requirements.
>> i.e. devices without the need for the work around should not be subject
>> to such restrictions.
>>
>> Signed-off-by: Jonathan Kim<jonathan.kim@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
>> index 27aa1a5b120f..fbb751821c69 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
>> @@ -120,8 +120,7 @@ static inline bool kfd_dbg_has_gws_support(struct
>> kfd_node *dev)
>>                        && dev->kfd->mec2_fw_version < 0x1b6) ||
>>                (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1)
>>                        && dev->kfd->mec2_fw_version < 0x30) ||
>> -             (KFD_GC_VERSION(dev) >= IP_VERSION(11, 0, 0) &&
>> -                     KFD_GC_VERSION(dev) < IP_VERSION(12, 0, 0)))
>> +             kfd_dbg_has_cwsr_workaround(dev))
>>                return false;
>>
>>        /* Assume debugging and cooperative launch supported otherwise. */
>> --
>> 2.34.1
--------------u0BMhzK253GTghXgLB37DnEc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>

</p>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">This<span style=" color:#c0c0c0;"> </span>patch<span style=" color:#c0c0c0;"> </span>is<span style=" color:#c0c0c0;"> </span>Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>

</pre>
    <p><style type="text/css">p, li { white-space: pre-wrap; }</style></p>
    <div class="moz-cite-prefix">On 2026-01-12 09:27, Kim, Jonathan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CY8PR12MB74352CEF0FBAA12EF95627108581A@CY8PR12MB7435.namprd12.prod.outlook.com">
      <pre wrap="" class="moz-quote-pre">[Public]

Ping for review.

Jon

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">-----Original Message-----
From: Kim, Jonathan <a class="moz-txt-link-rfc2396E" href="mailto:Jonathan.Kim@amd.com">&lt;Jonathan.Kim@amd.com&gt;</a>
Sent: Wednesday, December 17, 2025 11:10 AM
To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
Cc: Kim, Jonathan <a class="moz-txt-link-rfc2396E" href="mailto:Jonathan.Kim@amd.com">&lt;Jonathan.Kim@amd.com&gt;</a>
Subject: [PATCH] drm/amdkfd: fix gfx11 restrictions on debugging cooperative
launch

Restrictions on debugging cooperative launch for GFX11 devices should
align to CWSR work around requirements.
i.e. devices without the need for the work around should not be subject
to such restrictions.

Signed-off-by: Jonathan Kim <a class="moz-txt-link-rfc2396E" href="mailto:jonathan.kim@amd.com">&lt;jonathan.kim@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index 27aa1a5b120f..fbb751821c69 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -120,8 +120,7 @@ static inline bool kfd_dbg_has_gws_support(struct
kfd_node *dev)
                      &amp;&amp; dev-&gt;kfd-&gt;mec2_fw_version &lt; 0x1b6) ||
              (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1)
                      &amp;&amp; dev-&gt;kfd-&gt;mec2_fw_version &lt; 0x30) ||
-             (KFD_GC_VERSION(dev) &gt;= IP_VERSION(11, 0, 0) &amp;&amp;
-                     KFD_GC_VERSION(dev) &lt; IP_VERSION(12, 0, 0)))
+             kfd_dbg_has_cwsr_workaround(dev))
              return false;

      /* Assume debugging and cooperative launch supported otherwise. */
--
2.34.1
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------u0BMhzK253GTghXgLB37DnEc--
