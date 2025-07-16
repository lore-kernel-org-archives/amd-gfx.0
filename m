Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C23C83F1B
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 07:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FD2210E140;
	Wed, 16 Jul 2025 07:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J0bSw3vi";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 361B610E140
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 07:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEiU4S9aomtxucyfo41HvuXIug2LB/t6cd+ausxX5amWVRPTdsuUHgk0wF63OEkGL5OGzIl9+MkrvY9wUjiiTDRj0ej3ZI8EMIJKAc+iGtK+NUsGw22yyqMoxfL29CEQJflHWuuBfeehtle3wGm4uNrFlHPDteuL7JYYH5jqgYR4cxBTG70bALpI58oOY7WDmNwdvbBfUwTcSkNyNFtaP6LfUDO/Vo3d/EWH0jAQM7tT0xVRX1o5Wbalkw6UpfCZflfqSms2lcU+5Y0Qzbbni1/mmBs8uMW2hr1tmebUHg+smUqn4jAuXY+75nrQDlvTevVoqe3xIlwgvLFjL6mVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=td68NaLBIbL3KZu3z8zxQCIfdTuwDIIecoeif01pQMQ=;
 b=J7h61oIV13D/gladBH7vNvbHZXLUEnaKZ+b/ytVGYq9KcA/I5XeCGKBbyBwqJcROiM9k1jcjoLzywQMkViRHH4a9ToHdKYuEBLooYK6GGxzdtD9g0qsK9GOIw2gIqv23lWKv/BUTA11YsM3JOlYWV4+Cz3cPaxdwVDL1dTj1yNg20Rm/YJudkAro5wcw4cTttxSYhQu97dRKgmz6bl71KVCtjQNDRDGCk7PBOqWtRVHL5RgHnYT8eT0fOY5NiVQknPX6NWxvRce1vlWo5hl8gIejAtQKY/3JS/uGeuBtYKxfITFaoHbx/DLd5RhIzVPM8Kf1pqFA79gfXmT7HHh8vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=td68NaLBIbL3KZu3z8zxQCIfdTuwDIIecoeif01pQMQ=;
 b=J0bSw3viOqctVZkQL4hhLegANzWTbczEQ5v27aj+NE4k0kjyVaTV+iDdD4fIon2/4edp+1TOl2LWuWsAZwXkU1Z8k576zcJ9RJzizP7w22RDnFRFNxaf/26MPldZnlFD2S6pkQKtTEjrB5bhyAMSG9xCAI6KbLBdeWWHD/dm9UU=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:03:37 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8880.034; Wed, 16 Jul 2025
 07:03:36 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v6 03/11] drm/amdgpu: rework the userq doorbell object
 destroy
Thread-Topic: [PATCH v6 03/11] drm/amdgpu: rework the userq doorbell object
 destroy
Thread-Index: AQHb8ke+LNPd1RCi8UmlHVo7bOaKHrQs0kmAgAS300CAAVwRAIABcu/A
Date: Wed, 16 Jul 2025 07:03:36 +0000
Message-ID: <DS7PR12MB6005F4AEFA0CAE8FD8AE1B12FB56A@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250711093930.1411470-1-Prike.Liang@amd.com>
 <20250711093930.1411470-3-Prike.Liang@amd.com>
 <064e192d-feb5-4772-b947-d1557f83a7a2@amd.com>
 <DS7PR12MB600518AE6EC29FDD741B825DFB57A@DS7PR12MB6005.namprd12.prod.outlook.com>
 <c6fb3051-a182-417b-9e20-0b1fae6dc81c@amd.com>
