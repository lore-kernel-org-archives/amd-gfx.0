Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B11ECD6F7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 23:56:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 663DE10E0E8;
	Wed, 11 Feb 2026 23:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eCel/5Wy";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010042.outbound.protection.outlook.com [52.101.46.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44A2B10E0E8
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 23:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w600Gdpxj/lE8hllVxB761qUcSnuHL41r8sasMnj3nvZ9YtprrTgu2/qnx798qYhyIKEAauTNG2uUSs2LhecinxRMMoo3jTAR0tUUWc5UWLn7lQe+JuuFQXq7R3Xj08I3w1LkB/MVgCi4gNhXb4/H/kp6lkZUItcNDEOHZbzti180egrFYEIFXkltOxP94/EcCfe6Q0ncJkG6505iaCCxMDIFpvnPq21DQlOdCGxG219ppUry5FaNVRyM6VL2bzvoAjAZ3FQRD+gUoINUmHkTdQJnrj+f/qQ6wMIFhYxyAzOSB/zd1NCszn3Q8rn/dCN7BsRVLrz3fZqT7wUUcfEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyJpATyi9qlLmG+KCaRioFPgP/MHmT8rjv5ofxaAYJg=;
 b=it9k5+Ppu/JVt7Dj6WOx6G1DEqjKalGVFh3A9BhLtD8NlsHKOG3zK6/SpYBMQdo/QH4DPWfn1dHGN0B59lMMfbBUHd8InuKD4YGyKIgBZ3mxzPZDMZ7PCsvtC36cc88XR0msvyT+hQJe1sC2O1ZhlMAfNtoxSPZqQgkdp0pfzImPBFyK6Edk6w4e7n9HgbNLRqOHWCFmkeObJNsOBByeFtm5jPKaDMGgvDXUnlr/I/jFv5scAZD3dU10ddj4hpqnBABVlFGsvJLmR3slYZHqejesJCdbpE9zxoH4D2SVtBKHuSIEnWm2K92VYpSKTxbxVr02de9AvbjJZRL4ZhKYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyJpATyi9qlLmG+KCaRioFPgP/MHmT8rjv5ofxaAYJg=;
 b=eCel/5WywKbId9Ig9X4DQkIiRyDJBK3h/Zat/wYx72Gy1jJDI+c8X+0vbt4qazkO9ZH1egU4uL3dwyHDQ1sHkoB0Yvol5ru3v6/85+GYh1xzPVChsijoCuwg5FxHuU5qLuFfhOrR5/9GYatqPuBIhQLpcWJ7bhM54nKqsO91/iM=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Wed, 11 Feb
 2026 23:56:26 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993%5]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 23:56:26 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "Greathouse, Joseph"
 <Joseph.Greathouse@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Disable MQD queue priority
Thread-Topic: [PATCH] drm/amdkfd: Disable MQD queue priority
Thread-Index: AQHclDI/Ec1gLN4ni0uYbIQTGxZ1sbV+DZGAgAAensA=
Date: Wed, 11 Feb 2026 23:56:26 +0000
Message-ID: <SJ0PR12MB813891AFF3C2E86CD448555EF563A@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20260202105326.140826-1-andrew.martin@amd.com>
 <bace01a8-f9ac-4d58-93a5-85df674631d3@amd.com>
