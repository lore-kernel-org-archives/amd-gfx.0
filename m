Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB110C3DA41
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jul 2024 01:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90B1810E0D7;
	Thu, 11 Jul 2024 01:31:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LoVwATSn";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 137B110E0D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jul 2024 01:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMLZlNPQxZjcXb7Q/YuZ7I412SuvP5KgVxTskdF8Ebid/Zh7emTEPLdsFs5cSJ0vvpQwtFkSV2o8dIz3LLHltQN6CoUaLyDKTGvQNgZ8TmnrQJsu86OiNJalSq6KGRCYkB53MkA4olwdMjswvOkcXxX/d/3ztVkHdi3p52kmjjjplSUUgBFIO3L8cordZ7l0hIVwxegFvOELAHLGxlJUNYWo+ByP3QXC2yJhKUj8js0J7CsoyiKdS3T0U/rZoEsUi8MwCsscKvBmcMB6N6rAXXYpWVLsPBIxi2epefdzkNLso/Y4v4CxthRnwqmFYP2EGoeXo13yI6M7CAY8IbW8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPtwYd78Pn7sX66J3cYC3Huwkplt2E3IwBYmpOt63/0=;
 b=VOV2iNFT0LkRFhYSwfTnkaYXAj1WnQyaIzm9pzrkRFpxd1BACiqL7MQa1m+XaIbICk3so6OUNQ1Y6ZKtB18902x5IQTnbax+UjwhvnC1XZERHRTySUw35zPyrWTrG/igwzBnk3GCBLIG2M1YeKhCdiCEnMOPu2gOmSV0OLkj4tp6g+Y4IQdzv/zofk7wCsj9kdVEw5RS+fUYJrXM+qd+lrfZXQjEb0Su8hqiyvNw3OpdnH+5xsdN9V328vx7nOd/xCD9iSgZwY1qn7ezxuX6DL/ComQ+MVUN1GT9bvYvp/v7wbo2vG5v8jVhzPUs34sK99renJMejwtSBOiuORtO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPtwYd78Pn7sX66J3cYC3Huwkplt2E3IwBYmpOt63/0=;
 b=LoVwATSn3WvVueU+IEmTb96B1BRLBA84hMLKa6nG8DPXsPKUtq8C/Hgk+s+uQYnQxJODbOvX28gwqU9z4pNRQGWZ+7czwVRDqkETsxSOX9EoOMT/4erVcpHfhIrFJAslQ+tgrZkIuPQONatEGisklOOEh42L3li94UXmbCbdHTU=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.20; Thu, 11 Jul 2024 01:31:53 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::cda7:a979:580:83a]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::cda7:a979:580:83a%7]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 01:31:53 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: set start timestamp of fence in the right
 place
Thread-Topic: [PATCH v2] drm/amdgpu: set start timestamp of fence in the right
 place
Thread-Index: AQHa0mCWFUQC/0nImUSF+KOPpXpAvrHvjZmAgAAJeCCAABrpAIAACQ1QgAAuWoCAANLNQA==
Date: Thu, 11 Jul 2024 01:31:53 +0000
Message-ID: <DS7PR12MB63330DE4D4D6664AC1BE31F7F4A52@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20240710003101.1645322-1-jiadong.zhu@amd.com>
 <0e79392e-1e82-4602-8ebb-2dc9d31e001c@gmail.com>
 <DS7PR12MB633361A48187FDC04193B93CF4A42@DS7PR12MB6333.namprd12.prod.outlook.com>
 <3f6f779d-33ff-4cbb-9eaf-035888c200e5@gmail.com>
 <DS7PR12MB6333A502ED4D41239EEB86C8F4A42@DS7PR12MB6333.namprd12.prod.outlook.com>
 <28dba774-ef8b-4f84-9ff3-6014b50e11b7@gmail.com>
