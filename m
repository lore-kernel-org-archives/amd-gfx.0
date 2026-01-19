Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624DED29C4D
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 19:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D398210E4EF;
	Mon, 19 Jan 2026 19:23:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aec0C5Yj";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0537610E274
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 19:23:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmId3m8RnQ9BPwYNVS44UJQ6qtWOgBOPi4i4P0qWxToxXUoXGh4+IHhXWyV9t9cz7fR1t1U2F+r1q6DHgH4lIuBBTdzrfq5+y3SMEzEd6vzGVsPMHJoYU9SEGdZc98LtwEr9x/2D3qvCVrVx9E5ZJJg99M6LTtHmvJQPpBl1O69mkcz+sPgepw/9vDrtl+284LuaoJh9Ea278NcUel8NRH9UDRURQmk/hwESOAbOlMgFBFbFGddoGFHuiR14mqgq5JhNkCN6IwaoRt6HU2n4AeWYDeilNYSIf7z7MNLsRDwKyLyROM+CQuVMQEYZn3eUeh8xcnpbGvxUotK++oobbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVSKjq73KUYvopApBYIP4JzwrGzggRhaan+h7FcmdEU=;
 b=EWvrUEqSasyRCcRCrW8wW5ukLn2DycFNQBZj9hGmi70qrfU096Ho1ky7lsf3RWJqKadawgkwh76724YY5BDJgsSWn6QJbc3btvfwA9mXjIKB+yrX9OZkh6Is+JJ4H/AcecPfzY5zVqC1zGsFg0FqdVNd1ka5Y2tj0zZH9qcOhaNe8fpUXcwS6vU1Pk0KEwHvKL4B8hnkeYJ01SaCAIon7jqi3+MkwwRFZHULPB4XLQXR3HVx3QiHafDTyhIBzx+NPBVl8jwpTTz1X3luBNJf/y89Wrtlu8E2Gv76Nsn7arr6inCehwEXO180ylyFvkpNhXh8ooFF+H18exXur1Ad3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVSKjq73KUYvopApBYIP4JzwrGzggRhaan+h7FcmdEU=;
 b=aec0C5Yj3i65kdrqdJLh+ljGChWlJnTf4s3hch6+AkUpx992EXXH0yoq4FWlqOdu9jEbnuvKv1YJt86jkMFWdCQdFUBhquHAR569Yazu/BmL3LOWd5T8UQaOLjA79B52LMqk1DSL76GgegeDyhhk+9fJD5vCgjMgv2xxn5zccCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by IA1PR12MB6164.namprd12.prod.outlook.com (2603:10b6:208:3e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 19:23:23 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 19:23:23 +0000
Message-ID: <e8616724-0809-43de-9662-f55f9420c2fb@amd.com>
Date: Mon, 19 Jan 2026 14:23:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Only poll analog connectors
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20260118130345.43356-1-timur.kristof@gmail.com>
 <47aaaa83-012c-45bb-8f51-8f09c0ad20ce@amd.com>
 <5021716.OV4Wx5bFTl@timur-hyperion>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <5021716.OV4Wx5bFTl@timur-hyperion>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0324.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::28) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|IA1PR12MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e11c208-6e4d-4502-cf5f-08de57903684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QldkRnorTytTcU1QZGZyUUN5RVlLaGFnbDJjMUFnMnhCeEptbGdMQzlpcmZh?=
 =?utf-8?B?NEplTDkyanlUeGFaZUlIdFdKcDR1RGlkTTd4OEFaWGNXTGtUbHNFQWdSaDZU?=
 =?utf-8?B?UTBFYkFYZFN1Ym9UZTNaYnpIMmp1UnZyYnVtY0gxQjRHOUpnQmp6MTB3KzVl?=
 =?utf-8?B?Q0xOTHB0VmJ4WEtPYXY1V3pkemZkRmExUVhucmh5SWNNdDkydmgyY1dENWxZ?=
 =?utf-8?B?d1BtaUJQU2NOcnFPOTlwSFMzaENyUlNJQ2kzSmRia0JMSFBMQVFYUU5zbVA3?=
 =?utf-8?B?dnBMYllTNXNndjFDQmNLN25ocmpBblVQL2lFdjcvTHRGbU1kdGNHK1F3V08r?=
 =?utf-8?B?VzNwaWV0L0N0V3lWWTJ1QjBWMzcwT1IrWTFsczRUY2Zhc2tZVnJSWmU2RzR4?=
 =?utf-8?B?ZmVWeXhGYTJFVzMyVG5BaC9nQ3RKUGFLYTZoWjNlRHRKb1lEa3Q2Qll3aDZ3?=
 =?utf-8?B?TlJFb2ZWTFRuVE41VTJHREpjejZGaGNVWWQxVFpBb3hVTWpVZGtKVmYxVzMz?=
 =?utf-8?B?U3p2eXh0KzRoY2svd3BzZUhGZDBISXk0R3JtKzdYd1lYY0ZOcjZLeEN0bGpX?=
 =?utf-8?B?VksrbEgyRDE1ODR0ZFlDQXQvcHFiNVNMMG5CRTBqUkVpTm92dWJaQm9NUnVN?=
 =?utf-8?B?NTdZQjdhRXdrcVRoL2VzSnhUU2JJMWRrd0xicDhtWGpmQVRsbCtGU3NqZGJM?=
 =?utf-8?B?aVBkWVVTWk5nRUdMU2ZTQm83VVBCNUlFREMwcS91SGsveWdtb0hZc0tKVFRn?=
 =?utf-8?B?WEZyWllZb05ZMnVNNkxzd3J0dGExS1Yxb1B5c2tGdXk2eDVqVTQwWVh1d2Q0?=
 =?utf-8?B?dWR3TFBmSHppNzgrR0h4VStha1VFcmp5UERnVndpb1FFUXN0S2k4ck5QWWtF?=
 =?utf-8?B?WkxFSDVJUkp6YTVnR3BJSmExUm5kNXJuZFJzYXQza0dnYUJZZE5zajZkYTZm?=
 =?utf-8?B?MVNKeXIwZzI3SzhlU1N4SmVMWDVrOFA5WnJ1cU9pOFRmc0UwVityT1Ridnhp?=
 =?utf-8?B?MFFXL1F0T25DOVhjRy96Z3gwVENoQktsVEVSL29jNmtKbkc2RUVNMldsOTRG?=
 =?utf-8?B?L2Rnd3lEaGpTeWVHTE83YmdrVFFqVWxmN2xNM2xxS2tIamJJdzdWbTRKb1ZW?=
 =?utf-8?B?Wnc2QlVaNVczczlYMnZ1QlpIUkh5ajgraXFGMjE4ejc1a3VEN3pYMERoU0o0?=
 =?utf-8?B?U1BRTkc2WUdwVzZwS2FhOGZxV0Z4Z00rczhFbjZaS2Z6elArZFhuOFJ3N1hB?=
 =?utf-8?B?YWZiZDNEaUF4MjEzMmlXQTEvOGVUZ2pzaHJ5RzRPcXlVdUtlTGxrSjNlNkpI?=
 =?utf-8?B?UTFHbFZ0QXZDUFEwTG5oY3lZT3NFQXpGbFY4K3dscXRsclkvWjhRZ3pzSHpt?=
 =?utf-8?B?dHZPekM2TmhjZ1dNdmxvZm1aemZHVk5iZGpPd2lXWTQwL2hsZUtwZkZ3am5T?=
 =?utf-8?B?cTRrbVdLR0ViWXdabGtxTzlrZmJ1ODV0TGlCREFmZmdxcFhSd0JPVjFBU1Qz?=
 =?utf-8?B?Y2hXY2g0bEY4SGl5TG9VVWMvNWZnR1ZhRE5qZEgzNklLcHZ4VjVlTUtpdXp1?=
 =?utf-8?B?RithdTdsajAyaUtBV1dwZVE3d3pmMnFjS01adzdJOGt5SEhkYXlzbHM0NUJp?=
 =?utf-8?B?N2JpWWl5cXArSWpaUGtXS2w0K3JWd25BTHlkV2lsemRqaFB1MEdNQzZLSU4z?=
 =?utf-8?B?Y2YvT0hNSC93S1ZtQjBOVW1Wd25rWi9Ea1licVFwdG5aNnFuL1V4Sk9VTkx0?=
 =?utf-8?B?UWU1bFVnUFEyWmVPVGF4NDFwUHU3RnJvR3o4cGQ4OTUwa2lDSnFyK2llcGtP?=
 =?utf-8?B?cXo4cUNseHFEQ0NOTWhjZTYrNDRhQW9PT2FZS3AyRkF1NldtamordE53YnQ2?=
 =?utf-8?B?Ymh3K1cxOEhRVkJrUU1YZGx2OUVlUUU5VDlWRi9kcGxMb1Zra01FWkI5b0hH?=
 =?utf-8?B?R1UxTUx5cFRPOXU5VmIrdEg1bDltSG9MdlhGT2FMMjVUUHpuSWZhUm44UGZn?=
 =?utf-8?B?MGZoLzQrQW1mRGZYT05XY2ZmR0Y3UksrSk9tY0lGUWJZVnRtNjNaV2RCeXJI?=
 =?utf-8?B?VjVOTXZQQy80aVV3Y1YvK29TdDdNWnV4S3R4M1RiSlBjbDdzVjByeXZmTEN0?=
 =?utf-8?Q?wBb0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q05OVEFBQ2taVFptUnpLeEhwaGViWjVaRG9GWmVFbFh2RTMxcEwrcmxRdzNM?=
 =?utf-8?B?M3NJWmVoYTFaT3dmeWdNdDBwNVhBQUNyZkREL3MxZW4vMWVsVEhZcy9sWTlw?=
 =?utf-8?B?ZjZIUldaeHdUbk9wR1J4bmlHbUJON1IzQU92dVRTU3V4RHlILzdIVmZ4eE5m?=
 =?utf-8?B?VEZCQ01aWGx5Q1BONTFGTkJIWFhpdXNHZHR4NHhnblRhNm05TUxRdVJSQmZh?=
 =?utf-8?B?WjZ4YVYzRy9kQWlYK3h3c3ZDbEppMi9Fak13SkNGb1NVMUxmWEtVZnZBNFVZ?=
 =?utf-8?B?eU1PYWlZSGpxZHUrM3loOFVWd0hDUVhxeXhZem16THlGYmV4QWljUkhxK1Yz?=
 =?utf-8?B?dHhIa2pXNExzSjY2c1UvWVlOb1BnQm9HZ1VRYStNdm1UdHZXaC9XKzB5eWtC?=
 =?utf-8?B?dVlXR2taZFBCK240Rit0Z1drUlV1UjlzRnNmMlo5SlhYVkZCVEU3OVVoMW9K?=
 =?utf-8?B?K1hpRXhBb3NpNGExNGdaTERVWWl2NDY4OEhTNzdMVnd2N2V0QzFxWmJJMW9E?=
 =?utf-8?B?Si9mUzdHcVp2UFBGb095YU5zS2V2Qm1LTUVlZ2cwOGRrWmxpNDEzVndaQk43?=
 =?utf-8?B?eFNHdHVZNjI3bEhnQkpKRzNRYnpjUTZJckhmQU1UaUIrRFRqSS9qRThjbXU4?=
 =?utf-8?B?bjl0VUxuQmh3My9xT1pEL09aZ0hsRFBqL1loSFIvMHh5MGVHSkJjRllkc1l2?=
 =?utf-8?B?czdLbmhqaU9mSEV3MytsQzkrOFBPUlhXRndpaVR2UUYvbFpncmFGL0FVS1NQ?=
 =?utf-8?B?cjhObzd6WlpzK2d1aE5FWW16ZGp3bnpaRXZESUFVeEVNdC9xVjM3WUdVVkQx?=
 =?utf-8?B?ek9YQm92STgvOTlGMnlOajZpM1FVOENJQ3A4NmNMUDYrejByQUFvM2llOUNY?=
 =?utf-8?B?R2NjMFRHeWI4bUxzYUZnVjcrenUwbVV4RXRSS1hyS1ZZc0w5Q0lGa1FBYnFX?=
 =?utf-8?B?ajBjSjRKU3Q2Ymo2NDJVaUVlUEdVczRxZ0pKT3RlS1BBZVJ5MUxPYVBMS2M1?=
 =?utf-8?B?blByMWV0Vk5CampLZS9oN0FsMkgwNTF0Slk0MkxvVGw0SFBBUXlGNVhOV213?=
 =?utf-8?B?d1F6MDdwQ3h1UGNMc3k3SE80eUV0VWZCQlJQc1RiMzdZci95NEJuaWR2R3V0?=
 =?utf-8?B?Q1FJdmovaCthZWF5YWNYWnZzUHgwMG1iRGFSOXdSWGMvVmVUOW9Rb2tCb2o1?=
 =?utf-8?B?NU02d1JaV29RNFNFamswbU05S0hLRmdrQkJTdjlzYm1ESGlMeW1zeUV4RkMx?=
 =?utf-8?B?TlpDVVN3Yk83SzdlV1A2RUZWS3ZDR0JhMktSQ3FYS0hKN05MdENiMzRGanRK?=
 =?utf-8?B?WlZLM2k2NWxKWjFxL1JzcDV1bGdjVy9neDM4OUFIY3VSQ21HUjJpY3FjaVJX?=
 =?utf-8?B?anN6WHpUam5abkZhRnFYTU9mQXl0dWRLSzJDMVFrRE83UVZGcU1LckVYMTZl?=
 =?utf-8?B?SDA4RTY1TGRNNkJlZXZoTkRCOG8xM1ZCYWQybTV5Y2xSUEhWSVQ1TUl3dnVo?=
 =?utf-8?B?T0pralgxTU1GMXdVZ2hyNk1FTUpXb3lNYkRrVE1mNk5wbWV1TEE0cGpUSzhv?=
 =?utf-8?B?U3Zhc0ZnS1BwS1QzdmhaWHVQTWs1QXc4cE04ajZndUJHQW1aNFM2akx5bS9U?=
 =?utf-8?B?TVVlaW8yTFFOOFV1cms3bUl0bU1sRllwcFpHbHFnL09xcWQ5QWFvRk5odmlK?=
 =?utf-8?B?cXkyeklkTHlJMnJ5cDJ2am5NMlVtRzBCSFFCeVlkK3djWHFFdncvWXU2QjBC?=
 =?utf-8?B?MWNDYmMzR2lrb1JCNXdudWx6QXJJdlZ0bktsRjR5SE05VGh6TEpYaVRMZ285?=
 =?utf-8?B?RTE0bWREOVNDdXA3VHdMZ1FRT0ZRL1pSMTVMYldoQUFkempVSzJZbEFtVnFw?=
 =?utf-8?B?SFNlNGVqcHRBZmg5S090bzJUOE5PZ21YVktIYzQvMEZnSW5hRmNNOGtMQWV1?=
 =?utf-8?B?cEorZjV6VXNFN2RYOGc1cnZUSzRWUW5ENzFFMlF2ZWZycU0wbkxZRlFPUWs4?=
 =?utf-8?B?MHlFYzhpZ1Z6S3F4WVZtQXFmeVllbDFlNEpWTFhJU2VweCt0R2ZuajQwU1VD?=
 =?utf-8?B?OVlMMFpSR1llWmNXTTdGZVFUSWRUR0VFUytSenBiT1ByU3FBaE16NnVMZ2JB?=
 =?utf-8?B?TlNGclMraWxpcGUycHJjM0UrUGpaZVd5YXN2NUlDUks1L2NEUFlMSU4zUnBr?=
 =?utf-8?B?NGhxR0NLMlRzTENqaVJKOEd2MUR1UkZnVGZuTEtiVnViQUQvdmhDeFBiZGVI?=
 =?utf-8?B?MXBtTmNXUVF4SGhwVTMzVXloM2NtVlh5VWRBaE1wL0crNkg4KzM2dDVWSHV0?=
 =?utf-8?B?NGhjZndPK0xMREpsa3llMW5jWWxnVytMT3czOFNDdm1vczdqVjNJZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e11c208-6e4d-4502-cf5f-08de57903684
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 19:23:23.6136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+VEzH7AJ3LG/YcKWBKl0NHYa39ybZM9hvEjyEcgpZqq3RrLZBkjSGqnrPCdGeXiTE4bCU8/iLMZ/gSwtTp1NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6164
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