In-Reply-To: <bace01a8-f9ac-4d58-93a5-85df674631d3@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-11T23:01:00.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|SA3PR12MB7902:EE_
x-ms-office365-filtering-correlation-id: 3aaf8aa1-0beb-4b16-f671-08de69c92b2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?MDBUOXptRHV6K2RlcHE2R0dmWjF5b0dDZ2YxSzArdjBNci9RQlN5UHp4K093?=
 =?utf-8?B?bTFvRTBWS0ZVcjYxaU81bjMxRE1tY0NRRHBOMW5oRVI2UmM1dXZwTWU5UGsw?=
 =?utf-8?B?WlFuKzhKeEdXOU5KTlRmWlJ2ck5MTEw0YXdYa0RRK3dpYi9YdVlValVqdWpl?=
 =?utf-8?B?ajZ6RzNlRmhpc3BNRk5sYjF1WjJPNVE1N0JjamxodlRZelZTYmNjcDN0czJq?=
 =?utf-8?B?eTdXT2tXZGIvd2RDNVNZV0NYYUlGanovZWNTQ0V3MkpNYm5zV2lUVVdWWWlQ?=
 =?utf-8?B?c1F3ZTU4a1BZVzFLc204NFUzNS9sMDUzWXgyZjNkUHIrVEltN2l0TnRzNkZX?=
 =?utf-8?B?MUhsN2JZT1NaV2dtWm5wQnpXZ0l4Y0RoekxOVWFTSUhvenVsU0ZpdVNEWjM2?=
 =?utf-8?B?TTg0QnJYMGhER3ZYV2NUbThCSVk1NFFvU1BTRkFVLzU0aXhCR2JycFdsYkpm?=
 =?utf-8?B?NXkrYnlidUhibEx3aVdWcG9XUkhWb1hBbDRNRlE2amJNNXpjUGEyQ1lGajJu?=
 =?utf-8?B?MXpuMUVjU0xnaW9xYXBXR0Q0Uis4UHpwdm1uK1Y0S21hbXJBU25DdHczOGdx?=
 =?utf-8?B?R0tIQWRZemtkbHpCQXk1S2tPWENBeVhXdFdZak1TbTJMV3J4M2Z4NTJyK0Fu?=
 =?utf-8?B?QmxTT1V5MzVOcnRkeExoT2ZhWW9kV2k1Ni9SOGxSNnhhZ3k3RkRLa0FQa0JT?=
 =?utf-8?B?blh5SVUxQTRFNUtzS1ZvUDNDNjhOYXRoQ0ZjZTFrdFUzb1Z0eUlaeThXNnlJ?=
 =?utf-8?B?dFBwNUI0T3J4MW16U0Z4UXRBZWRySE1QRGNGYWVSUklMa0hsSG9uWFh0M04z?=
 =?utf-8?B?VUVZSkprcHl2THg4eTZ0YTdPWGZkaHhhZUh6dXZ6bmhOZHA0Ri9PYTNCRW5K?=
 =?utf-8?B?Uk5iRWgxZ1Q1dFo5azRPUDVtV3E2S04vVklWem5hbjErMzZ3SklxQm9LOE85?=
 =?utf-8?B?WnlkditDNE5qN29MMituQmNOVWEzSUl6K2w3cS83QWEra2tvMFYrRWJVYUNT?=
 =?utf-8?B?RVp4ZDhkd2dSbkRjWHRFaU8vcm1VK29GSTkycVIzbVh3V0R0dEZlUmY5cFQ2?=
 =?utf-8?B?V3RVMG9MWjR1c3lheVpIZFpnc3BXdDcyZW5ySmZ4djZlQm95Wk9NYlhpTmhj?=
 =?utf-8?B?N0lnenFScnBwZzh6WEdydmpNMXA5WVcxRHRyV3hkeHBOYmt2Uk01Zm9mRlpN?=
 =?utf-8?B?Ujg3cG5FbGpUN3hpbllyTlRySzZvZWZHY0NyZnk1YlV5RTRQckw0NzBrRnNa?=
 =?utf-8?B?a25DZXhaLzJpakd4UW83dlVqWndzbGR5dVY4UnYvajVaRHp1V3ZiNzNTWVhB?=
 =?utf-8?B?ZldsVGVLdVpjbzdybUlkRDNmL1I1TkdQWDhpYVcwcnFmRUEyNjE0MVIrYjZt?=
 =?utf-8?B?NG1zT2RlQU10aUtQTXJzUWlXbUhpS3duM3V6L1ZIenhkQUpMcFVydnFJSlhO?=
 =?utf-8?B?RkYyV080Qk0vQ3A3NDR5dG8rRzNEZ0NPZzJnSVU4aGh2UFY3cENaSnhOSVFr?=
 =?utf-8?B?bkhiaG55aTFseVU4YWtkRWFDM1FHakZpMHJ3cmprcFdubzlUMTkyTUJFeUtS?=
 =?utf-8?B?eDFWS1hvQzRmcmRxb1pucUNXTWppbUpkcWlDWGhtRkN4a1RWYytRRTkzUS9F?=
 =?utf-8?B?ek1MdTFGZDN2NG05aGdFcXB2Q1poVm4wcHdYOHlwQk1nMlRwWE4wRVFpUDNl?=
 =?utf-8?B?ZTlqNHJOa2tPYU01S3NmV0xMeHRJbm1KV0k0b3c2Ky9XbStidVorell3VmRE?=
 =?utf-8?B?angwWkJSM3VualZGalc3OW94Zk1IbXRGNEZjWnIvRnhNN1Fab1pqanhCajZJ?=
 =?utf-8?B?VC9PaXg1R1FiOHp1NENoWTdBTlYxQ2tEZEZiak81ZDFDWUozVmdWMndKWkNp?=
 =?utf-8?B?eEhCYXM5Z1BQK3JoR3lobVFoM2oxWXFKdkFhRWVHd2k4UVVCOTdQYUVuZ3Er?=
 =?utf-8?B?K2VmQ3FIYVEwaTJHUzNsYnhzRkEzYWcrd1NDTXdpT0hEbFA3aUo2YmZvaGJq?=
 =?utf-8?B?UG1LdG43SmNPTkJCN2w4ZTEvTUpkL200cWJUVTRMRk5xNXJnQ0pBVkZkZGx5?=
 =?utf-8?B?OWRxYWVvcndjR1J6bWQ4VkkyZGZZeW03ZWJTQ1ViVCtnbHN0K25EZXdTTGJv?=
 =?utf-8?B?Yko4SVJBZU5TblpUeHZFbXE5NTFkaWY0UnZlcWtJR25NRGk1RlVMSGtjUkdi?=
 =?utf-8?Q?TvcJDosLLGB+bOGZlSI9Fqc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE12VHFHRy9QMFdBK2NRS1ZoaFBEeEt0QzFaQTgxVDluSjJXWG50ampSMmFM?=
 =?utf-8?B?MjNDK093SzJLaWJpRzNLZFlqOHJjZnF6c1BmNzVTUHp6MWQrbXV4MHk4UlZS?=
 =?utf-8?B?YmtlalBxdm5oMldVVkNSeHVlS3loam4xRHlVckhzTzVPZEQ4THd5YVJmRURh?=
 =?utf-8?B?OGQ0eGdKRmx0cC9icmVDa3VJemNpdGNpazIveEZpbFJtd1NDUGEvekVWblkr?=
 =?utf-8?B?cVFFRC9IVTQ4bzhHcmRuRTEwZWlSeGVIRXlDbFdHY1k5MDFVeEQ5bkdNejNO?=
 =?utf-8?B?cHc3V3ZBeG5MblZwNVZrNkI3bzFhOHpJczl3QTlsMGM2OEgvQk1IdkNpZ0FK?=
 =?utf-8?B?a1g5NjExaWpPUmREdmdZemdWRjVGSEF6MUpCR2QvR0xSN0hiaUt6WkVvdnVp?=
 =?utf-8?B?UklyQUkxUVZreXhnYWFSa1dFRy9BMWlDM3ZyWTVHVlFZajZ5a3k1Uy9YK1Ry?=
 =?utf-8?B?dmw3SHFuRzdlc1YyREZoQmJqNStVbGNEWWZ6Wnl5bytzdzFzWWZIOVp6NmZV?=
 =?utf-8?B?YTdmQjlWZ1B3VjVwMkpqZ1hJUjZzNXhocCswalRaUkJZOWNoUkVGNFNxdVlI?=
 =?utf-8?B?VVpMMGNTNEFWemtwOTN3RUlEdDVTMmtNRzdRMVQ3MDJmQnBJbVpGblk2L3Fn?=
 =?utf-8?B?WFZJaVZwaFg2R2hCa3NoVGpWaG01dVZLb0w3YW5YWmxteHpIQ0FTMXNJMnFJ?=
 =?utf-8?B?dUs3Q2xpdHg3UlNmWGNvTlV4d0JKTzBsYVR3QUhNYmFCRFVuM1lQVHNUaXB3?=
 =?utf-8?B?dEhSWDEzUThlZVVCazE4K2RHRGJ4RElnbDQ1bUs0Z3E0S0hib1JUamdxOXlr?=
 =?utf-8?B?VGVTU1FRTURNbjNYT00rUGx1NWFaVm9DL0N3bkFnUmVlL3RIYVJCUnBHT3I4?=
 =?utf-8?B?RFAvejRlK0ZNTThydFIzSzFJSkJKdzZXeHArVUMwNzEvRzBxcVBMZlJodDNo?=
 =?utf-8?B?dzFWelVUMFZaZGt4UTAvMytFeDZPSWNycDRDczBBa1ZseFpUUHFyU0JNQkNm?=
 =?utf-8?B?eDgyREpTTEVIb25DcnZVL0xCQlErOE9KSUtoRmJpcXcvMGVqVW5zd09YKzlI?=
 =?utf-8?B?S2FFME0zWUxxUVJPRVF4Zm5LRGI5RnFqUjlId3QwSmJVdVY1bm43R29TWnUr?=
 =?utf-8?B?SmxwSWYwdEtpSEc5czdiK1BROTczbGM5THVZNjR4dDVRNjFHdDRTaUtMSVU4?=
 =?utf-8?B?NXYrbDZITGdnUU9aL2ZhY0lHMk54WEkrWjB6QVAxM1hoQWwyY2ZuK2lBZDM5?=
 =?utf-8?B?Uzdtb1ZUa2xVSGpqeWZXZDNsZDhvYXZLZHlrSjVmb2VhWG1MMG0zcWhaQzM3?=
 =?utf-8?B?VnhJcmVGNGxyUk5mQUt5VlJ6NWNCWURxM1BYS09vV0RZcnovQW5BTDNrU2xl?=
 =?utf-8?B?NU1td01UTHFNNHZUQjRTTXdrNmZOc1ZOeEc3QzVEb3FMWnRWRThscGRYOW1a?=
 =?utf-8?B?TTZxYUI3WitHMGgvYjFRZVNzZSt4STFFODhTWjcxLzJ6cldvYkZ5c1g2VWlj?=
 =?utf-8?B?dUhDMFNxR0t0SHRtZm9ETnlNOUdXNHZmeFBFZjgvRE82TkdQUkV6dklUanJz?=
 =?utf-8?B?RHREZDVVaFlJQjV6dm8ybit1YlpmbFg2SjdBNXVBdzNqdktmUm82VVAyd3p1?=
 =?utf-8?B?eFp1VktyTkhZdXAxdlpscGtkRTdBb1ZGd0kxSHJiYnU0R01tTzBidHM0elRi?=
 =?utf-8?B?elZiYVdVWFF0VzVwWThGNTRNek1nK3ViK2s0Z080VFN0NDZyM2xuYzdCaDRF?=
 =?utf-8?B?bnhKQURicFppOSt1S2VETEwzczBZbFQxamJZaStYK2xtYUZhZE43K3ViejhL?=
 =?utf-8?B?MFd6NmxPU3kxSnd6L2NJLytHSVMxRE9KbDB4QzlsKzNrVWUvS0tFS2xYRktS?=
 =?utf-8?B?Mzl4SGpvQU04VGhVMmZIUHFwOUc4ZTk1UDV3TE55N052WGM1elpLY2llSXBM?=
 =?utf-8?B?V0x5VllsMXV2NHlTMGxnWDVud0p2QmZINDVqN2FhTmxrK3ovYUwvcHEySm5w?=
 =?utf-8?B?REtNWEZCZVA5M2dzbFhoclpINlpRR3BQY3Q5YTRKWHBLdDJBVmFGakkrbSs0?=
 =?utf-8?B?NTZtT2traFlLMTRUbS9YblJ4a2ZVTmF2Yk5aK1U4UU45OHhRNFJoeTBpTC9t?=
 =?utf-8?B?RTkyU3VmVGFrZWJtdWxpcXluU2JPcHExRzV2SWJZSER0bkExaXZJTzM1Y2Fu?=
 =?utf-8?B?blphZ202VFdHL3JOS2NCR2tBam95YmxXWkg2Ky9zNWFrYU5URWFFWk95YkQ3?=
 =?utf-8?B?bXlOdUxaV1NUMk1Rc2xVaVIzaUpCaFBZbXdlek1KeGZlc1JVTFVSbklscmlN?=
 =?utf-8?Q?2s1x4dNEXFttf17OKo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaf8aa1-0beb-4b16-f671-08de69c92b2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 23:56:26.6266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCJldknOpOo2DIF5TLNRvqiMkpFCwVkJfVZgZRdW2KRqfL0WRA8GRqNUp/Pr4R8al90LaTJT8mMlFqVsGDvW0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KRmVsaXgsIHRoYW5rcyBmb3IgdGhlIHJlcGx5LiBTZWUgY29tbWVudHMgaW5saW5lDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxp
eC5LdWVobGluZ0BhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDExLCAyMDI2
IDQ6MTEgUE0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBNYXJ0aW4sIEFu
ZHJldw0KPiA8QW5kcmV3Lk1hcnRpbkBhbWQuY29tPg0KPiBDYzogQ29ybndhbGwsIEpheSA8SmF5
LkNvcm53YWxsQGFtZC5jb20+OyBHcmVhdGhvdXNlLCBKb3NlcGgNCj4gPEpvc2VwaC5HcmVhdGhv
dXNlQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IERpc2FibGUg
TVFEIHF1ZXVlIHByaW9yaXR5DQo+DQo+DQo+IE9uIDIwMjYtMDItMDIgMDU6NTMsIEFuZHJldyBN
YXJ0aW4gd3JvdGU6DQo+ID4gVGhpcyBzb2x2ZXMgYSAicHJpb3JpdHkgaW52ZXJzaW9uIiBpc3N1
ZSwgY2F1c2VkIGJ5IHRoZSBsYW5ndWFnZQ0KPg0KPiBXaHkgdGhlIHF1b3Rlcz8NCg0KQ29uc2lk
ZXIgdGhlbSBkcm9wcGVkIGZyb20gdGhlIG5leHQgZ2l0IGNvbW1pdCwgIGl0IHdhcyBqdXN0IHRv
IGhpZ2hsaWdodCB0aGUgcGhyYXNlLg0KPg0KPg0KPiA+IHJ1bnRpbWUgbWFraW5nIGhpZ2gtcHJp
b3JpdHkgcXVldWVzIHdhaXQgZm9yIGFjdGl2aXR5IG9uDQo+ID4gbG93ZXItcHJpb3JpdHkgcXVl
dWVzLg0KPg0KPiBJcyB0aGlzIHByb2JsZW0gc3BlY2lmaWMgdG8gR0ZYOT8gT3RoZXJ3aXNlLCBh
biBlcXVpdmFsZW50IGZpeCBzaG91bGQgYmUNCj4gaW1wbGVtZW50ZWQgaW4gb3RoZXIgdmVyc2lv
bnMgb2YgdGhlIE1RRCBtYW5hZ2VyIGFzIHdlbGwuDQo+DQoNCk5vLCAgaXQgaXMgbm90IHNwZWNp
ZmljIHRvIEdGWDksIHNvIEkgd2lsbCBicm9hZGVuIHRoZSBjaGFuZ2Ugb24gdGhlIG5leHQgcGF0
Y2guIEkgd2lsbCBnZXQgdGhhdCBvdXQgdG9tb3Jyb3cuDQoNCj4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEFuZHJldyBNYXJ0aW4gPGFuZHJldy5tYXJ0aW5AYW1kLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5jIHwgMiAr
LQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9t
YW5hZ2VyX3Y5LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFn
ZXJfdjkuYw0KPiA+IGluZGV4IGRjZjRiYmZhNjQxYi4uYmM0Y2ViYTM1OTA4IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5jDQo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMN
Cj4gPiBAQCAtMTA2LDcgKzEwNiw3IEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV9jdV9tYXNrKHN0cnVj
dCBtcWRfbWFuYWdlcg0KPiAqbW0sIHZvaWQgKm1xZCwNCj4gPiAgIHN0YXRpYyB2b2lkIHNldF9w
cmlvcml0eShzdHJ1Y3QgdjlfbXFkICptLCBzdHJ1Y3QgcXVldWVfcHJvcGVydGllcyAqcSkNCj4g
PiAgIHsNCj4gPiAgICAgbS0+Y3BfaHFkX3BpcGVfcHJpb3JpdHkgPSBwaXBlX3ByaW9yaXR5X21h
cFtxLT5wcmlvcml0eV07DQo+ID4gLSAgIG0tPmNwX2hxZF9xdWV1ZV9wcmlvcml0eSA9IHEtPnBy
aW9yaXR5Ow0KPiA+ICsgICAvKiBtLT5jcF9ocWRfcXVldWVfcHJpb3JpdHkgPSBxLT5wcmlvcml0
eTsgKi8NCj4NCj4gUGxlYXNlIGRvbid0IGxlYXZlIGNvbW1lbnRlZCBvdXQgbGluZXMgaW4gdGhl
IGNvZGUuIFRoYXQncyB3aGF0IGdpdA0KPiBoaXN0b3J5IGlzIGZvci4NCj4NCj4gUmVnYXJkcywN
Cj4gICAgRmVsaXgNCj4NCj4NCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIGJvb2wgbXFkX29u
X3ZyYW0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo=