In-Reply-To: <28dba774-ef8b-4f84-9ff3-6014b50e11b7@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=189e1362-0bec-43a5-a1b0-5693720493a0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-11T01:20:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|MW3PR12MB4348:EE_
x-ms-office365-filtering-correlation-id: 58863cba-b736-477d-92e8-08dca1493e6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dHBZNkVDdlJuMUZ5Mit0L080bkE2WVd4alpSdDI4TWtVVVZZV3p5WkJuTi9u?=
 =?utf-8?B?dVhKNkJrWmRvOE9tMlBjU2dqNVNTRkQ1VE9LcGhpYTZYT1duM2dDTE9iWVZE?=
 =?utf-8?B?OTVWNzlVeXZaS0VwdWRySlI0RWhyWmJKTXdiNmZCYTRCYnYwVkN0YStta240?=
 =?utf-8?B?bG5VWTFWTjZ5Yko0bTk1aE5jbHFXZ3pvNGJ5aWdMejFGMm9QQ1hMaEFjWDQv?=
 =?utf-8?B?d1F2S0gweTVJdVNGb3A2R2xFeUpMUEtYUDZpZ252YWlvYVlJMDRkMkp4c3dN?=
 =?utf-8?B?NDM3UlVmVGRVWnpEOERFdlpBbG1Ham16b1JGWDZqTzRRQnAvdGtqa2xFdWV0?=
 =?utf-8?B?WUxmbnZrTUYrVVFibDlRRkNkdUVoN0NyditTczYxdkFOWW8yeVAzdUtYV0Jl?=
 =?utf-8?B?eWRUSERPNVdNemFTaFlxVlRZL2ZjdFhqOTFFZ2pWNS9TUElRdWVUdHA5RnJU?=
 =?utf-8?B?SHpGbmRVVEFlamMwbTlYaFRLN0ZMZGh1bnA2c3JzeGZhZ2dUZnZzYlZYQ0hx?=
 =?utf-8?B?eEJzQmZnWTZSOGZiK21GQll3LzlhSnZvZDVZaThXdWN5NG9iVVNsSDRKSXQ2?=
 =?utf-8?B?bURXRUVpSGZrbUVwTVRQK0pQQXRTdldkbFQ3cDhCR0hVd2dweTM1OHl1TFpy?=
 =?utf-8?B?RGFOUlFNSUd0Q3MwY29oTmVGM1ppaWtaVzViak5ZYzUvRzAzU1owbWYwVTFh?=
 =?utf-8?B?NWRzVGJVNlN4Z1QvL3RPNk8zMUZOa0FhenpRbWJpUkRGZFYzVFQ4R0FGenN3?=
 =?utf-8?B?NkZsbXlDQTJaaGd5K1hLZHpyYnEydmNYQ1ZiRjhQL01kY0JKbW5paENBcGRh?=
 =?utf-8?B?VFZzVXlzc3htN1VyNEZJdnUxTUI5YytPZVZ4NjVnMmIzU3U1RWlrajAyTnp6?=
 =?utf-8?B?L0VLM3EwZTI1OW8rbEZDQ3c1cStOWThybUNITTJMOHVGRDBWaDBrN0Jsc1Ew?=
 =?utf-8?B?UUhHM2cvZGdhZUhBOHU5SVM1ZWNzZHVKeE0xZ2FQU2dFQjVOMDVBekY0b0Zl?=
 =?utf-8?B?NW1jc1MyN0UyQ0lqYVdkUWk1bG1GYmM2T0NOWEFpbWFmaUtzNE1malJzV2o2?=
 =?utf-8?B?Qk9JQTRWSzVCWUQvRWtZdXBIYzlOamV1eFQ5WjRSeUZwZnJDVTN3Nk5XblVQ?=
 =?utf-8?B?NFMwZnJVTVdxOUlEenlIOGRmQU1lOTMzTWJwVFl0NTJ4SFFhcXFDWUNxRE8w?=
 =?utf-8?B?RU9RbUlWZTd1bVh3SUEzMnZqRVZ1Y3U5UUhQcFo4NVZhcjVORDZJWUJNeG1B?=
 =?utf-8?B?cjRMOWh0SERJeXI0c0c3MldhSm5mOEs4aVpzT2J2a2FNbFBkT1lwb1ZFVFd1?=
 =?utf-8?B?SnRYMDB5aURPelVQTDF1bDh2d0Z2cnZLbXpJRnJMa0VzaG03emVaL08yQi9H?=
 =?utf-8?B?WTY3Mld3RjJKNkdYODBpZERlMm5wY3NrSHo5enFxOThQdEN0K21OZHVZSUN4?=
 =?utf-8?B?MHFKRklLNVdUL2RnNGhRcFh1a25kRUIvT1YxMUMxY056cWJLa2tGRU1aWVB4?=
 =?utf-8?B?NStZKzd3V3d0OXFIT3dnYXZYelNiMXlFUmxsNy9xbnRzUll5QUN0QngrQ1Q4?=
 =?utf-8?B?V0VRNG05M3dnbWNtME9lT2ZXdFN4MGIwMGx3M1RWREhINlMwMElWaCt5ZDZt?=
 =?utf-8?B?N2VCY0xRclU5bmQwamFDNDdxVnRiMTQ2aFd4WGh1ZVFhK1JwTEMzSHlJOFIx?=
 =?utf-8?B?ajBRWmsrRzYvZEJCZnlLK0lpQUswdG11K0x5VkVNZ1dia0k3emJCQXI0a2ps?=
 =?utf-8?B?VGx0cy9tdlZvZzNlanhMWllnVTBlREkzc2p6czRNYW9xeVZrUi9ISVM2MjFt?=
 =?utf-8?B?ZWhGUmk0VWlEdDFCdWpNTHZnVTZXeC9BSHFvNXh0eklYK2pVWW1iTlhGcnVu?=
 =?utf-8?B?d05VT2twL0NyQTdSMTR1V1VOUHEyd3MrV2hEMjR0Z016RGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWNRY0YwVGRuYkkzWEo5MFJ4SGhIYktaaFBmblZHZFhWb2VBSnViT0E1ZnUv?=
 =?utf-8?B?blJFS01PUGlKeWlPQUd2TDdVTUxNZWdxUTFUaVhyaDN0U3Aya2F0VkJuZlZ5?=
 =?utf-8?B?d2JITkxSVFlwMHJRVXQzSm0yWkwrRGV5dVZGZFZxWW8rSzM4d09mMjY4bGk0?=
 =?utf-8?B?dktOdGNWaXZpd0JIMlJ0Ujk2SDlsUE1KcDZmRXEvQUUzUDYwYTg4VFhud2pS?=
 =?utf-8?B?OGFuZ3JWVEpUVTNwcmFRdUFqWFM1REExcDFNUnhLTDBIOEcyN0lmTGFkRWlC?=
 =?utf-8?B?Z2U3S0ozLzVCRTgzSmVMK1RTS1RDY1U5WXU1ZTBTQnF5aHdMOVF2RXM2d3dv?=
 =?utf-8?B?Y0g3OWxBc0tqMWFZbUp5VlZTY0ZVMk54cFNaT0VRei9zL3kzMVRoQWY4VW43?=
 =?utf-8?B?T2Rab2RrcTR0czJKTURSaFVDU2JCQTkyRW5aTnBWQ1ZhWHdXRGcvYU45aFJ5?=
 =?utf-8?B?ajhaOGlGOHdrMElMekFqTFY4VFlMU2UvNUlBbkhJcXVPcWJpaTZ5OVd0djZw?=
 =?utf-8?B?YklYeTVJZHllampra2xvd1ZiQkdaV1gwc3RKSVlhOVFrc05kenJpMHkxZFg5?=
 =?utf-8?B?QWFteVpjcEIzV0tiSVpQR1p1YUhaYWkrMXdYN0c4MHY2ZVVhVWI3YzhsbndV?=
 =?utf-8?B?SW83TmtSRzJNdnpzYWZNWFNrY2JMdmM3WEIrVzdKRGxDMmJHdU5GZ2lTZDE5?=
 =?utf-8?B?ZnQ2bzdBUnlrNUxqbFhBeXcxTDVIMnR3TTJUdExReXJGcUh5M0o4dGdwd052?=
 =?utf-8?B?aHdmU3V1UHJHb2p2eGZoTytDYnpkMzNRT1FsY0dXNmtqWUxHazhBcEFUQlJW?=
 =?utf-8?B?VnV4QWRsamVSVlZBbVNVS05CT0JlZDF2NzhsSjBsaEczc1FIa2VQNWRhSzhI?=
 =?utf-8?B?TVRjZ2Evak9RSHo5dFJkV1VBTVgxKzYyVEZJSTZ6dW8vZDk1RmhvOG1Hajkz?=
 =?utf-8?B?TWlXN1VIUGhQWnUyRExMNzRvb2pnYlpURkFlMWlQOW96WFZjRG9UREhQOGg3?=
 =?utf-8?B?SkZ4NmNFZklLTi9RQ1Z4NzNlK2E5bTBwd3dvSm5lSld5SHlYeTNnVUsrN21I?=
 =?utf-8?B?d2x2d3dVVnh3c2ZQSjNwU1k3NC90NWJ3cXhheUphei9qNnRaMkVZZGtjdUU3?=
 =?utf-8?B?U1dzM01QTmtHZFo1RTkwWURzRnl2bVhQQ3Jqa3cvdzBzTE5yRGZ2QTk2WXls?=
 =?utf-8?B?ek1CQWoza0doRmJ3amdVY2Z2R2d6cnVTV2FQMTVGRk5vdHhiZWJxbTU4Njcy?=
 =?utf-8?B?QzdSZnc1TE5PalczZHN6VFc0SkFiTy9jWVdwSTdlTDJWVFM1Sk5ORmE1Q00w?=
 =?utf-8?B?QjRZWWJrMVF0Z05iaTJZdUF1NSsvYWx0R2grRW1EalgyZVZ1UXFLSnRibTAv?=
 =?utf-8?B?dGtsUEljSWZXQ2gyQ2xPa1FXQUlMbXpCUU1xOVVRZUErL1ZOUHVHenB5RmlS?=
 =?utf-8?B?NEgwMVJhTkFlNHRHS0RYemZaL0c4aXF6VjFFR1QvUlpwWHFCZUVUdU1rZzU0?=
 =?utf-8?B?emQrS3NONnQxOG1DMVAvK1dnUWNIS3R4UFdVbEdVZjMvZDdFSDNpL0VWbUxD?=
 =?utf-8?B?MEczWDQyYThMcUFqL2N2WmJYSmlKcTU2d1F2cWZTb3o3Y3IxaTNranhxazVp?=
 =?utf-8?B?RksrbDlyY28ySkVGenRoQzBPcGRidldCYjNycXE4cTBnNTFrK3M1eFVlMEdU?=
 =?utf-8?B?VDdEMmFjclpsbG84NExsSWY0d202OTNMdDdSMmM2ZGU1UzRwamsvckNRZXpx?=
 =?utf-8?B?MVlEZFpFMnNZSFRrNUp6SVA5TWJGZE1WZ2dTbjZUbjhjbkZkbmxZZDl2cGVK?=
 =?utf-8?B?TXFHZDRsY1UzSDZocUJkQU9YZk0vV3RIeUxyalk1eHNWejBpbGRZQlBpVFVv?=
 =?utf-8?B?OGdPYXFDdURJdmhxYzdOVmdtMDVUTzI1b3k0TXFqWmZUSFZHam01dWdVTDZy?=
 =?utf-8?B?RGRrN3hqcENLdis5bjNOc1ZaV240VGtxZ3I1UkpyQ0lEQVU3R2JiYlQwbXQw?=
 =?utf-8?B?MHdvem96WitDTk9udmNtcThOT0JOcVRNOVI1djhZaXlxTFNadEh6REExbzlS?=
 =?utf-8?B?TDV1NTF6Y3JFcDlzdzNZcEFzd1dRbnZaRG9RRm45REF4Zk11aEhiQ3VoK2Va?=
 =?utf-8?Q?wG3s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58863cba-b736-477d-92e8-08dca1493e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 01:31:53.1276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +CreQHHAmM6kFmOJgICxp9npsom9QR7YVqYvbWw1kIzaT1JY2kIxfXezWdigVfIjunHdQQNby2njT6EH3DGqtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3RpYW4gS8O2bmln
IDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBK
dWx5IDEwLCAyMDI0IDg6NDYgUE0NCj4gVG86IFpodSwgSmlhZG9uZyA8SmlhZG9uZy5aaHVAYW1k
LmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJd
IGRybS9hbWRncHU6IHNldCBzdGFydCB0aW1lc3RhbXAgb2YgZmVuY2UgaW4gdGhlDQo+IHJpZ2h0
IHBsYWNlDQo+DQo+IEFtIDEwLjA3LjI0IHVtIDEyOjE1IHNjaHJpZWIgWmh1LCBKaWFkb25nOg0K
PiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9u
bHldDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQo+ID4+IFNl
bnQ6IFdlZG5lc2RheSwgSnVseSAxMCwgMjAyNCA1OjI3IFBNDQo+ID4+IFRvOiBaaHUsIEppYWRv
bmcgPEppYWRvbmcuWmh1QGFtZC5jb20+Ow0KPiA+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+ID4+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
Pg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBkcm0vYW1kZ3B1OiBzZXQgc3RhcnQgdGlt
ZXN0YW1wIG9mIGZlbmNlIGluDQo+ID4+IHRoZSByaWdodCBwbGFjZQ0KPiA+Pg0KPiA+PiBBbSAx
MC4wNy4yNCB1bSAwOTo1NCBzY2hyaWViIFpodSwgSmlhZG9uZzoNCj4gPj4+IFtBTUQgT2ZmaWNp
YWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+ID4+Pg0KPiA+
Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+Pj4gRnJvbTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQo+ID4+Pj4gU2VudDogV2Vk
bmVzZGF5LCBKdWx5IDEwLCAyMDI0IDM6MTcgUE0NCj4gPj4+PiBUbzogWmh1LCBKaWFkb25nIDxK
aWFkb25nLlpodUBhbWQuY29tPjsgYW1kLQ0KPiA+PiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gZHJtL2FtZGdwdTogc2V0IHN0YXJ0IHRp
bWVzdGFtcCBvZiBmZW5jZSBpbg0KPiA+Pj4+IHRoZSByaWdodCBwbGFjZQ0KPiA+Pj4+DQo+ID4+
Pj4gQW0gMTAuMDcuMjQgdW0gMDI6MzEgc2NocmllYiBqaWFkb25nLnpodUBhbWQuY29tOg0KPiA+
Pj4+PiBGcm9tOiBKaWFkb25nIFpodSA8SmlhZG9uZy5aaHVAYW1kLmNvbT4NCj4gPj4+Pj4NCj4g
Pj4+Pj4gVGhlIGpvYidzIGVtYmVkZGVkIGZlbmNlIGlzIGRtYV9mZW5jZSB3aGljaCBzaGFsbCBu
b3QgYmUNCj4gY29udmVyc2VkDQo+ID4+Pj4+IHRvIGFtZGdwdV9mZW5jZS4NCj4gPj4+PiBHb29k
IGNhdGNoLg0KPiA+Pj4+DQo+ID4+Pj4+IFRoZSBzdGFydCB0aW1lc3RhbXAgc2hhbGwgYmUgc2F2
ZWQgb24gam9iIGZvciBod19mZW5jZS4NCj4gPj4+PiBCdXQgTkFLIHRvIHRoYXQgYXBwcm9hY2gu
IFdoeSBkbyB3ZSBuZWVkIHRoZSBzdGFydCB0aW1lIGhlcmUgaW4gdGhlDQo+ID4+Pj4gZmlyc3Qg
cGxhY2U/DQo+ID4+Pj4NCj4gPj4+PiBSZWdhcmRzLA0KPiA+Pj4+IENocmlzdGlhbi4NCj4gPj4+
Pg0KPiA+Pj4gVGhlIHN0YXJ0IHRpbWVzdGFtcCBpcyB1c2VkIGZvciByaW5nIG11eCB0byBjaGVj
ayBpZiB0aGUgZmVuY2VzIGFyZQ0KPiA+PiB1bnNpZ25hbGVkIGZvciBhIHBlcmlvZCBvZiB0aW1l
IHVuZGVyIG1jYnAgc2NlbmFyaW9zIChieSBjYWxsaW5nDQo+ID4+IGFtZGdwdV9mZW5jZV9sYXN0
X3Vuc2lnbmFsZWRfdGltZV91cykuDQo+ID4+DQo+ID4+IEkgY2FuJ3QgZmluZCBhIHJlYXNvbiBm
b3IgZG9pbmcgdGhhdCBpbiB0aGUgZmlyc3QgcGxhY2UuIFdoYXQgaXMgdGhlDQo+ID4+IGJhY2tn
cm91bmQgb2YgdGhpcz8NCj4gPj4NCj4gPj4gUmVnYXJkcywNCj4gPj4gQ2hyaXN0aWFuLg0KPiA+
Pg0KPiA+IEl0IGlzIGFib3V0IG9zIHRyaWdnZXJlZCBtY2JwIG9uIGdmeDkuIFdoZW4gd2UgYXJl
IHVzaW5nIHNvZnR3YXJlIHJpbmcgYW5kDQo+IHJpbmcgbXV4IG9uIGdmeDksICB0aGUgcmluZyBt
dXggY2hlY2tzIHRoZSBmZW5jZSB1bnNpZ25hbGVkIHRpbWUgb2YgdGhlIGxvdw0KPiBwcmlvcml0
eSBjb250ZXh0IHdoaWxlIGhpZ2ggcHJpb3JpdHkgam9iIGNvbWVzLiBJZiB0aGUgdGltZSBkdXJh
dGlvbiBleGNlZWRzIGENCj4gY2VydGFpbiB0aW1lLCBtdXggd2lsbCB0cmlnZ2VyIG1jYnAuDQo+
ID4gd2UgY291bGQgYWRkIGFkZXYtPmdmeC5tY2JwIGNoZWNrIHdoZW4gc2V0IHN0YXJ0X3RpbWVz
dGFtcCBmb3IgdGhvc2UNCj4gZmVuY2VzLg0KPg0KPiBTbyB5b3UgYmFzaWNhbGx5IHdhbnQgdG8g
Z3VhcmFudGVlIHNvbWUgZm9yd2FyZCBwcm9ncmVzcz8NCnRoaXMgcGF0Y2ggaXMgdG8gZml4IHRo
ZSBtZW1vcnkgb3ZlcmxhcCBvbiBqb2ItPmh3X2ZlbmNlLiAgRm9yIHRoZSBvdGhlciBwYXJ0IHdl
IGxlYXZlIGl0IGFzIGl0IHdhcy4NCg0KPiBXaGlsZSB0aGlzIGlzIG5pY2UgdG8gaGF2ZSBJIGRv
bid0IHRoaW5rIHdlIG5lZWQgdGhhdCBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+DQo+IEkgbWVhbiB3
aGVuIEkgaGF2ZSB0d28gaGFyZHdhcmUgcXVldWVzIHRoZSBoaWdoIHByaW9yaXR5IG9uZSB3b3Vs
ZCBzdGFydmUNCj4gdGhlIGxvdyBwcmlvcml0eSBvbmUgYXMgd2VsbC4NCkhXUyBoYXMgdHdvIGxl
dmVscyB0byBoYW5kbGUgcXVldWUgcHJpb3JpdHk6ICBmb3IgcHJpb3JpdHkgbW9kZSwgaGlnaCBw
cmlvcml0eSBxdWV1ZSB3aWxsIHByZWVtcHQgbG93IHByaW9yaXR5IHF1ZXVlIGFzIGxvbmcgYXMg
aXQgaGFzIHNvbWUgd29yay4gRm9yIHF1YW50dW0gbW9kZSwgYWxsIHRoZSBxdWV1ZXMgYXJlIGlu
IHRoZSBzYW1lIHByaW9yaXR5LCB0aGUgcXVldWUgd291bGQgYmUgcHJlZW1wdGVkIHdoZW4gaXQg
dXNlcyB1cCBpdHMgdGltZSBzbGljZS4NClRoZSBoYXJkd2FyZSB0ZWFtIHN1Z2dlc3RlZCBPUyB0
byB1c2UgcXVhbnR1bSBtb2RlIGFzIGl0IHdpbGwgbm90IHN0YXJ2ZSBsb3cgcHJpb3JpdHkgcXVl
dWUuIE91ciBpbXBsZW1lbnRhdGlvbiBwYXJ0aWFsbHkgcmVmZXJyZWQgdG8gdGhhdCBkZXNpZ24u
DQoNClRoYW5rcywNCkppYWRvbmcNCg0KPiBSZWdhcmRzLA0KPiBDaHJpc3RpYW4uDQo+DQo+ID4N
Cj4gPiBUaGFua3MsDQo+ID4gSmlhZG9uZw0KPiA+DQo+ID4+PiBUaGFua3MsDQo+ID4+PiBKaWFk
b25nDQo+ID4+Pj4+IHYyOiBvcHRpbWl6ZSBnZXRfZmVuY2Vfc3RhcnRfdGltZS4NCj4gPj4+Pj4g
U2lnbmVkLW9mZi1ieTogSmlhZG9uZyBaaHUgPEppYWRvbmcuWmh1QGFtZC5jb20+DQo+ID4+Pj4+
IC0tLQ0KPiA+Pj4+PiAgICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNl
LmMgfCAzMQ0KPiA+Pj4+ICsrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4+Pj4+ICAgICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmggICB8ICAzICsrKw0KPiA+Pj4+PiAg
ICAgMiBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+
Pj4+Pg0KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2ZlbmNlLmMNCj4gPj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZmVuY2UuYw0KPiA+Pj4+PiBpbmRleCAyZjI0YTZhYTEzYmYuLjcyYmIwMDdlNDhjOCAxMDA2NDQN
Cj4gPj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMN
Cj4gPj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMN
Cj4gPj4+Pj4gQEAgLTg4LDYgKzg4LDMxIEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IGFtZGdwdV9m
ZW5jZQ0KPiA+Pj4+ICp0b19hbWRncHVfZmVuY2Uoc3RydWN0IGRtYV9mZW5jZSAqZikNCj4gPj4+
Pj4gICAgICAgcmV0dXJuIE5VTEw7DQo+ID4+Pj4+ICAgICB9DQo+ID4+Pj4+DQo+ID4+Pj4+ICtz
dGF0aWMgaW5saW5lIHZvaWQgc2V0X2ZlbmNlX3N0YXJ0X3RpbWUoc3RydWN0IGRtYV9mZW5jZSAq
ZiwNCj4gPj4+Pj4gK2t0aW1lX3QNCj4gPj4+Pj4gK3N0YXJ0X3RpbWVzdGFtcCkgew0KPiA+Pj4+
PiArICAgaWYgKGYtPm9wcyA9PSAmYW1kZ3B1X2ZlbmNlX29wcykgew0KPiA+Pj4+PiArICAgICAg
ICAgICBzdHJ1Y3QgYW1kZ3B1X2ZlbmNlICpfX2YgPSBjb250YWluZXJfb2YoZiwgc3RydWN0DQo+
ID4+Pj4gYW1kZ3B1X2ZlbmNlLA0KPiA+Pj4+PiArYmFzZSk7DQo+ID4+Pj4+ICsNCj4gPj4+Pj4g
KyAgICAgICAgICAgX19mLT5zdGFydF90aW1lc3RhbXAgPSBzdGFydF90aW1lc3RhbXA7DQo+ID4+
Pj4+ICsgICB9IGVsc2UgaWYgKGYtPm9wcyA9PSAmYW1kZ3B1X2pvYl9mZW5jZV9vcHMpIHsNCj4g
Pj4+Pj4gKyAgICAgICAgICAgc3RydWN0IGFtZGdwdV9qb2IgKmpvYiA9IGNvbnRhaW5lcl9vZihm
LCBzdHJ1Y3QNCj4gPj4+Pj4gK2FtZGdwdV9qb2IsIGh3X2ZlbmNlKTsNCj4gPj4+Pj4gKw0KPiA+
Pj4+PiArICAgICAgICAgICBqb2ItPnN0YXJ0X3RpbWVzdGFtcCA9IHN0YXJ0X3RpbWVzdGFtcDsN
Cj4gPj4+Pj4gKyAgIH0NCj4gPj4+Pj4gK30NCj4gPj4+Pj4gKw0KPiA+Pj4+PiArc3RhdGljIGlu
bGluZSBrdGltZV90IGdldF9mZW5jZV9zdGFydF90aW1lKHN0cnVjdCBkbWFfZmVuY2UgKmYpIHsN
Cj4gPj4+Pj4gKyAgIGlmICh1bmxpa2VseShmLT5vcHMgPT0gJmFtZGdwdV9mZW5jZV9vcHMpKSB7
DQo+ID4+Pj4+ICsgICAgICAgICAgIHN0cnVjdCBhbWRncHVfZmVuY2UgKl9fZiA9IGNvbnRhaW5l
cl9vZihmLCBzdHJ1Y3QNCj4gPj4+PiBhbWRncHVfZmVuY2UsDQo+ID4+Pj4+ICtiYXNlKTsNCj4g
Pj4+Pj4gKw0KPiA+Pj4+PiArICAgICAgICAgICByZXR1cm4gX19mLT5zdGFydF90aW1lc3RhbXA7
DQo+ID4+Pj4+ICsgICB9DQo+ID4+Pj4+ICsgICBzdHJ1Y3QgYW1kZ3B1X2pvYiAqam9iID0gY29u
dGFpbmVyX29mKGYsIHN0cnVjdCBhbWRncHVfam9iLA0KPiA+Pj4+PiAraHdfZmVuY2UpOw0KPiA+
Pj4+PiArDQo+ID4+Pj4+ICsgICByZXR1cm4gam9iLT5zdGFydF90aW1lc3RhbXA7DQo+ID4+Pj4+
ICt9DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gICAgIC8qKg0KPiA+Pj4+PiAgICAgICogYW1kZ3B1X2Zl
bmNlX3dyaXRlIC0gd3JpdGUgYSBmZW5jZSB2YWx1ZQ0KPiA+Pj4+PiAgICAgICoNCj4gPj4+Pj4g
QEAgLTE5Nyw3ICsyMjIsNyBAQCBpbnQgYW1kZ3B1X2ZlbmNlX2VtaXQoc3RydWN0IGFtZGdwdV9y
aW5nDQo+ID4+ICpyaW5nLA0KPiA+Pj4+IHN0cnVjdCBkbWFfZmVuY2UgKipmLCBzdHJ1Y3QgYW1k
DQo+ID4+Pj4+ICAgICAgICAgICAgICAgfQ0KPiA+Pj4+PiAgICAgICB9DQo+ID4+Pj4+DQo+ID4+
Pj4+IC0gICB0b19hbWRncHVfZmVuY2UoZmVuY2UpLT5zdGFydF90aW1lc3RhbXAgPSBrdGltZV9n
ZXQoKTsNCj4gPj4+Pj4gKyAgIHNldF9mZW5jZV9zdGFydF90aW1lKGZlbmNlLCBrdGltZV9nZXQo
KSk7DQo+ID4+Pj4+DQo+ID4+Pj4+ICAgICAgIC8qIFRoaXMgZnVuY3Rpb24gY2FuJ3QgYmUgY2Fs
bGVkIGNvbmN1cnJlbnRseSBhbnl3YXksIG90aGVyd2lzZQ0KPiA+Pj4+PiAgICAgICAgKiBlbWl0
dGluZyB0aGUgZmVuY2Ugd291bGQgbWVzcyB1cCB0aGUgaGFyZHdhcmUgcmluZyBidWZmZXIuDQo+
ID4+Pj4+IEBAIC00MjgsNyArNDUzLDcgQEAgdTY0DQo+ID4+Pj4gYW1kZ3B1X2ZlbmNlX2xhc3Rf
dW5zaWduYWxlZF90aW1lX3VzKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykNCj4gPj4+Pj4gICAg
ICAgICAgICAgICByZXR1cm4gMDsNCj4gPj4+Pj4NCj4gPj4+Pj4gICAgICAgcmV0dXJuIGt0aW1l
X3VzX2RlbHRhKGt0aW1lX2dldCgpLA0KPiA+Pj4+PiAtICAgICAgICAgICB0b19hbWRncHVfZmVu
Y2UoZmVuY2UpLT5zdGFydF90aW1lc3RhbXApOw0KPiA+Pj4+PiArICAgICAgICAgICBnZXRfZmVu
Y2Vfc3RhcnRfdGltZShmZW5jZSkpOw0KPiA+Pj4+PiAgICAgfQ0KPiA+Pj4+Pg0KPiA+Pj4+PiAg
ICAgLyoqDQo+ID4+Pj4+IEBAIC00NTEsNyArNDc2LDcgQEAgdm9pZA0KPiA+Pj4+IGFtZGdwdV9m
ZW5jZV91cGRhdGVfc3RhcnRfdGltZXN0YW1wKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywNCj4g
Pj4+PiB1aW50MzJfdCBzZXEsDQo+ID4+Pj4+ICAgICAgIGlmICghZmVuY2UpDQo+ID4+Pj4+ICAg
ICAgICAgICAgICAgcmV0dXJuOw0KPiA+Pj4+Pg0KPiA+Pj4+PiAtICAgdG9fYW1kZ3B1X2ZlbmNl
KGZlbmNlKS0+c3RhcnRfdGltZXN0YW1wID0gdGltZXN0YW1wOw0KPiA+Pj4+PiArICAgc2V0X2Zl
bmNlX3N0YXJ0X3RpbWUoZmVuY2UsIHRpbWVzdGFtcCk7DQo+ID4+Pj4+ICAgICB9DQo+ID4+Pj4+
DQo+ID4+Pj4+ICAgICAvKioNCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9qb2IuaA0KPiA+Pj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9qb2IuaA0KPiA+Pj4+PiBpbmRleCBhOTYzYTI1ZGRkNjIuLjNhNzNmZTExYTFj
ZSAxMDA2NDQNCj4gPj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2pvYi5oDQo+ID4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9q
b2IuaA0KPiA+Pj4+PiBAQCAtNzMsNiArNzMsOSBAQCBzdHJ1Y3QgYW1kZ3B1X2pvYiB7DQo+ID4+
Pj4+ICAgICAgIHVpbnQ2NF90ICAgICAgICAgICAgICAgIGdkc192YTsNCj4gPj4+Pj4gICAgICAg
Ym9vbCAgICAgICAgICAgICAgICAgICAgaW5pdF9zaGFkb3c7DQo+ID4+Pj4+DQo+ID4+Pj4+ICsg
ICAvKiBzdGFydCB0aW1lc3RhbXAgZm9yIGh3X2ZlbmNlKi8NCj4gPj4+Pj4gKyAgIGt0aW1lX3Qg
ICAgICAgICAgICAgICAgIHN0YXJ0X3RpbWVzdGFtcDsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiAgICAg
ICAvKiBqb2JfcnVuX2NvdW50ZXIgPj0gMSBtZWFucyBhIHJlc3VibWl0IGpvYiAqLw0KPiA+Pj4+
PiAgICAgICB1aW50MzJfdCAgICAgICAgICAgICAgICBqb2JfcnVuX2NvdW50ZXI7DQo+ID4+Pj4+
DQoNCg==
