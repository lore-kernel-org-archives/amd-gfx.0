Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3463C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Aug 2024 16:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4605710E980;
	Fri,  9 Aug 2024 16:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PPiczXsG";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDFF010E980
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Aug 2024 16:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uqf3pdfJPs+ccephnKttcfzuAdJN8NySICbBLoiXoNjMSGTKkrzIjnsgS1ZIwGqgPO9YOPumBesKmtsa0sBby4GCya7BlAf/szY7DF2lEIW6PRl7udf6ZmwimSq7MS6COk8t5Y1pJxVrc0BVqhU5aJoWphCdYtMxGXno2b/WPGQy8KVlJlyq16BO0lguET6PfpEgaFbImWfc4cuUvsoRPrjeHbAklNm9Nxcr4P+l3PXmPVoIDy1avMAXMyizyj+wcqWPNYOuaohZbZNpsl7y33VrkITEMOp+hLHkkYxzjGppoxLvhcftksaYuZYQIBB1PVUbmz8/R8mOjJlBisZ4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIu7C/vmvQNtCEWuo7uM4e6N4y7eAtQc47PvC26lyU0=;
 b=Jf9/QrhraE6NNPHMWyEkaFCY1asNmRN9Gw0luTCl4Tp91ljN38iryBjPbLnvgl4qQNCATI0Wo8S9fbgSQEQT8vquLlY/9R7eaK4kX0+liraovN7oDfsD3WSE5rEhGOdcVLM80f4om9QZXXsxsyCXeZ1OqMUd/nrNglWJ9Tn63/WYk1qvYA+V1VrEeKm9t+dUzjGM//WEh5p1Ml4pIq818+/SQEiaY5+MGnWYzXka5fvLpFfvFLjBSHK4mcADI8Vgkt1+gbQK6Q/cxcG+aEPVDMfvVYwg1EBmCigtD2rNsgw8VIPsv6QCootKr0uA6wtHXfu8PyaRIhDt6UlFyBw3cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIu7C/vmvQNtCEWuo7uM4e6N4y7eAtQc47PvC26lyU0=;
 b=PPiczXsG9+u1BrCmh1TTE1szAWC8IXjClvzIoC0J1KHZhabarGS7qqa30UuZLjzSsV0SqQZIGlaLUkLKSE/L+VxBlkbF5+/lt8LQUqmrKB4hhDXzg3niWPFH6Njc9hd+1didtqwdjharhzmHnqPjERiPjGYGIxnqYYn97x/nRLw=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 16:12:39 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 16:12:39 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fallback to pipe reset on queue reset fail
 for gfx9
Thread-Topic: [PATCH] drm/amdkfd: fallback to pipe reset on queue reset fail
 for gfx9
Thread-Index: AQHa5PprKQd9H7GTM0GN7sauDPGH27IfHuqAgAABeTA=
Date: Fri, 9 Aug 2024 16:12:38 +0000
Message-ID: <CY8PR12MB7435163B964B502CE4C7FCF685BA2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20240802163813.1800438-1-Jonathan.Kim@amd.com>
 <CADnq5_MbRQ36OD73oWv5o9rGS0X=LkibmdC14m-=VoQMtzeTEw@mail.gmail.com>