In-Reply-To: <c6fb3051-a182-417b-9e20-0b1fae6dc81c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-16T06:57:09.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|IA1PR12MB8408:EE_
x-ms-office365-filtering-correlation-id: 72b07500-745e-444b-a7cd-08ddc436e2d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Z0NHdWh2aHJReVBTV1dWL1cwWkFvWjBVbElZbFR2c2FoWlh4RGRDS2pBMVNT?=
 =?utf-8?B?Qnc1VFc2RytJYStBYVQvb2g3cnNNQU9aQVphNU4waG9GUS9DZkN2bHJXcGxN?=
 =?utf-8?B?ZXFXMnkvTkZMbDExL25jMXd0S3cvRGhJZ3RsUTdJM0FrVW5KMDR5RTBDdnRK?=
 =?utf-8?B?M2E2OU1SQnA2RTZEYlorVHZmODFDOVBaL0lveVA2ZmYrSXZhMDd0d2V3YmI0?=
 =?utf-8?B?MmE3djl3S0hMNnlLMlh2b29mK1E3TnNNRTRTbi9DTmZ3bGxPTnA0bXVRaUJr?=
 =?utf-8?B?dUJQWWEwUEJPR09YdklGdmZhcUV1MzlNMi9XY2hqY1JnWE9BQUJtd2psQnpJ?=
 =?utf-8?B?ZndaTEtmZncvcm1PMkFrSVFXQU50ckxsKzUwa2JkczZJL1NzYVp1TkFVL3lH?=
 =?utf-8?B?SVVzOXIyQjR0Qm5JTit6ZmdzaVljT3lYeG1BRHdJT2tCb1IrbW1hc3B0VGlj?=
 =?utf-8?B?NU5DaW9Ja0xoQzNZZzFLNG9nMUpTdExCWWcxVy9jWjY2RjJRVENYUUJueERC?=
 =?utf-8?B?cGt6NWR0TzdoRTFBWTdMdjB5UjE2a3RuQyt6ZnM0eEZ6SDdvSEcvMjBqNDdI?=
 =?utf-8?B?RlE1UVpSNnV0b3lPMTNuYnhwSjN2bXBkelBaWU5oN0M5RFJ4T1lLeHYvVlRQ?=
 =?utf-8?B?UEpsL2c3OUhHVGtGRkdndXFqbmxGdEJJaHp3TTVsL3l4RmcyKysxZHV2Y0xE?=
 =?utf-8?B?a0dIT1FYVmIyQi9qaTRyUlNyRUo2UEc5cnF2ZkwvV25sY1JSdDV4b09OY2Nv?=
 =?utf-8?B?SHFLRmp5UGl4c1Fza0dTcFR4U3dLUUw0emUwYkxzWml0TzlweFU5dGxxRVZE?=
 =?utf-8?B?K3Z6SEd2a0FNYjk2bTYvaXFORm1QelZtRTFkRUttclQ0K2lSTU9WTnNDQ3dq?=
 =?utf-8?B?OElidC9QcjRPZlN2NktEblBzeUhQd3crZVYrOTVTQ3pCTisyalpmZVptVUdq?=
 =?utf-8?B?VUtsMlRKMERWOWo4RmhxUkJZc3dpWm54ZFgrTFlhb3B6dXdPUzV3Y1gxR3o0?=
 =?utf-8?B?Y1hnMUJUemF4TkdSYXlrZ1NZZVVnUGxVQk82Vjg5K2hYTHd3RmZ2dWRza2FV?=
 =?utf-8?B?ZTNIZUlXcDJhVmZpMkJESHB5Q3d4dVhsQkRqTjR4UStjOGFwS0RDRVZ0QS9v?=
 =?utf-8?B?c1pxNzAzN0taZWJwanBpM2ZxTHhtODMyRnFHbndNR1F4dXdQaExaMEhvRXZn?=
 =?utf-8?B?YzY4bGVmNzI2WnFLSU1WK01kVjRRSU1RMHJUKzdJQXVUam1oSXhlR0ZqREJh?=
 =?utf-8?B?ODFDUDIyUG5UY0VlRmdLYzVJUmZ2dzhDelZLSzk2Tk1qeHpmY2FDdWFaUTNN?=
 =?utf-8?B?ZnBrUWd6RHpJUm5ZcVEwS1JtL25nTVVzZ29HN0c4b2kzVXhKRGJUR0ZtcjJk?=
 =?utf-8?B?S1lyTVQ5MzQ2YmtLL2tTN1E5VUNsZzh3RDFhV09yamRWYm90TFJ5V0F5S3p2?=
 =?utf-8?B?d3hGSk5mV2hGYzRCa1JsYnpzandjcEpZVEYzZWNwSDUvbFRSTWU1Z25iSS8w?=
 =?utf-8?B?Z3IycmRjckc0cnQxVWlYNmZTUVRWVWZnNmZSMUJiQTJuUWUxdVQ5SVlJWGZX?=
 =?utf-8?B?V25PZDhHaW5MeDlhbzBSSVJxZGV5T3JtcDRzdnBnQ1JOY2RUU2Z1dFE2bE5E?=
 =?utf-8?B?dlM0OFdEV3lHMFlPWDFWUk1HR1pMWFExa3EzWEZmRS9xWm5FMzYrMGxhb1ph?=
 =?utf-8?B?RlEzc0R5akkzN2h1SmVxeW5RVHpGNUVBZU9WVFYwMFlRT2t4b1FRQmVqcVo0?=
 =?utf-8?B?UWl3MXFFMFE3N0tpYnBieFkyRkNmZ1N3UVNYSzJObFJDRm1QN2d1d1BZU0ZQ?=
 =?utf-8?B?REdVVW5jaGZpcFhrZzh5cjlYOTF2MVRCVTZCSXVDL1dlMkF5SUFWTGVVQjZy?=
 =?utf-8?B?a0pBblUwKzB1UDVzME1ybStqL1JXVHhYVWZmN1JUcUlJUUpPNGJWWDFYOFl4?=
 =?utf-8?B?Y2ZrSlhpb0Z2RW8vV2V0THR5TmtYdVpuYnZRdHhta2lYZnlSRUVjRTFMVjJx?=
 =?utf-8?B?SUEwZ3FFOUlRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UklUclduSWxYSyt5L3pPbjRDKzJZZVFRMi9FMnJQeHRteWVxeXRNSnN6THE5?=
 =?utf-8?B?cVNkK1JDamxqQ0VzdkxRWmswZWMzZHA5TmxBaE9oNkhlT2xIN3M5R2k0QWpX?=
 =?utf-8?B?KzQ2VndDaURoaWJOMEN6QllyMVJlZVc0dmRuWG9Nb1oycSsvWDk3UjlHOU5n?=
 =?utf-8?B?RFNtT3ROMTZhMGpzd05yYVVQQVBndWVOKy96bEdLU0txVG1NUzA5VWZObjli?=
 =?utf-8?B?SkkwaHI0MCtLeW5CS1prZHZNb0h5b3NmVDc3MzZyYW9Ncm9zN0FnSXoxTDdM?=
 =?utf-8?B?TllUT0c2UjNoaXhVSTlybUVhRTEydyt2Z2szKzhhckoxUncxMXVwTDdJVnpU?=
 =?utf-8?B?dGowUy9IaU9QSUhXVFJQNGlCS0daM0JHVVpIRncrRHlPQ21HSHRCbzNxQ0Uv?=
 =?utf-8?B?Q0VUcnNKak1SbVZWc3VxVUtxZUtkUUxGVGNqQmxqTWMzdUVJUEU2a2ZaSlVl?=
 =?utf-8?B?U3dZUXd6YllkbEl1elk3bmlaK3pPNzgweFBmaDJ6aWNxQmZxOTV5NElLbExL?=
 =?utf-8?B?ZC9TeG1QbVpYQ1JXN0hIM2o1cmpidE9JRXFiZkNyN1ZEV0JySGF4NktlYUN6?=
 =?utf-8?B?WmRYemdOYnErbXdkS1RwK0xNdjVUUlBxc0lXSTlSWXRGejZ0ZFh4K25YTlUy?=
 =?utf-8?B?ZllLYzlockVIM2xuK3RQMGNlRUdteEliNE1menFET253b2dFZ1lzYU1lVnFE?=
 =?utf-8?B?RFQ1eGZqQmtDRENBRUNzcWszQVZnbDNlaEo1YUQ3QUpxNFAwWHRJZ3l1ZlMw?=
 =?utf-8?B?QmxSZE9ES09QMEFWbEVIa2JuSTRaNCtsM2kzTko5QTRhTmpwSXZvcFNEL3Vs?=
 =?utf-8?B?N2FZR003ZkJSbzEvVEo3elk2MDc2djg1ck52aW92ZGpMYjNKTUgwcHNvdGYr?=
 =?utf-8?B?Ym9LWnNlVk9hbWVFdlRybFZGRUJtSlVkM2hob252dXQ3MzNYUnc2MGVKbnU2?=
 =?utf-8?B?RG9KT1AwZ1ZMMHpSby9zTTdYQ01WTDFXRlJXaUVaMlJkanBUQ0ordFBqaVVE?=
 =?utf-8?B?NWpxbEJyTlFMRGRGTGJ5aGNZdTdlV0o1US95MnpIeXlrOXhWdG1ybm0rMlRW?=
 =?utf-8?B?N2l1a0VZVXczcS9LQ1FBdUVxSU9zTWNIek1pZzdGRHFGMWxRKy9hK2lGRHBw?=
 =?utf-8?B?MmsrOUlSbUZla2Mwcy9INU1kM3d3UElqMldFR3NxZ0RacDY3d1NPQ0g3T0tp?=
 =?utf-8?B?eDJNZFRySjhBZjhzN0VyUnlJSS9DQ2xkV0lGUUVYSFZyMStSN2F3Wm5xQVNw?=
 =?utf-8?B?YlQvRHJBU0ZpMXpJUWwzZURyV1NWc0laQWhTeXF6MzN5OWxyNGlXcWU3cjZT?=
 =?utf-8?B?ZnB4bHdiT2xCdmNDTlc1Ri9jUTBtMmRiQjR6YmhVRW8zRCs1SUlMR1dJWlpZ?=
 =?utf-8?B?OUNSNVNPNjZZaWthZlJHR2cydlFZU29mK0xqZjc5azgvcDNDN3pPT3doNVdj?=
 =?utf-8?B?U0lCVDhuVlBUc0ZMbUpoV0ZxODhnYlgvd05uNmk5U0xoNE5uUnlOcFdSZENK?=
 =?utf-8?B?VXRjakRBL2d5ZUNNS2xnNVNmYitzaXVsSExWZllYbmpaUUlLUW1TWUJKVG40?=
 =?utf-8?B?cHJkOVovR1JCNTJRQ1FnaHk0M2lOa0kyKzRydURSa3lWeXg0QVYwNk9nS29h?=
 =?utf-8?B?NTFvK1E2VlBnMFJVMS90dTVCTWwzV2RRd0l6MFRXV1ZXZWdnaFNUMEQ4eldY?=
 =?utf-8?B?bWZaKzh1RkErTGY0bWUzcjduVU55ZWVQTUJ1bkxCeVlnZm9QV2FxU0drQXVD?=
 =?utf-8?B?Z3B6U1RaaHpsbXcxN2cycDFOREhSMm1oRzlMRE0vZUtiVzR4TWdDWXdNRHJr?=
 =?utf-8?B?VXBvekE4K2NFQ2ZUbTBldWNlRS9zRVZIaFVURlBwbXZwMUpaeEpwWXE3YzZj?=
 =?utf-8?B?YWhKdmRGMFlLUE1Ra091QXorNERDL0plbzUxOXJqbjRPZWg2WkNpSHZVbk9X?=
 =?utf-8?B?OUU3ci9GNnpESzNtKzRjdjlsc3JBaUlLVjUwcWFJZFRFWjZyeTVhZnJOWmUv?=
 =?utf-8?B?OVh1cEZZUis1NGQyR3o3cmphY1IxWHY2RkgyN1hIbGR5YW9UN0w5WXJwemEw?=
 =?utf-8?B?WDNLQzVzZWVVMlViNkI2UEY5ait0NFpTVEs4NHljcXMzUmlKNzQxZzBEcmVO?=
 =?utf-8?Q?Ov7w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b07500-745e-444b-a7cd-08ddc436e2d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 07:03:36.8765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/TEF0G3RbM1oB8UfcJUzXH4EuhwvuJ4xWIbpEajIrcay7NyJ4fkczdtZ2QY4t6M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVseSAxNSwgMjAyNSA0OjQ5IFBNDQo+IFRvOiBMaWFu
