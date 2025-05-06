Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C68DC3ABBE
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 08:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF93710E11A;
	Tue,  6 May 2025 08:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tl2gAAiy";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDECB10E11A
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 08:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaCBxYsWsJiETCk4tH1rqxgzNDkU1G24FkajMhPC/fw/HmwxBkXTqcUVILBM2l5Y+ZQsfUnVV8tiamMvCKRnUfEwOsb1AIoLGl9Aup21m4gNgMJtDqEcIb/T45iZCh++LxgHtZ7t9utb5C1sZ7QAtRMpa8AQl4S/CB0DXiepj94mSzFHeCBfcYZz/QiBVwR9zwwzyhAONDHBEZrQp6MklPRqOU+Z+2ofu6DLuX+Lonu7M3zG/7I1zLZaqSqjeQn7ha7AZXIXcug31ceudqTTj7/Jp4S0JADTLpa4roNe8McNaRwvAY76+Q5c/aoUSQwXz718v2BzD4Wcn/QM77uZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vntW3zzcfNe0rymj0LUYS3xme448aFAJMzFzKMUHMKY=;
 b=uVWzvN9fN8FloJRAE3b22BifY9SYD35rNvYQPp66Kk1Krj45wY+e+JBRD2kUcxwgxxl3zwIcdwk0pIRLXpPg3SqoI8oW/D40WDOR+yucIcfHgKxmDhQI5k0G4n26189vhq+LC811J26nXX0tEaUpDBkMY3jjk/cllPhFbfqdvyc2GjsvVTPYcevIqKH7FTLJyhqsOUZm0Byp9Z5AzBwMvs61xnr4W9VyKIbTRgDuUa3lPqH/GtVqQ+mrLNH9YBln7C6CLg9GCEar+7R8WJpOutbIVZwvCM9oSQbLW4c+PkzbW1NmUKHYOTWt3n3QMzpUV3BAQUzza5DFBAMfK89tKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vntW3zzcfNe0rymj0LUYS3xme448aFAJMzFzKMUHMKY=;
 b=Tl2gAAiyl9h+abQqvS5Dx98nOw+QeFIZMNByhzNocjaPHu86cRRTdJcxb7D7y3lAjJqZ0WdJ1MHFrMg088InFeq/AR8DczBkcPnr3UO8jpXVKkDq4GmXRfIHtBYnRTUfKETBOZa8olQdl+1/OQ9wtDcZEnNA/vIJl9TZL2CXlKY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.25; Tue, 6 May 2025 08:22:08 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 08:22:07 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v3 4/5] drm/amdgpu: validate the eviction fence before
 attaching/detaching
Thread-Topic: [PATCH v3 4/5] drm/amdgpu: validate the eviction fence before
 attaching/detaching
Thread-Index: AQHbuXlYV72zWkIYkEm/msCIUTRZELO8HE2AgAkuSkA=
Date: Tue, 6 May 2025 08:22:07 +0000
Message-ID: <DS7PR12MB6005615C194915A4C862CBF1FB892@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250430024054.4093239-1-Prike.Liang@amd.com>
 <20250430024054.4093239-4-Prike.Liang@amd.com>
 <62a987a4-d865-4b64-8cb2-a664e7969233@amd.com>