On 2026-01-19 14:06, Timur Kristóf wrote:
> On Monday, January 19, 2026 6:21:40 PM Central European Standard Time Harry 
> Wentland wrote:
>> On 2026-01-18 08:03, Timur Kristóf wrote:
>>> Analog connectors may be hot-plugged unlike other connector
>>> types that don't support HPD.
>>>
>>> Stop DRM from polling other connector types that don't
>>> support HPD, such as eDP, LVDS, etc. These were wrongly
>>> polled when analog connector support was added,
>>> causing issues with the seamless boot process.
>>>
>>> Fixes: c4f3f114e73c ("drm/amd/display: Poll analog connectors (v3)")
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> Reported-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>> ---
>>>
>>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c index
>>> 0a2a3f233a0e..e7b0928bd3db 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
>>> @@ -915,13 +915,19 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
>>>
>>>  		struct amdgpu_dm_connector *amdgpu_dm_connector;
>>>  		const struct dc_link *dc_link;
>>>
>>> -		use_polling |= connector->polled != 
> DRM_CONNECTOR_POLL_HPD;
>>> -
>>>
>>>  		if (connector->connector_type == 
> DRM_MODE_CONNECTOR_WRITEBACK)
>>>  		
>>>  			continue;
>>>  		
>>>  		amdgpu_dm_connector = 
> to_amdgpu_dm_connector(connector);
>>>
>>> +		/*
>>> +		 * Analog connectors may be hot-plugged unlike other 
> connector
>>> +		 * types that don't support HPD. Only poll analog 
> connectors.
>>> +		 */
>>> +		use_polling |=
>>> +			amdgpu_dm_connector->dc_link &&
>>> +			
> dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id)
>>> ;
>>
>> Why isn't the aconnector->base.polled assignment in
>> amdgpu_dm_connector_init_helper doing the trick?
>>
>> Harry
> 
> Hi Harry,
> 
> The issue is that checking "connector->polled != DRM_CONNECTOR_POLL_HPD" will 
> also match connectors that don't support hotplugging, such as eDP, LVDS etc.
> 
> amdgpu_dm_connector_init_helper is working correctly, it doesn't set the 
> DRM_CONNECTOR_POLL_HPD flag for neither analog connectors, nor eDP, LVDS, etc. 
> which is correct. The problem is with this check in amdgpu_dm_hpd_init.
> 

Ah, you're right.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Best regards,
> Timur
> 
>>
>>> +
>>>
>>>  		dc_link = amdgpu_dm_connector->dc_link;
>>>  		
>>>  		/*
> 
> 
> 
> 