ZywgUHJpa2UgPFByaWtlLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDAzLzExXSBkcm0vYW1kZ3B1OiByZXdvcmsgdGhl
IHVzZXJxIGRvb3JiZWxsIG9iamVjdA0KPiBkZXN0cm95DQo+DQo+IE9uIDE1LjA3LjI1IDEwOjA3
LCBMaWFuZywgUHJpa2Ugd3JvdGU6DQo+ID4gW1B1YmxpY10NCj4gPg0KPiA+IFJlZ2FyZHMsDQo+
ID4gICAgICAgUHJpa2UNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiA+
PiBTZW50OiBGcmlkYXksIEp1bHkgMTEsIDIwMjUgODowMSBQTQ0KPiA+PiBUbzogTGlhbmcsIFBy
aWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
Cj4gPj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4N
Cj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwMy8xMV0gZHJtL2FtZGdwdTogcmV3b3JrIHRo
ZSB1c2VycSBkb29yYmVsbA0KPiA+PiBvYmplY3QgZGVzdHJveQ0KPiA+Pg0KPiA+PiBPbiAxMS4w
Ny4yNSAxMTozOSwgUHJpa2UgTGlhbmcgd3JvdGU6DQo+ID4+PiBUaGlzIHBhdGNoIGFpbXMgdG8g
dW5pZnkgYW5kIGRlc3Ryb3kgdGhlIHVzZXJxIGRvb3JiZWxsIG9iamVjdHMgYXQNCj4gPj4+IG1l
c191c2VycV9tcWRfZGVzdHJveSgpLCBhbmQgdGhpcyBjaGFuZ2Ugd2lsbCBhbHNvIGhlbHAgd2l0
aA0KPiA+Pj4gdW5waW5uaW5nIGFuZCBkZXN0cm95aW5nIHRoZSB1c2VycSBkb29yYmVsbCBvYmpl
Y3RzIGZvcg0KPiA+Pj4gYW1kZ3B1X3VzZXJxX21ncl9maW5pKCkgZHVyaW5nIHJlbGVhc2luZyB0
aGUgZHJtIGZpbGVzLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQ
cmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+Pj4gUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxl
eGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jICB8IDYgLS0tLS0tDQo+ID4+PiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMgfCA3ICsrKysrKysNCj4gPj4+ICAyIGZp
bGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMN
Cj4gPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPj4+
IGluZGV4IDNkMmE3Zjg5NDZjZi4uMTVlODMzYjFiM2UzIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPj4+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4+PiBAQCAtMzEyLDEyICsz
MTIsNiBAQCBhbWRncHVfdXNlcnFfZGVzdHJveShzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHAsIGludA0K
PiA+PiBxdWV1ZV9pZCkNCj4gPj4+ICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+Pj4g
ICAgIH0NCj4gPj4+ICAgICBhbWRncHVfdXNlcnFfd2FpdF9mb3JfbGFzdF9mZW5jZSh1cV9tZ3Is
IHF1ZXVlKTsNCj4gPj4+IC0gICByID0gYW1kZ3B1X2JvX3Jlc2VydmUocXVldWUtPmRiX29iai5v
YmosIHRydWUpOw0KPiA+Pj4gLSAgIGlmICghcikgew0KPiA+Pj4gLSAgICAgICAgICAgYW1kZ3B1
X2JvX3VucGluKHF1ZXVlLT5kYl9vYmoub2JqKTsNCj4gPj4+IC0gICAgICAgICAgIGFtZGdwdV9i
b191bnJlc2VydmUocXVldWUtPmRiX29iai5vYmopOw0KPiA+Pj4gLSAgIH0NCj4gPj4+IC0gICBh
bWRncHVfYm9fdW5yZWYoJnF1ZXVlLT5kYl9vYmoub2JqKTsNCj4gPj4+ICAgICByID0gYW1kZ3B1
X3VzZXJxX3VubWFwX2hlbHBlcih1cV9tZ3IsIHF1ZXVlKTsNCj4gPj4+ICAgICAvKlRPRE86IEl0
IHJlcXVpcmVzIGEgcmVzZXQgZm9yIHVzZXJxIGh3IHVubWFwIGVycm9yKi8NCj4gPj4+ICAgICBp
ZiAodW5saWtlbHkociAhPSBBTURHUFVfVVNFUlFfU1RBVEVfVU5NQVBQRUQpKSB7IGRpZmYgLS1n
aXQNCj4gPj4+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3VzZXJxdWV1ZS5jDQo+
ID4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+Pj4g
aW5kZXggMTQ1N2ZiNDlhNzk0Li4xNWFhMWNhNjdhMTEgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tZXNfdXNlcnF1ZXVlLmMNCj4gPj4+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc191c2VycXVldWUuYw0KPiA+Pj4gQEAgLTMzNiw2ICsz
MzYsMTMgQEAgbWVzX3VzZXJxX21xZF9kZXN0cm95KHN0cnVjdCBhbWRncHVfdXNlcnFfbWdyDQo+
ID4+ICp1cV9tZ3IsDQo+ID4+PiAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3VzZXJt
b2RlX3F1ZXVlICpxdWV1ZSkgIHsNCj4gPj4+ICAgICBhbWRncHVfdXNlcnFfZGVzdHJveV9vYmpl
Y3QodXFfbWdyLCAmcXVldWUtPmZ3X29iaik7DQo+ID4+PiArDQo+ID4+PiArICAgaWYgKCFhbWRn
cHVfYm9fcmVzZXJ2ZShxdWV1ZS0+ZGJfb2JqLm9iaiwgdHJ1ZSkpIHsNCj4gPj4+ICsgICAgICAg
ICAgIGFtZGdwdV9ib191bnBpbihxdWV1ZS0+ZGJfb2JqLm9iaik7DQo+ID4+PiArICAgICAgICAg
ICBhbWRncHVfYm9fdW5yZXNlcnZlKHF1ZXVlLT5kYl9vYmoub2JqKTsNCj4gPj4+ICsgICAgICAg
ICAgIGFtZGdwdV91c2VycV9kZXN0cm95X29iamVjdCh1cV9tZ3IsICZxdWV1ZS0+ZGJfb2JqKTsN
Cj4gPj4+ICsgICB9DQo+ID4+PiArDQo+ID4+DQo+ID4+IFRoYXQgbWFrZXMgbm8gc2Vuc2UgdG8g
ZG8gaGVyZS4gVGhlIHBpbm5pbmcgaXNuJ3QgZG9uZSBpbg0KPiA+PiBtZXNfdXNlcnFfbXFkX2Ny
ZWF0ZSgpIGVpdGhlci4NCj4gPiBZZXMsIGJ1dCB0aGUgZG9vcmJlbGwgQk8gaXMgcGlubmVkIGJ5
DQo+ID4gYW1kZ3B1X3VzZXJxX2dldF9kb29yYmVsbF9pbmRleCgpLCB3aGljaCBpcyBzdGlsbCBJ
bnZva2VkIGR1cmluZyB1c2VycQ0KPiA+IEJPcyBjcmVhdGlvbiBwaGFzZS4gVGhpcyBwYXRjaCB3
YW50cyB0byBmcmVlIHRoZSBkb29yYmVsbCBvYmplY3QgbGlrZSBzb21lIG90aGVyDQo+IHVzZXJx
IG9iamVjdHMgYXQgdGhlIHVuaWZpZWQgcGxhY2Ugb2YgbWVzX3VzZXJxX21xZF9kZXN0cm95KCku
DQo+DQo+IFllYWggYW5kIGV4YWN0bHkgdGhhdCBpcyBub3QgYSBnb29kIGlkZWEuDQo+DQo+IFRo
ZSBkb29yYmVsbCBvYmplY3QgaXMgcHJvdmlkZWQgYnkgdXNlcnNwYWNlIGFuZCBub3QgYWxsb2Nh
dGVkIGJ5IHRoZSBrZXJuZWwgbGlrZSB0aGUNCj4gTVFELg0KPg0KPiBTbyBkZXN0cm95aW5nIGl0
IGhlcmUgbWFrZXMgbm8gc2Vuc2UgYXQgYWxsLiBZb3UgYXJlIG1vc3QgbGlrZWx5IG1lc3Npbmcg
dXAgdGhlDQo+IGRvb3JiZWxsIHJlZmVyZW5jZSBjb3VudCB3aXRoIHRoYXQuDQo+DQo+ID4+IElu
IGdlbmVyYWwgd2Ugc2hvdWxkIGF2b2lkIHBpbm5pbmcgdGhlIE1RRCBpbiB0aGUgZmlyc3QgcGxh
Y2UsIHRoYXQNCj4gPj4gYnVmZmVyIG5lZWRzIHRvIGJlIGZlbmNlcyBpbnN0ZWFkLg0KPiA+IElm
IGhlcmUgbm90IHBpbiB0aGUgdXNlcnEgZG9vcmJlbGwgQk8sIHRoZW4gd2lsbCB0aGUgZG9vcmJl
bGwgaW5kZXggYmUNCj4gPiBjaGFuZ2VkIHdoZW4gdGhlIGRvb3JiZWxsIEJPIGlzIG1vdmVkPw0K
Pg0KPiBDb3JyZWN0LCB5ZXMuIFRoZSBkb29yYmVsbCBpbmRleCBuZWVkcyB0byBiZSB1cGRhdGVk
IG9uIGVhY2ggcmVzdW1lIG9mIHRoZQ0KPiB1c2VycXVldWUuDQo+DQo+IFdlIGhhdmVuJ3QgaW1w
bGVtZW50ZWQgdGhhdCB5ZXQgc2luY2Ugd2Ugd2VyZW4ndCBzdXJlIGlmIHRoZSBNRVMgRlcgY291
bGQgaGFuZGxlDQo+IHRoYXQgKGFuZCBiZWNhdXNlIHRoZSBldmljdGlvbiBmZW5jZXMgd2Fzbid0
IHJlYWR5IGF0IHRoYXQgdGltZSkuDQpUaGFuayB5b3UgZm9yIHRoZSBoaXN0b3J5IGxlc3Nvbi4g
SWYgdGhlcmUncyBubyBvYmplY3Rpb25zLCBJIHBsYW4gdG8gcmV3b3JrIHRoZSB1c2VycSBkb29y
YmVsbCBvYmplY3QgbWFuYWdlbWVudCBzZXBhcmF0ZWx5Lg0KDQo+IFJlZ2FyZHMsDQo+IENocmlz
dGlhbi4NCj4NCj4gPg0KPiA+PiBSZWdhcmRzLA0KPiA+PiBDaHJpc3RpYW4uDQo+ID4+DQo+ID4+
PiAgICAga2ZyZWUocXVldWUtPnVzZXJxX3Byb3ApOw0KPiA+Pj4gICAgIGFtZGdwdV91c2VycV9k
ZXN0cm95X29iamVjdCh1cV9tZ3IsICZxdWV1ZS0+bXFkKTsgIH0NCj4gPg0KDQo=