In-Reply-To: <62a987a4-d865-4b64-8cb2-a664e7969233@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=cbf1212d-f6a8-4aed-8d04-7e729d71c754;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-06T08:13:48Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CYYPR12MB8870:EE_
x-ms-office365-filtering-correlation-id: b7e97347-016c-4af3-6123-08dd8c771715
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?VFVkQktXWldIL3hHK1Z0N3hhNGFlNFBKT2MzL1duby9GWGxNZDNiQU04bmxF?=
 =?utf-8?B?enRCdTVEemgwVEJMelRQamlySDgzSExzUzdobmNzbGQ3UjVkSkxibXdMbFpl?=
 =?utf-8?B?WHNzekNTbEdGRmFUK2N6blZ5T0lNL1lTYzBBRFFLM3l3alVMclQ4M3cwRXZI?=
 =?utf-8?B?aFFqekdSVk8rTU9yRCtYbXNPbHBKdmZoazY0YUlSL1V3MkJXd2VPc3lEanFk?=
 =?utf-8?B?cXgzc3hXSWMwdUl4eEtrZG56RXRhUHMvb1k1bE1vL0ZtcUVRNEJVeldZZE5p?=
 =?utf-8?B?UjFyN0JWT0Z0VXJrZGloUW5LdkRlVkJEL2VSNWRTMHdkRFhNMVRZWGtBNWZU?=
 =?utf-8?B?dTJ2YWVzVlFjM3phZkRqSGdWSFRORkVOeER2dlEvTXo3NDh1NEkyV0xJRXNi?=
 =?utf-8?B?UHJxZ3k5ZVovVzV4Vk9waFcwakxOa1ZOdHJCZlFwMlFvQ0thWDcxZUN6bkVx?=
 =?utf-8?B?U1BXSW1KYzJ6QUNRQVcxU05YNytsYXJJMHNyN0FGSmlGb0RQVHllNi9ZMHh3?=
 =?utf-8?B?OWhjZzhjclJmcTU4WjBLaDdzRzdXU1JyNEtKSUZFd0gzM2ZIUWp5TEFsZXFC?=
 =?utf-8?B?YUlVNi9PWXR0NzZOSmRMUElzVHRQWnB2d0RaTStVOTBRL1hGZ1JTUnVJc1Vm?=
 =?utf-8?B?ZmM2TGt1VVpraGowV3pSWHVVM0V5b0psMFJ4T0NNOTBvNzJvZlVHcjdsYU5I?=
 =?utf-8?B?SVVjbjZaV1Evc0JHdTRoaFpyUE14M3R5cnhsaHRmc1kzN3JQYjRTb3R6dWhM?=
 =?utf-8?B?S0M1bmRqS1FuQ0hXQjMzMCtVdFZwQUcza2Q1OC91NFQxemhjOTBiYXo3OU5S?=
 =?utf-8?B?Vm9XejRCR1hHV1hTb3lPSWNKVFpLODBjVHhjSXpURGVWUFp2RTFxWFZiL0VZ?=
 =?utf-8?B?ZFhpRXp4aWJGZjJlMndhYTk0cHBhMXYwVFR0ZDVHekZGYWkvYzk3aUlYaXpO?=
 =?utf-8?B?U0dVOVNhVkZYMnB0ZHYwcnNwUDFEMGhTU2VCNVVmR2lBTlJKNXJHVThaQnZa?=
 =?utf-8?B?Qit5V3E0Yi9pcHVXRFpSb1JkRlBQbGtMc0thOTBJSHFPcjVYdnYxY3p4Um5Q?=
 =?utf-8?B?bTIvSEc4c2dXbW9nR0RIOVVKK1ZrWmMzUGh4ZExPd3lhc1ZTb2g0WE1sWlZS?=
 =?utf-8?B?OHl3bTF3U1ZTNnBrdXdBVXdqYkhIWU9ma1haM0lDbEFZQWFVVnpxVk1YNSs0?=
 =?utf-8?B?VEd2aVU1WVZoMENoL3E5T2hSZXZkbVdwL2ZzNnpIMU11RVV0QzZjbC9PRWZL?=
 =?utf-8?B?aTMzdUJ6dDVPN2RDMHVzMnk3TDJsNnpablNQWkI1c2NaSi9CWGtVZlBTdUVM?=
 =?utf-8?B?Mzh2RERGV1l1RHNCYkxSYnhxV0NxbE80SHFEZmkydEVDUWlvN3paRlFNQjl1?=
 =?utf-8?B?aC9tRlA2dGI1UmZnL3Nqd1ZMVloyZzE0SVZsdHc0R0l4UjFKYjRUTGdkdjBE?=
 =?utf-8?B?RTBIcFhUOFo2RVplVnphelBHdnJSRnRvZnRQck5PTE56UWJEY3psQmllVXBC?=
 =?utf-8?B?Ry9uQ25pMHFTYkhLUnFCRURxTEtLMzRiOE5ISEQzMkdnZ3VvOWg3UUorajRV?=
 =?utf-8?B?Wnh6Mll2ZGdyMWgxTFFMdkFicjZrMGhnSm16ZVAxcFJCak5HQktzY3ZMK2ds?=
 =?utf-8?B?VUpIamE4YUxVOXpLdkVjMTlCQ3hIa093ZUU1QTh4NHRIdXFEaVBMeE80bTVS?=
 =?utf-8?B?eGtFTk5PMXNrZXBxTlkra1VTdVdpUmMwM1BqQ29ucGMzZHlkdHZHWmhQTWdB?=
 =?utf-8?B?MWc3OVU5UEpGcnVKRDZaNjdZTVZXY0lWajNUVGQrQ2xscTJjOHhSZzlSekM0?=
 =?utf-8?B?ZVJ3elpyaVEveEJGWE1vR1ZsQ0l2MUxuL3I5UnlrWWxLWDZmZTFkcUhleUtD?=
 =?utf-8?B?N2wyeHYxdFBhQy82K1V6NUozREV4cllKWXNmNm04UjgxSlE5dU1aN1IwaGRk?=
 =?utf-8?B?UHhOMEFKM2hQUWdvb1RGQ2krVFhJbmFNYU1xTmNiVWpvdHcvc25sSjU0U1Yx?=
 =?utf-8?Q?5/O+ZxYJl9Q12p9Q1fhHKBAxuPy39o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q203MzcxblkzbkRCV0ZKNHRiVlVESDVqN2lzRmg2eC9JM0RUMlpsNG1TM0Vs?=
 =?utf-8?B?U1ZvdGR0NTh0VmJZZytpL1BVQ2dTZU1Gby9zZzlOL3Z2R2FmSU85SHR6Vy9J?=
 =?utf-8?B?WklQMFpIQUt3cHFoZUpYWjBTODBOcUo2enJONFZENzYycmlxMFNJL3JWNXcw?=
 =?utf-8?B?bFJPcnRUb3RpSitxbytNODltZFJGU0ZMODR4eTh5b1BrS1hISzM3Qi9ycVI0?=
 =?utf-8?B?TldlOW1aTXFid3RZekRaMGs0ckcvaXRabDNrdnJvbytzN29Xd1N2aHFleFVZ?=
 =?utf-8?B?YSt5V0N4TGFUZmVnbEY3QmkzaHlnelhtanQ1M0ZIcHZhUENFVXJxNEN6REl3?=
 =?utf-8?B?VmwvUDBVVXcyc0NJNEFYcDc0Q0hZNTFWa2dTR2FMM28xYjFJY1pISVFjMnVG?=
 =?utf-8?B?ZFBSbUlRdHlXZ09xZVdIeXpwaHBjTEdLcStNWnhCdS9ZMklyVUtiRlNNd0xS?=
 =?utf-8?B?bGlwMHNCRXA5WEd2OVVxMVJuaE9nc2dlWGZuTU9xYlhVY1hudE1LdnBOdGlm?=
 =?utf-8?B?RmxtRkxKbXlmenhwa0FlWldBcjcvZzg2cWwrWDBOeFMzYmZaY211UVMxM1dC?=
 =?utf-8?B?STJXdWpLNDRUcTlaTlhxdkFrek56YVlMMDZxYjNnNXZtRS9GYnRGcXRiVTdq?=
 =?utf-8?B?dnhCaEdrTThjNDY3b3A4bVJBQmlwY0NUTmJPUVJqN2wvVndYVWRkKzQ4aXNl?=
 =?utf-8?B?WEtsa1NTZDMvc2tlYXBxS0NpUzFMaWxHNEMvSXhVU2VSeFpzVTUzTUF6Vmhn?=
 =?utf-8?B?VHJMUWpPWWszRGNkamZWVjltYlNqdG5sZ0ZmRVRKcVJGbmxRREJmdGQ5Y25r?=
 =?utf-8?B?dWlteG5MRWMzc2thbmhTUzJEbFhvdjBYdmRMaFRMcDNHakI0dTRsMHRCVEMx?=
 =?utf-8?B?dDBiK0JtMzNIZ1BWMkF3WEppemZlWTdhcnRZRDN1VlZQalNiOEh3d0lzRmR1?=
 =?utf-8?B?VGFTQkJJVm1kdk56cHQwMmgxb2xTWWE4SXMrTlhsMWlIUEpzamZLeEh2OXJy?=
 =?utf-8?B?bVdnQWx5Z2F4NGd2TkFsVGRTbDZXZ2k0SGVqMzIzb2RkSDRrSjNyeVppN0dI?=
 =?utf-8?B?eUlKQ2E2T01RWWZmTFBYbVl2OEp1TGh1UnZsN09PeTB6bm5JalVCSTBGb2gz?=
 =?utf-8?B?RkJDRWpObVBCVTFPeG1HQW82aFp5d1pYVyt6d3d0NUM3bWs3ZEJPS0lIRi83?=
 =?utf-8?B?cW9tT1psN2YyQ0JTZ3dzRTc5L2hxbDNjZUJONVRkVk1tSkNKKzk0ZTkrM2gv?=
 =?utf-8?B?ZU1xOUVjeHNnWUYxemJQMzdVVWkrYitFazQ1a3JLT2wvZFQ3UWV1T1kzTGp2?=
 =?utf-8?B?ZFJ3NHZDVFVOSXoyV1hTOGdJMlR4cFd6YW1wbmVZWkdvREZySVhPYzIzTUt3?=
 =?utf-8?B?TCtBMGdUV2tweUEyalV1dHJLT1FvTkNLN3YwNlhXeWtEdXVXNzlNeDd2MW1X?=
 =?utf-8?B?dnBUUDFDVGR3M3RmY2dlWW9wYkJ4aDMrZVhURDBDVE9PaW4yVkJQbVVYQjl2?=
 =?utf-8?B?enpVMjBZT2tEdmR0RnNzWHJpdWZzT2ZaOVlqOWZndXFFNVRUNTJzY2VIdzFy?=
 =?utf-8?B?eUVRN1BKVVJNLytwbmRpUUtpR2ZNM245UXVlbS9NWUhHL293c1NMeEQ1dEtV?=
 =?utf-8?B?T1JqdHZMT2lPZG5tN3Q0eUJSbHAvN2FoQ25aZTdqbm5MYnZFNnRCZnIxZ21o?=
 =?utf-8?B?Y3FXdFU2bDFEUXQrKzFzTkpPWDNNOFpHYTNUVjgvYi9pVEMwaWVIbTZnK1Yy?=
 =?utf-8?B?YzJDdEZIbXFnZHBqazV6aWRKM1NockkzY2FkU2RqNkFrR0tIcFYrRHQyZ0Y3?=
 =?utf-8?B?SDFlSXk0YnkyZVNtRU94bmJRU2hSUndaSDNacUxiQjVZZS9QdUZjR1Jqb2t1?=
 =?utf-8?B?OCtzTG91NDUyNk5tbGM1VVVERTNYM0dVZFN5WXBZVW51cUM5OXI5RE1NTU9Y?=
 =?utf-8?B?c2hPSHZGZHRNNng0cjVxVTRnQ2tXclp4a2FGQXp6N0xQVE9WZE9DalBTc250?=
 =?utf-8?B?RmtjOUtNaFJCbGdGbFpaL09yN2NiOU1raGNQSWJPOU9oK2tMa1Y1VXJQMGpx?=
 =?utf-8?B?Q2xvck84OU1ZRzViY2hLbFpXTmNSZnVHb1FIMjJmcTBURnBPckNaN3NySWVP?=
 =?utf-8?Q?vzIw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e97347-016c-4af3-6123-08dd8c771715
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 08:22:07.2704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xSK3VyG6Kgz46BJJIKFswuvhxf4Jrvsa3Z1aBi7vYqoYgSxIwV4hEKtYFoOTEHKX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870
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