In-Reply-To: <CADnq5_MbRQ36OD73oWv5o9rGS0X=LkibmdC14m-=VoQMtzeTEw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=fc2461f6-0477-4fb3-986a-f39316b6318d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-08-09T16:12:24Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|MW3PR12MB4492:EE_
x-ms-office365-filtering-correlation-id: df1708c0-e3cd-4204-9557-08dcb88e16fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z1hJQk16RVJhYi9sRFZTMmRQSzcvSDlSUktKT1JrZ3JpY2VBdUo3M2FPTmhX?=
 =?utf-8?B?OFBLQ2pzQW02alMxYnNJZEMzQ0RaRCsyQk92RDVDVHUzRTFiRmxtY2lmNFVi?=
 =?utf-8?B?R0IwRDdBVUJ3TEw2aE5NdURZRnZrdTBId1FvdkFSK3l0a0VIQ1NnR1hGTVph?=
 =?utf-8?B?ZTRZOUU1ZjF3UHNrQ2k4V1Q1WEJsNTJ3eU5jdEUxV1VUMXVsbk9TWFowY3ky?=
 =?utf-8?B?cVhCMHFxbDdGM1d3VkJrWmtTQUw2MXEyVExaWEI4OTNlWEpaVDI2dElod0dv?=
 =?utf-8?B?ejZRNmdOVUIvT3lnYWhPckRxeHJGZUE2SllBaTg2QTRNcXp1dzNYREVRWEtK?=
 =?utf-8?B?V09lM1NsMk81NFpkK3lONndnbmdrZVREWTJjWGp1dmxmNWxOdjc4TmVwRVlY?=
 =?utf-8?B?MFFqVUdNQlFxdXNpdHdYeVViVldNQkZjQ3ZpbExlK2hxRWR1SndkQlpEMit0?=
 =?utf-8?B?a3lxVXBVZzVjblhUdlhhWE5rMkN3VXVlM0lTakRxVnZ6dUY2c1o4U1JoT2M1?=
 =?utf-8?B?c2ExK3dKNXA2eUp2ZUJTSjIxNXdUMSs4SllEYnlOd3UyV1crQk9Zazc3OXZT?=
 =?utf-8?B?blJmT2Zsb1I3eGw2c3hWZk5zTjFWbjVDRkQ5aDV2cWxHQ1Z4RUJGTG9WS3Uw?=
 =?utf-8?B?SWlQNWgyMDh1U25vNjRsS0tvMm5POVNNK05JSk5mQ250MTZyT0xBYnNJbHMx?=
 =?utf-8?B?dGJHdjRudWk2c1owYVRPVHNPWnZseUFlY2xUSDYvREM4WlZObFlkS3ZuOG9X?=
 =?utf-8?B?cm9pWWs5bUVDOGlBYklLS3VEVzM3Z01CQ0FMbkcrMThLQTVzOVdHWDRJL0h4?=
 =?utf-8?B?TXR4Q2dhNHhUR3pZOXFscUh0VUlOUzZnaHN3cVJvakIrRXdaUmZNd0ZuQnZJ?=
 =?utf-8?B?ckhndDZqY0V5aERoRmRpSnZNd2FMVVhTNkNXWmlId3NHVjIzaW0xS3lONnpR?=
 =?utf-8?B?MU1DdFNFclYzRlNZN2IrOEJzRmVBaG4va2hyNDZWb1RLd0VJSDBaai9LdGI4?=
 =?utf-8?B?ZE56V256OWdEcUs0b004NHFqVHhQbWo0U2JSN2ZGZ0tjUUxOVG82M1QrLzVJ?=
 =?utf-8?B?OXFRTitVNnRaN3NDbS9Rb3I4V3ZPenBteGdEcmoyWGdoczFTa1NIZmwxRUFU?=
 =?utf-8?B?Rnl6eWlZZmFKeENMRW54V2tzREFtRWo0YXlodzN0azUwY0F4aXpDMy92dlZG?=
 =?utf-8?B?MCtaZFA0cm1ROHU0Z091a3JrWEdqT2NiVkhiak9VcTNDcjVBdlh0U3dRbTAx?=
 =?utf-8?B?bU1EdGVGZEVtZXRZeTZlNktwWGQ1Yit0aDU4RlJ5ZUZrQ2lZbzR4MmQ1WHdS?=
 =?utf-8?B?WlQ1N1l3aCs4MkVJUTBhVWREOSt0SW5YTVZzUDZOL0JYSUtxRXI5c3ZXampZ?=
 =?utf-8?B?OVkvclAwOTl4QlJ6djlFd0NJRlRHbXdaOWJrenJIY1IyRWUvb1cxY1RyTDk2?=
 =?utf-8?B?VG96MWhQUnlscVUzejhPNkhHSFgzU3RSS0FLWlNDaGVuak5XTlc2b3ZLN3dD?=
 =?utf-8?B?K0FmRzJhVW15VjVxMDJsMGMvMmhmck12cGRkc2FKOGNRTzNWQWdMd1d5OUNs?=
 =?utf-8?B?M3FHd2t4R1VhbCtaeVRpZU1Nd3VpK2drWVhJZ3lSZkZES0lodGE5SGg2QytG?=
 =?utf-8?B?anhxSnl2ai9idzlycTdGMFJQUlNyVGd5NGc3Zks3UDZ4bDZkcXNITDdqWEhy?=
 =?utf-8?B?MmZEM09yMFVvZllibUJtVm82dHZiQ3ppREJhbHh0TlJGbkJ3YmRoUlU0b0d3?=
 =?utf-8?B?MEE0blBXUS9mTGwxVldJKzY2cUdOQnBtWnVxSTdNekVrMWV0SmRHcDBPWWV1?=
 =?utf-8?B?eFRlTU05U05KSDBrK1hZMWYvUXlCU2NzbUYxTTdiQVdmRmI4eEtmVk1HSkZs?=
 =?utf-8?B?Z1pQOU9vNkRJZ2ZOUG5FRUIrcFM1bzFWK0kxL0Rjb3k3cEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0ZSZGZkMThsQVFreUpEek9iek43YnJmYnc4N2Z3amlmV2NzaGlqQzBCaFJZ?=
 =?utf-8?B?RTdaM0tKSkFhYlM0NzMwdTlkaDF6OEYydlJ0Z0cydHJXSE0reUxGSjVnc29s?=
 =?utf-8?B?UEVJaUxNdWFKM213aEdxazJvajlLM0hUTGhIS1UyWEl3RklZTTQ4eTV2NEZR?=
 =?utf-8?B?R3lHNDlSMzY2eTFqN1dWNkk5Y3NqK3g0bks5ZEZEQ1VweGxRdUFZM0dyK1JV?=
 =?utf-8?B?WVRVMnQ1N2o4VWlBd3czMHU3bWpmTFJjbXBjeFdLTDN0WGlCUVpEaDY2L053?=
 =?utf-8?B?dGlZVmJHY3dyOE5VL1RBYURLdk4vK0hNR1c3aHZKY3kxSlgzZXNOcnY0S2I4?=
 =?utf-8?B?UjMxR1p4NStlWlhHNUJ2cGMxWnE1SVNuTm42Si9DYjF6TkpYais4cVFaMU5k?=
 =?utf-8?B?aktteGpQNCtPMk1zUEpsdjR2bnhyWjY0R28vNkxkd2VVV3lCRkhWTzJtMHlO?=
 =?utf-8?B?bG1GK0RYeGpkc2JGN2lqcHFjNlVaZkhnUUM5QVJJVFpMSG5zQXJoQ201Q1pO?=
 =?utf-8?B?d0Y0Vyt6RlNKVGk1cDhHQnVrZlowckFvOUpuNkpyRUJZRkVTdTRuUnpsQ3dU?=
 =?utf-8?B?Yk1JeklwU3RicjJXR2JiUCtmSjdiTTMzNWtJOWVEUmZIYXdqRnhuVVZoK1pK?=
 =?utf-8?B?bG9xeXlCUzNMYVhEeklQSWhRRnNiR1RVUzVhMXFkR01XN0xOL3EyUFhnemdL?=
 =?utf-8?B?MDJhaHdWZDdzVk1wc25VbjB1cHludDJWVUR0bnluL05iTlBtaUZyZHplTmVG?=
 =?utf-8?B?VUlEcXo3aUNlakgvK2dIemYya09XQ0FrWDlzcnZwNVZvaHovQUZjS1pMUVg5?=
 =?utf-8?B?NS9XRDJVNFdxU1JEYkwvUVVQcVowSmtpRll1cFJ2S01QbWNmTU04U01VVTZa?=
 =?utf-8?B?NElCUlJlelN3a2V4Z0g4M01PSU1zMTkxaktnRnpBNHpuWEk3bFFDV3FtWG5t?=
 =?utf-8?B?enN4Q2VZNkNPZzlMTkEyUGRSQ0RhR2preUR6YnJmQlVneFpHQzFRZ2d4SVdD?=
 =?utf-8?B?ZkU3UFllNjBVVnlMVlFxaitLZDExbDZQdklSdjRJbWE2RmJXWEZ4dGRNMXF3?=
 =?utf-8?B?OVQ3YVIveHc1bk4zR3NHWk9kSHE4S0xRUHk1UGFIbS93Q2lLVWN5bXc5QUxJ?=
 =?utf-8?B?Szk1dnBPdHlYS0NvVTA1UU9ldDhRM2xicDVSM1RJMUxJaW01alNIR0RpdXU0?=
 =?utf-8?B?MGpoK0R3TzlQWmxjZUZCa0cvdnpIV2lTQmZFOEQweHEvMjlZM09YaTdWdHds?=
 =?utf-8?B?ZkVOMUZ5VFVHSk01c1VMNUxsc21PRitGY0dFOTN6WFY2dGx3VDg1OUV6Tzdm?=
 =?utf-8?B?NzJ6R3YyVTh2S244enNhbStuT1dYRHNSblp5WklDRzJBNllGbjNwT1NwZjMx?=
 =?utf-8?B?VGVLOEtvMFEzUFlTTzVMYU9HQUwva3lFbEZmKzU3RUd3QVZ6MzIvTXh5Q3k1?=
 =?utf-8?B?T3IxNG9BZU5sRzI2clUxdk5MblcreE1YMFBkTXdpTm52TDhkSXJybm5BOU01?=
 =?utf-8?B?NXM0WFpMWDhqQXI5R0hVZS9IWXZkYURkcXRTbzkrOFFUTVd1SmVVRUJkZXA1?=
 =?utf-8?B?UzMxWXBlL0FxRXhrY2dNV0luYUhPaTZhdjdOUnBiUC9ZMjIzZ2hQSUErbDRa?=
 =?utf-8?B?ZElZTXgyYXJSVWNLK0NOSHNzTkNyQ3dLb1RDQ1NBdkQ1TkEzRGxJTUhEa0x3?=
 =?utf-8?B?Vk9VNEh0T0wvSVRkQVRFd3NHdXl4UEVzUWpEWHd1OFVrbGZkYWphWVRoV3dp?=
 =?utf-8?B?Zkx3UjVNVTJ0Ui9UTzIyYWdEM0RHUmpDb3RUSHZJVGVPbDZ1Undlc1lzd3JI?=
 =?utf-8?B?WEpaSU0zNkdQeHNGMDJuMWJocGc2am0reCtiN3FNTU5sRFh5OXQySlNib3o2?=
 =?utf-8?B?NkRBaE9UVi9UWGpUck9WYnFCbk50WThoNEhRMjJYTHhYcnFHL2tDOXlFMVR5?=
 =?utf-8?B?N255cWVNMExrdnM1QzhDUmNWQ2VoT3V2U0VhTVRxZHN4OVlLdy80dHNMT2s2?=
 =?utf-8?B?MkdNTUNjU3RBdWRUdWVraXdSdFJhaHB2ZVNwWmJoajB0elZLSERjV0FBdDZt?=
 =?utf-8?B?TFF5T0JNcnd3di85czNOOWJzRHYwM2hkTmlWamMraEVyd2NHWEtCVXVPV3Av?=
 =?utf-8?Q?zoqw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1708c0-e3cd-4204-9557-08dcb88e16fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 16:12:38.9877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jdyDEc7GI6UD0QUOOcZKqnUPbRJbOVcZ1ndGrlfDyCvyErEjRgLJQwAyWJ4MQzgc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgOSwg
MjAyNCAxMTo1NSBBTQ0KPiBUbzogS2ltLCBKb25hdGhhbiA8Sm9uYXRoYW4uS2ltQGFtZC5jb20+
DQo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgS3VlaGxpbmcsIEZlbGl4DQo+
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1ka2ZkOiBm
YWxsYmFjayB0byBwaXBlIHJlc2V0IG9uIHF1ZXVlIHJlc2V0IGZhaWwgZm9yDQo+IGdmeDkNCj4N
Cj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3Vy
Y2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNr
aW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBGcmksIEF1ZyAyLCAyMDI0IGF0
IDEyOjM44oCvUE0gSm9uYXRoYW4gS2ltIDxKb25hdGhhbi5LaW1AYW1kLmNvbT4NCj4gd3JvdGU6
DQo+ID4NCj4gPiBJZiBxdWV1ZSByZXNldCBmYWlscywgdGVsbCB0aGUgQ1AgdG8gcmVzZXQgdGhl
IHBpcGUuDQo+ID4gU2luY2UgcXVldWVzIG11bHRpcGxleCBjb250ZXh0IHBlciBwaXBlIGFuZCB3
ZSd2ZSBpc3N1ZXMgYSBkZXZpY2Ugd2lkZQ0KPiA+IHByZWVtcHRpb24gcHJpb3IgdG8gdGhlIGhh
bmcsIHdlIGNhbiBhc3N1bWUgdGhlIGh1bmcgcGlwZSBvbmx5IGhhcyBvbmUNCj4gPiBxdWV1ZSB0
byByZXNldCBvbiBwaXBlIHJlc2V0Lg0KPg0KPiBJcyB0aGVyZSBhIHNwZWNpZmljIENQIG9yIFBT
UCBmaXJtd2FyZSB2ZXJzaW9uIHJlcXVpcmVkIGZvciB0aGlzPyAgSWYNCj4gc28sIHdlIHNob3Vs
ZCBjaGVjayBmb3IgaXQgYmVmb3JlIGF0dGVtcHRpbmcgdGhpcyBpZiBpdCB3aWxsIGNhdXNlIGEN
Cj4gcHJvYmxlbS4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3IEFsZXguDQpXb3JzdCBjYXNlIGlz
IHRoYXQgdGhlIE1NSU8gcmVnIHdyaXRlIGRvZXNuJ3QgZG8gYW55dGhpbmcgYW5kIHdlIGVuZCB1
cCB3aXRoIGV4dHJhIENQIGFjdGl2ZSBwb2xsIHdhaXQgY3ljbGVzIGJlZm9yZSBmYWxsaW5nIGJh
Y2sgdG8gYWRhcHRlciByZXNldC4NCldlIG1heSBydW4gaW50byBzY2VuYXJpb3Mgd2hlcmUgcGlw
ZSByZXNldCBkb2Vzbid0IGhlbHAgYW55d2F5cyBldmVuIGlmIHdlIGRpZCBoYXZlIHRoZSByaWdo
dCBGVy4NCg0KSm9uDQoNCj4NCj4gT3RoZXIgdGhhbiB0aGF0Og0KPiBSZXZpZXdlZC1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPg0KPg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogSm9uYXRoYW4gS2ltIDxqb25hdGhhbi5raW1AYW1kLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgLi4uL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jIHwgNDYN
Cj4gKysrKysrKysrKysrKy0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9u
cygrKSwgMTUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYw0KPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ2Z4X3Y5LmMNCj4gPiBpbmRleCAzMmYyOGMxMjA3
N2IuLmM2MzUyOGE0ZTg5NCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkX2dmeF92OS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9nZnhfdjkuYw0KPiA+IEBAIC0xMTczLDEyICsxMTczLDMw
IEBAIHVpbnQ2NF90IGtnZF9nZnhfdjlfaHFkX2dldF9wcV9hZGRyKHN0cnVjdA0KPiBhbWRncHVf
ZGV2aWNlICphZGV2LA0KPiA+ICAgICAgICAgcmV0dXJuIHF1ZXVlX2FkZHI7DQo+ID4gIH0NCj4g
Pg0KPiA+ICsvKiBhc3N1bWUgcXVldWUgYWNxdWlyZWQgICovDQo+ID4gK3N0YXRpYyBpbnQga2dk
X2dmeF92OV9ocWRfZGVxdWV1ZV93YWl0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiB1
aW50MzJfdCBpbnN0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHVuc2lnbmVkIGludCB1dGltZW91dCkNCj4gPiArew0KPiA+ICsgICAgICAgdW5zaWduZWQgbG9u
ZyBlbmRfamlmZmllcyA9ICh1dGltZW91dCAqIEhaIC8gMTAwMCkgKyBqaWZmaWVzOw0KPiA+ICsN
Cj4gPiArICAgICAgIHdoaWxlICh0cnVlKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHVpbnQzMl90
IHRlbXAgPSBSUkVHMzJfU09DMTUoR0MsIEdFVF9JTlNUKEdDLCBpbnN0KSwNCj4gbW1DUF9IUURf
QUNUSVZFKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIGlmICghKHRlbXAgJiBDUF9IUURf
QUNUSVZFX19BQ1RJVkVfTUFTSykpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IDA7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICBpZiAodGltZV9hZnRlcihqaWZmaWVzLCBl
bmRfamlmZmllcykpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FVElNRTsN
Cj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHVzbGVlcF9yYW5nZSg1MDAsIDEwMDApOw0KPiA+
ICsgICAgICAgfQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICB1aW50NjRfdCBrZ2RfZ2Z4X3Y5X2hxZF9y
ZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1aW50MzJfdCBwaXBlX2lkLCB1aW50MzJfdCBxdWV1ZV9pZCwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBpbnN0LCB1bnNpZ25lZCBpbnQgdXRp
bWVvdXQpDQo+ID4gIHsNCj4gPiAtICAgICAgIHVpbnQzMl90IGxvdywgaGlnaCwgdGVtcDsNCj4g
PiAtICAgICAgIHVuc2lnbmVkIGxvbmcgZW5kX2ppZmZpZXM7DQo+ID4gKyAgICAgICB1aW50MzJf
dCBsb3csIGhpZ2gsIHBpcGVfcmVzZXRfZGF0YSA9IDA7DQo+ID4gICAgICAgICB1aW50NjRfdCBx
dWV1ZV9hZGRyID0gMDsNCj4gPg0KPiA+ICAgICAgICAga2dkX2dmeF92OV9hY3F1aXJlX3F1ZXVl
KGFkZXYsIHBpcGVfaWQsIHF1ZXVlX2lkLCBpbnN0KTsNCj4gPiBAQCAtMTIwMiwyNSArMTIyMCwy
MyBAQCB1aW50NjRfdCBrZ2RfZ2Z4X3Y5X2hxZF9yZXNldChzdHJ1Y3QNCj4gYW1kZ3B1X2Rldmlj
ZSAqYWRldiwNCj4gPiAgICAgICAgIC8qIGFzc3VtZSBwcmV2aW91cyBkZXF1ZXVlIHJlcXVlc3Qg
aXNzdWVkIHdpbGwgdGFrZSBhZmZlY3QgYWZ0ZXIgcmVzZXQgKi8NCj4gPiAgICAgICAgIFdSRUcz
Ml9TT0MxNShHQywgR0VUX0lOU1QoR0MsIGluc3QpLA0KPiBtbVNQSV9DT01QVVRFX1FVRVVFX1JF
U0VULCAweDEpOw0KPiA+DQo+ID4gLSAgICAgICBlbmRfamlmZmllcyA9ICh1dGltZW91dCAqIEha
IC8gMTAwMCkgKyBqaWZmaWVzOw0KPiA+IC0gICAgICAgd2hpbGUgKHRydWUpIHsNCj4gPiAtICAg
ICAgICAgICAgICAgdGVtcCA9IFJSRUczMl9TT0MxNShHQywgR0VUX0lOU1QoR0MsIGluc3QpLA0K
PiBtbUNQX0hRRF9BQ1RJVkUpOw0KPiA+ICsgICAgICAgaWYgKCFrZ2RfZ2Z4X3Y5X2hxZF9kZXF1
ZXVlX3dhaXQoYWRldiwgaW5zdCwgdXRpbWVvdXQpKQ0KPiA+ICsgICAgICAgICAgICAgICBnb3Rv
IHVubG9ja19vdXQ7DQo+ID4NCj4gPiAtICAgICAgICAgICAgICAgaWYgKCEodGVtcCAmIENQX0hR
RF9BQ1RJVkVfX0FDVElWRV9NQVNLKSkNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBicmVh
azsNCj4gPiArICAgICAgIHByX2RlYnVnKCJBdHRlbXB0aW5nIHBpcGUgcmVzZXQgb24gWENDICVp
IHBpcGUgaWQgJWlcbiIsIGluc3QsIHBpcGVfaWQpOw0KPiA+DQo+ID4gLSAgICAgICAgICAgICAg
IGlmICh0aW1lX2FmdGVyKGppZmZpZXMsIGVuZF9qaWZmaWVzKSkgew0KPiA+IC0gICAgICAgICAg
ICAgICAgICAgICAgIHF1ZXVlX2FkZHIgPSAwOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOw0KPiA+IC0gICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICBwaXBlX3Jlc2V0X2Rh
dGEgPSBSRUdfU0VUX0ZJRUxEKHBpcGVfcmVzZXRfZGF0YSwgQ1BfTUVDX0NOVEwsDQo+IE1FQ19N
RTFfUElQRTBfUkVTRVQsIDEpOw0KPiA+ICsgICAgICAgcGlwZV9yZXNldF9kYXRhID0gcGlwZV9y
ZXNldF9kYXRhIDw8IHBpcGVfaWQ7DQo+ID4NCj4gPiAtICAgICAgICAgICAgICAgdXNsZWVwX3Jh
bmdlKDUwMCwgMTAwMCk7DQo+ID4gLSAgICAgICB9DQo+ID4gKyAgICAgICBXUkVHMzJfU09DMTUo
R0MsIEdFVF9JTlNUKEdDLCBpbnN0KSwgbW1DUF9NRUNfQ05UTCwNCj4gcGlwZV9yZXNldF9kYXRh
KTsNCj4gPiArICAgICAgIFdSRUczMl9TT0MxNShHQywgR0VUX0lOU1QoR0MsIGluc3QpLCBtbUNQ
X01FQ19DTlRMLCAwKTsNCj4gPg0KPiA+IC0gICAgICAgcHJfZGVidWcoInF1ZXVlIHJlc2V0IG9u
IFhDQyAlaSBwaXBlIGlkICVpIHF1ZXVlIGlkICVpICVzXG4iLA0KPiA+IC0gICAgICAgICAgICAg
ICAgaW5zdCwgcGlwZV9pZCwgcXVldWVfaWQsICEhcXVldWVfYWRkciA/ICJzdWNjZWVkZWQhIiA6
ICJmYWlsZWQhIik7DQo+ID4gKyAgICAgICBpZiAoa2dkX2dmeF92OV9ocWRfZGVxdWV1ZV93YWl0
KGFkZXYsIGluc3QsIHV0aW1lb3V0KSkNCj4gPiArICAgICAgICAgICAgICAgcXVldWVfYWRkciA9
IDA7DQo+ID4NCj4gPiAgdW5sb2NrX291dDoNCj4gPiArICAgICAgIHByX2RlYnVnKCJxdWV1ZSBy
ZXNldCBvbiBYQ0MgJWkgcGlwZSBpZCAlaSBxdWV1ZSBpZCAlaSAlc1xuIiwNCj4gPiArICAgICAg
ICAgICAgICAgIGluc3QsIHBpcGVfaWQsIHF1ZXVlX2lkLCAhIXF1ZXVlX2FkZHIgPyAic3VjY2Vl
ZGVkISIgOiAiZmFpbGVkISIpOw0KPiA+ICAgICAgICAgYW1kZ3B1X2dmeF9ybGNfZXhpdF9zYWZl
X21vZGUoYWRldiwgaW5zdCk7DQo+ID4gICAgICAgICBrZ2RfZ2Z4X3Y5X3JlbGVhc2VfcXVldWUo
YWRldiwgaW5zdCk7DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