W1B1YmxpY10NCg0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDMwLCAyMDI1IDg6MDIgUE0NCj4gVG86
IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDQvNV0gZHJtL2FtZGdwdTogdmFsaWRhdGUgdGhlIGV2
aWN0aW9uIGZlbmNlIGJlZm9yZQ0KPiBhdHRhY2hpbmcvZGV0YWNoaW5nDQo+DQo+DQo+DQo+IE9u
IDQvMzAvMjUgMDQ6NDAsIFByaWtlIExpYW5nIHdyb3RlOg0KPiA+IEJlZm9yZSB0aGUgdXNlciBx
dWV1ZSBCT3MgcmVzdW1lIHdvcmtxdWV1ZSBpcyBzY2hlZHVsZWQ7IHRoZXJlJ3Mgbm8NCj4gPiB2
YWxpZCBldmljdGlvbiBmZW5jZSB0byBhdHRhY2ggdGhlIGdlbSBvYmouDQo+ID4gRm9yIHRoaXMg
Y2FzZSwgaXQgZG9lc24ndCBuZWVkIHRvIGF0dGFjaC9kZXRhY2ggdGhlIGV2aWN0aW9uIGZlbmNl
Lg0KPiA+IEFsc28sIGl0IG5lZWRzIHRvIHVubG9jayB0aGUgYm8gZmlyc3QgYmVmb3JlIHJldHVy
bmluZyBmcm9tIHRoZQ0KPiA+IGV2aWN0aW9uIGZlbmNlIGF0dGFjaGVkIGVycm9yLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4g
LS0tDQo+ID4gIC4uLi9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYyAgICB8
IDIyICsrKysrKysrKysrKysrKy0tLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dlbS5jICAgICAgIHwgIDMgKystDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYw0KPiA+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmMNCj4gPiBpbmRleCA3
YTVmMDJlZjQ1YTcuLjI0MmJmYjkxYzRmNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+ID4gQEAgLTE5Niwx
NiArMTk2LDIyIEBAIGludCBhbWRncHVfZXZpY3Rpb25fZmVuY2VfYXR0YWNoKHN0cnVjdA0KPiBh
bWRncHVfZXZpY3Rpb25fZmVuY2VfbWdyICpldmZfbWdyLA0KPiA+ICAgICBpZiAoIXJlc3YpDQo+
ID4gICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4NCj4gPiArICAgLyogVmFsaWRhdGUgdGhlIGV2
aWN0aW9uIGZlbmNlIGZpcnN0ICovDQo+ID4gKyAgIHNwaW5fbG9jaygmZXZmX21nci0+ZXZfZmVu
Y2VfbG9jayk7DQo+ID4gKyAgIGV2X2ZlbmNlID0gZXZmX21nci0+ZXZfZmVuY2U7DQo+ID4gKyAg
IGlmICghZXZfZmVuY2UgfHwNCj4gPiArICAgICAgICAgICAgICAgICAgIGRtYV9mZW5jZV9pc19z
aWduYWxlZCgmZXZmX21nci0+ZXZfZmVuY2UtPmJhc2UpKSB7DQo+ID4gKyAgICAgICAgICAgc3Bp
bl91bmxvY2soJmV2Zl9tZ3ItPmV2X2ZlbmNlX2xvY2spOw0KPiA+ICsgICAgICAgICAgIHJldHVy
biAwOw0KPiA+ICsgICB9DQo+ID4gKw0KPiA+ICAgICByZXQgPSBkbWFfcmVzdl9yZXNlcnZlX2Zl
bmNlcyhyZXN2LCAxKTsNCj4gPiAgICAgaWYgKHJldCkgew0KPiA+ICAgICAgICAgICAgIERSTV9E
RUJVR19EUklWRVIoIkZhaWxlZCB0byByZXN2IGZlbmNlIHNwYWNlXG4iKTsNCj4gPiAgICAgICAg
ICAgICByZXR1cm4gcmV0Ow0KPiA+ICAgICB9DQo+ID4NCj4gPiAtICAgc3Bpbl9sb2NrKCZldmZf
bWdyLT5ldl9mZW5jZV9sb2NrKTsNCj4gPiAtICAgZXZfZmVuY2UgPSBldmZfbWdyLT5ldl9mZW5j
ZTsNCj4gPiAtICAgaWYgKGV2X2ZlbmNlKQ0KPiA+IC0gICAgICAgICAgIGRtYV9yZXN2X2FkZF9m
ZW5jZShyZXN2LCAmZXZfZmVuY2UtPmJhc2UsDQo+IERNQV9SRVNWX1VTQUdFX0JPT0tLRUVQKTsN
Cj4gPiArICAgZG1hX3Jlc3ZfYWRkX2ZlbmNlKHJlc3YsICZldl9mZW5jZS0+YmFzZSwNCj4gRE1B
X1JFU1ZfVVNBR0VfQk9PS0tFRVApOw0KPg0KPiBPbmNlIG1vcmU6IEFic29sdXRlbHkgY2xlYXIg
TkFLIHRvIHRoYXQhIFlvdSBhcmUgYnJlYWtpbmcgdGhlIGxvZ2ljIGhlcmUuDQo+DQo+DQo+ID4g
ICAgIHNwaW5fdW5sb2NrKCZldmZfbWdyLT5ldl9mZW5jZV9sb2NrKTsNCj4gPg0KPiA+ICAgICBy
ZXR1cm4gMDsNCj4gPiBAQCAtMjE2LDYgKzIyMiwxNCBAQCB2b2lkIGFtZGdwdV9ldmljdGlvbl9m
ZW5jZV9kZXRhY2goc3RydWN0DQo+ID4gYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX21nciAqZXZmX21n
ciwgIHsNCj4gPiAgICAgc3RydWN0IGRtYV9mZW5jZSAqc3R1YiA9IGRtYV9mZW5jZV9nZXRfc3R1
YigpOw0KPiA+DQo+ID4gKyAgIHNwaW5fbG9jaygmZXZmX21nci0+ZXZfZmVuY2VfbG9jayk7DQo+
ID4gKyAgIGlmICghZXZmX21nci0+ZXZfZmVuY2UgfHwNCj4gPiArICAgICAgICAgICAgICAgICAg
IGRtYV9mZW5jZV9pc19zaWduYWxlZCgmZXZmX21nci0+ZXZfZmVuY2UtPmJhc2UpKSB7DQo+ID4g
KyAgICAgICAgICAgc3Bpbl91bmxvY2soJmV2Zl9tZ3ItPmV2X2ZlbmNlX2xvY2spOw0KPiA+ICsg
ICAgICAgICAgIHJldHVybjsNCj4gPiArICAgfQ0KPiA+ICsgICBzcGluX3VubG9jaygmZXZmX21n
ci0+ZXZfZmVuY2VfbG9jayk7DQo+ID4gKw0KPiBUaGF0IGlzIHVubmVjZXNzYXJ5IGFzIGZhciBh
cyBJIGNhbiBzZWUuDQo+DQo+ID4gICAgIGRtYV9yZXN2X3JlcGxhY2VfZmVuY2VzKGJvLT50Ym8u
YmFzZS5yZXN2LCBldmZfbWdyLT5ldl9mZW5jZV9jdHgsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0dWIsIERNQV9SRVNWX1VTQUdFX0JPT0tLRUVQKTsNCj4gPiAgICAgZG1hX2Zl
bmNlX3B1dChzdHViKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dlbS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
Z2VtLmMNCj4gPiBpbmRleCBmMDNmYzNjZjRkNTAuLjg2Nzc5ZGM4MTdiOSAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4gPiBAQCAtMjk0LDEwICsy
OTQsMTEgQEAgc3RhdGljIGludCBhbWRncHVfZ2VtX29iamVjdF9vcGVuKHN0cnVjdA0KPiBkcm1f
Z2VtX29iamVjdCAqb2JqLA0KPiA+ICAgICBlbHNlDQo+ID4gICAgICAgICAgICAgKytib192YS0+
cmVmX2NvdW50Ow0KPiA+DQo+ID4gLSAgIC8qIGF0dGFjaCBnZnggZXZpY3Rpb24gZmVuY2UgKi8N
Cj4gPiArICAgLyogYXR0YWNoIGdmeCB0aGUgdmFsaWRhdGVkIGV2aWN0aW9uIGZlbmNlICovDQo+
ID4gICAgIHIgPSBhbWRncHVfZXZpY3Rpb25fZmVuY2VfYXR0YWNoKCZmcHJpdi0+ZXZmX21nciwg
YWJvKTsNCj4gPiAgICAgaWYgKHIpIHsNCj4gPiAgICAgICAgICAgICBEUk1fREVCVUdfRFJJVkVS
KCJGYWlsZWQgdG8gYXR0YWNoIGV2aWN0aW9uIGZlbmNlIHRvIEJPXG4iKTsNCj4gPiArICAgICAg
ICAgICBhbWRncHVfYm9fdW5yZXNlcnZlKGFibyk7DQo+IEFkZGluZyB0aGlzIGhlcmUgbG9va3Mg
bGlrZSB0aGUgb25seSB2YWxpZCBmaXggaW4gdGhlIHBhdGNoLg0KQXMgdGhlIGV2aWN0aW9uIGZl
bmNlIHdpbGwgYmUgaW52YWxpZGF0ZWQgdW50aWwgdGhlIHVzZXIgcXVldWUgaXMgY3JlYXRlZCBm
cm9tIHRoZSB1c2VyIHNwYWNlLCBoZXJlIGl0IHJlcXVpcmVzIHZhbGlkYXRpbmcgdGhlIGV2aWN0
aW9uIGZlbmNlIGJlZm9yZSB0cnlpbmcgdG8gYXR0YWNoIGFuZCBkZXRhY2ggaXQgdG8gdGhlIHJl
c2VydmF0aW9uLg0KSSB3aWxsIHRyeSB0byBkcmFmdCBhIHBhdGNoIGZvciB2YWxpZGF0aW5nIHRo
ZSBldmljdGlvbiBmZW5jZSBhdCBhdHRhY2gvZGV0YWNoIHNlcGFyYXRlbHkgd2l0aCB0aGlzIGF0
dGFjaCBlcnJvciBoYW5kbGVyIGNoYW5nZS4NCg0KVGhhbmtzLA0KUHJpa2UNCg0KPg0KPiBSZWdh
cmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4gICAgICAgICAgICAgcmV0dXJuIHI7DQo+ID4gICAg
IH0NCj4gPg0K
