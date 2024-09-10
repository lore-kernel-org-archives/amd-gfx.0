Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E992ECE564
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 07:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4CEB10E710;
	Tue, 10 Sep 2024 07:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EklE6jyS";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3215910E710
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 07:11:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpH4DkK8uUkGXPrcbmX3Kt621ip23jsyA9o4/4/1foinakYYdJkgrFZtJuxYu+8dYuuxe184XQwxCHmRveOaJMwUGBq8IP/LSJ3VkPzIicK/zxeqJyuZsKUsd9YMaqa4M7DnvdsCmpXnhCHNTTI0zRxUYkaD3nLpBw7gis6TUbCqJiKZOq2OAQnhUjQHa0PYA18TRk2aSOYQpS+4OfcOXBimpozutgh+T4zUkULBu4XszLwzdlB0bLLh+x2WMi/ea1p3vllMggCQxwHX+AHpgnjNsqWscyNKQ9SueYNIPuVCSVyFQuDeUzMLSTWm4nCPYxMga0ESc/T137lBMMf93A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVv6Qvtd1OY6HVBC6Mm0b66txMmjJAgAdp2blekDwQw=;
 b=JbNIhzdwsRXq00CPPkXjJ6P0gi6MFYF/5cKlcUigMn+/Ru5cX9ku9i19ZbE6K3oYvB6UF3ZoyItSxxvZVBkBiO+pi8TK/NTcjw879m4gKntr8uLKsLsMufH9rrXVbyjgJ1vePG7XBt0liVxgxfsKOcy/VBgLC+nqMlmvc1JlqRwSYFsi8uTCJ03RMO9Q85/DIjO4TrgdUXz6P9/f05hJ/kr7SMJuDjrMpbnPe5osU82I+El0iLPHn+umFoLoxqRvQPl5Xr+BH/OQ/YIh0MQ/j25iTUY5jHq/DQiZkKCCY+6Za8YFjCUQC6fGKWTXrBdKYEdpI6krSJVCahbYTZW4Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVv6Qvtd1OY6HVBC6Mm0b66txMmjJAgAdp2blekDwQw=;
 b=EklE6jySleUY/CgGhZe4l+ZkBmmr+82rLVNyXO/pAjEihbNNTv9NDKRoDwrj2Va6R7OOLqEj52Fu5TGwl9+YYO8P5ta5zwxod7tbxmdEg7FxizJn0U+FvYBz+LPs6bpjOrJ1hEOxuChzGcsXdjWys7OynU48laCZ23TBS3wZI98=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 07:11:43 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 07:11:43 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: disable GPU RAS bad page feature for specific
 ASIC
Thread-Topic: [PATCH] drm/amdgpu: disable GPU RAS bad page feature for
 specific ASIC
Thread-Index: AQHbAzXirvBRcnWm40mYEhgewlwCtLJQfB0AgAAeoWA=
Date: Tue, 10 Sep 2024 07:11:43 +0000
Message-ID: <PH7PR12MB87960F572E15CFEC2212F0CFB09A2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240910035914.20273-1-tao.zhou1@amd.com>
 <df19af91-5984-4520-bd39-1ef1fa5bc1db@amd.com>
In-Reply-To: <df19af91-5984-4520-bd39-1ef1fa5bc1db@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=2923643a-76a9-4d9e-9f49-8eeed07cbcd1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-10T07:10:57Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|IA1PR12MB6091:EE_
x-ms-office365-filtering-correlation-id: f2e08656-2683-4737-c81b-08dcd167d2f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N2hPbkxXa2hINE9JenJGc05maDZXWlo4ck5JMVBXc0ZVUnMyUm96d3lQNEta?=
 =?utf-8?B?anlZSHFiTVRWcWJHc2I2TGt1bjd4N2xKdzExMVFzTzVpd1F5Tk1pejZEL3pu?=
 =?utf-8?B?QzBudVFkSFhUMXU5M2hGRGhhdGY2VEFqTnBTZWNORmY5bmI3WTliMTl1MjVi?=
 =?utf-8?B?VzhHUnBvQmlRZGNldC9pT1JvQk15bUovalB0aXlKRGZsdFVtcmlVMkp6YVBu?=
 =?utf-8?B?VExnWHphNDRBMTZQNTI4SVlZZFAzTCtsb3VCbEQ0V1JCL3pYK2QveHViY25Y?=
 =?utf-8?B?czBUelEvT21BUE9HUXQ5T2pNWmRqNFRZb1lWNTQ3U1dyUTFDdWJlVTRueGRZ?=
 =?utf-8?B?NHE4VzM5YTdxcVNzcXJjK0d2alZqNmdhLzV2K2o4YTVPdmZUSWZla2ZsSHFx?=
 =?utf-8?B?dk5KQzBKckV3NmhqOFVINFNqdWpZdXAzSUR4eGMxRktRTlV4VkVCQ25SUnI1?=
 =?utf-8?B?S25TQlZFaXlONll6bk1JaUpRck1HSHhSNnA0emZWeDZBN2I3L3lIVnBQL2ln?=
 =?utf-8?B?M092K2ljNHpLUkxMdXZQbUtxZ2lWd21IY3htK3kxS2RmYy9vbUlYM0ZIY3Vu?=
 =?utf-8?B?K2ZDNmVSU1BPMmJ2aTBnMmRDT0FVZzNSR3BaRFlNQ1FSbjVsMEcxNW1QSW5S?=
 =?utf-8?B?VEM2TDdHT2Q4TFlEcW5NRlJOK245YlJsK0w2Z1hxK3UyanBDTFRZK3BiZk83?=
 =?utf-8?B?OERnbjBQb0pBbkU3WTVLZEZhQVV1Q1NDckZpWXczUkFHZnZxZ0c4UDlPbkNI?=
 =?utf-8?B?VncxVWorclRiYXhTd1dCMWY2aTZTL2lJancyQmNMWXNwNStmUXhhNHdTM2lO?=
 =?utf-8?B?TS9jYXFKY216cWxXUGhMRFRPdU9US0ZnOC8xOWgrN0o3OGZRYnR4M2VvUFU4?=
 =?utf-8?B?SFBOT2lzTW9wbjFiZ0hEMUtnVWI2Tnl4ejdwSDZ2MktlOFFlR3l3WTAvUWQ5?=
 =?utf-8?B?ZHhSS2pWdmJjN0ZsR243UDJPbWV6eWpuU1laTjkyRGhWYm14WEsva3BZSzhD?=
 =?utf-8?B?UElNWXlsSEM4SVVCSGZDZjRIR01iRkhsazNGcGszazMzaW9JWEZPTVF2STRa?=
 =?utf-8?B?SzdCM3QxcG5BQ0ZSdlBqZ2t2M3lic0Y1b1BxYjdvVldRYzNpa2hHRFF2ek80?=
 =?utf-8?B?c0VmRTBrd1ZyR295L1FRbmZBTXIrcVdaTkh2TTRGRisybndJV1lkWDZ4Rjln?=
 =?utf-8?B?bHJrRXBRTHNQTU9KY3JPdzR0Wjhpbk10WTVJRUhqdzJodzdBaFpTdHh5SzY5?=
 =?utf-8?B?bzJ1RnU4QTVpN1RDbENjalA1ZGhYWElORGJLMzJsMXlwTzAvNWl6a2RKVElW?=
 =?utf-8?B?QTk2NDV0SHZQWDc0dHBLd0xrWC9DbjEyejVjYUlrV1REQ0JwYUp2Q0JSTjZk?=
 =?utf-8?B?akIwR1IrV2U3QWxxeGtwa09ROXZ3aUZPWVVQa285ZEhQTEJiOVNsR0R2VzY3?=
 =?utf-8?B?cHQrNjUrREU3WDA5Q21mTVhsOGYwWmQ2dDJWb2FaNGY1K3Jib3YvU1liSG9R?=
 =?utf-8?B?RzdiY3hsSEJ2MXBxUTlCUHRvMWcvbXVETkZSZTVoK1lEVkJXQ2JLcXZiMWNa?=
 =?utf-8?B?TDZQQ1A2OHJqRUdzalQzS0txREVwNmxOMm5oTm92cWkxKzhsYWpOZEZtNUpw?=
 =?utf-8?B?d3BSK3MyY09YRlIycEtUWWxLQkZJRnBvUDFobnhlVE9qd3FDeFlsajJyNkR6?=
 =?utf-8?B?RkVTMW9LNkZNNjMvTG5WNUVQRm9wOHVPSHdXbW0xRU5BYzhZNUhDbEg0ZzAy?=
 =?utf-8?B?dnA0Vk9VMzluMGRqVjh0cmZPdmlYWis3UHhENnplUEZ5Z1dFNjhFTWpFTWN2?=
 =?utf-8?B?MVZMY3ZURVJFTVNKWExzaW1hcmx5ZXZLQnUvMndCOWk5cTVlbVpnUDhnaStC?=
 =?utf-8?B?N05UQ0MwemUwQjVTV1hPRmhuaTk5TUxXMXNXWEhlMGxFK3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1Nta3p3N1RSUFhIMWVhSEt1ZHNaSHBVZnR1bUNqWElMWHMxQ1pGaGJYRlpn?=
 =?utf-8?B?Y1BCRjZJeGROVExZUzlaTkQ3R2Vidk1mdUxrT0JLRzBJQUZpU1hwV2Y2TmRS?=
 =?utf-8?B?MnlVM2lwbFpMUzFweWJkWjNqT2YvRkR1Si9tajczazZOQ3h6YmUxL3RpWkRL?=
 =?utf-8?B?ays2NXNlbm9NUDlpajhMdXkwWDQ5RDRhV2xtUDFXRXdPR0VvVE0yYVdjVlJk?=
 =?utf-8?B?bkF6VHFoZG1FaFZBQ3dqdm51QzRCMjRsdjJRY2twT2FxSjF4djVqSzdOQ0VQ?=
 =?utf-8?B?YW5QMVAvUk4yWE1LdkVSdGpDTi9TSWVUV29HbWpsNDdiMm9SSHdOQXF5SzYw?=
 =?utf-8?B?aEhHamV6VDBqNzU3bXVCTWZIb3Y0WUFQOEtKYXUxR3ZxTkRRR215UWlHaVI0?=
 =?utf-8?B?R0FhUFE4Uys1OXNVWUNJbkJubXFaZURpQXJHaHZsN25VbzhwYlhjUVp2b3Nw?=
 =?utf-8?B?TDhTSDBpeUE2eDBPNmUwRGJ1U3hnOCtZdjF6dFlTQ1lVdnBFdTFveTROTjJQ?=
 =?utf-8?B?azhMY29uc0dwd1ZxNXduTUJpRUpCcStqbFVVLzlCc2p6M3FLaWdXSndMNTdF?=
 =?utf-8?B?dGR4dWg4cVhmTWxLOWJrTU9vU3k4VkdSQS9ZQzgxdkdPT1FCdGN0WHl4THZB?=
 =?utf-8?B?Q2VRQU5INittbGRsY05pMStiN0grZnZPc2REZmVkSGVnblhnY2EvWjlXU2xQ?=
 =?utf-8?B?QUpPdk11QTVzUlR1NG50VzhuODJYcEtGWjJKVXJCNkk1Z05pVzVicXhIZmpp?=
 =?utf-8?B?WGlHcUkzK2tQQms2cmUvMmRNc1JwbFNrQVlBNXRwVTVyYVlYaFhoM0pyU3dK?=
 =?utf-8?B?WWFOK2FkR0pmL3pXcFFYSWw5SWhyUXZqYVhpVS92aU1qZjg2OStpMUhpemlu?=
 =?utf-8?B?T1dkNnlKdHppSjJ5M0ZmS1VRS1BZVXpFb1oweURVZnNNSnpSeUdYUkw5Z2k5?=
 =?utf-8?B?UnJiZEFvVkQrVEFXaUxMQWJlTFRialNiMzhOZVhPZU52ZnFQTzhMcHZQQnVR?=
 =?utf-8?B?R2FWKzh6M0R0cTM4NEpTWWt1bDdtcDBYVlpJczY5Z0tXQXZyaG5FMVJxd2Qv?=
 =?utf-8?B?cWVhdzgranFJN0E5NHFic0p2UmR6L21nNlkzdlBESnVMVnJQa0pEU3I3bzZ6?=
 =?utf-8?B?SlowSlpOM0c5WDY4UHJBVExhZzkvVVBjWWJHd2tKM09tMVptbWFaaC9wTUs1?=
 =?utf-8?B?YjJROUkwcWlCWThSdmtmT0psVG4vQ1VLem84b0ZCcjJpaFRiZ2dxTVB0di80?=
 =?utf-8?B?M2cxRUE5b2gvY2VGYzJTVUJwNXhlMEIySEFjVDNNNE55Qmd5bVY0MVZ3N1dl?=
 =?utf-8?B?ZVJXQThSUHJSUE9jYlduVG9GcVFUdWxBYWRmYmR1RUMzQmtrbk51RkR0bWR6?=
 =?utf-8?B?cGxuaEEzYlA4SldjNXpTS1NJbnM0NjVrMGlqSHQ4MnlNZkpJOG9pb0tyMWI3?=
 =?utf-8?B?WlBscWNjYlpyTlRscnM5SGs5bzRQZk1wUUhYb1Q5OVpjKzJIdkpOcTk0YXhS?=
 =?utf-8?B?dGh3VThNNlhWOUpaVE5rbERtRTg1WlIwcC9EcVIwZ3lINFNpaEoyVHdiV3Nw?=
 =?utf-8?B?aXFiaERMdkFIUWFVZ3VPSm5WWGFlbEh3QnZRNEl1c3NxMWlmMXlnajNPSkVU?=
 =?utf-8?B?bUZaUHQ4OW5QVVpacG5HeHplcHRxSzRmTTNvZ0JYRmZMSjhyNEVlejJMVVFv?=
 =?utf-8?B?bVAwVTRHTkgwWVc0R2lLRVVkU3FwbldEQXd0Yk5SY1p1KzVFRzloOGdPRDYx?=
 =?utf-8?B?WTRod2pZSnNJT2liaE5oU3EvemF5RmVwdXJ6L2VCMHFZK2Y1cXNMQ1Zub0Uz?=
 =?utf-8?B?Ri84c2FhSjg4OURFcmtnVVVMbFFXZlg4a3dUQ2VZcEZQUUtDbGQwK3N3N3I0?=
 =?utf-8?B?WmNrdTlPdDVPWE1iak1kVERWUkxpWEFpMEEySnI2ZHYyalJBYjhRbXZJWTU5?=
 =?utf-8?B?MGhLMWVnVDJyb3c1dHZrcWVQNFI1cDl4VHhYVnp6TmN3TVg0SU9KSVF4R2c3?=
 =?utf-8?B?Z3pzY0N6RGwxbzRVeWs0ZVZWQy9Kd1FBSGNmSmI5bkd4QWtsS1pTalVnRXBR?=
 =?utf-8?B?aXpCUDFSNnJoZUowbHltVG1Ebk9nWmMvWW5sZlgzRWphSHJ6V2doc2MvMHIr?=
 =?utf-8?Q?8yhM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e08656-2683-4737-c81b-08dcd167d2f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 07:11:43.0580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbQOxIKgS/NS3NsUPSysnmHaUd4F6UH1GI8ecUyMS6E2351AzLUqCKdBMv04IsTc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMYXphciwgTGlqbyA8TGlq
by5MYXphckBhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTAsIDIwMjQgMToy
MSBQTQ0KPiBUbzogWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBkaXNh
YmxlIEdQVSBSQVMgYmFkIHBhZ2UgZmVhdHVyZSBmb3Igc3BlY2lmaWMNCj4gQVNJQw0KPg0KPg0K
Pg0KPiBPbiA5LzEwLzIwMjQgOToyOSBBTSwgVGFvIFpob3Ugd3JvdGU6DQo+ID4gVGhlIGZlYXR1
cmUgaXMgbm90IGFwcGxpY2FibGUgdG8gc3BlY2lmaWMgYXBwIHBsYXRmb3JtLg0KPiA+DQo+ID4g
djI6IHVwZGF0ZSB0aGUgZGlzYWJsZW1lbnQgY29uZGl0aW9uIGFuZCBjb21taXQgZGVzY3JpcHRp
b24NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwg
NSArKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQo+ID4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gPiBpbmRleCBkYmZj
NDFkZGMzYzcuLjA4ZWZjOTEyMWFkYyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmFzLmMNCj4gPiBAQCAtMjA1NSw2ICsyMDU1LDExIEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3Jhc19mc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2KQ0KPiA+ICAg
ICBjb24tPmV2ZW50X3N0YXRlX2F0dHIgPSBkZXZfYXR0cl9ldmVudF9zdGF0ZTsNCj4gPiAgICAg
c3lzZnNfYXR0cl9pbml0KGF0dHJzWzNdKTsNCj4gPg0KPiA+ICsgICAvKiBiYWQgcGFnZSBmZWF0
dXJlIGlzIG5vdCBhcHBsaWNhYmxlIHRvIHNwZWNpZmljIGFwcCBwbGF0Zm9ybSAqLw0KPiA+ICsg
ICBpZiAoYWRldi0+Z21jLmlzX2FwcF9hcHUgJiYNCj4gPiArICAgICAgIGFtZGdwdV9pcF92ZXJz
aW9uKGFkZXYsIFVNQ19IV0lQLCAwKSA9PSBJUF9WRVJTSU9OKDEyLCAwLCAwKSkNCj4gPiArICAg
ICAgICAgICBhbWRncHVfYmFkX3BhZ2VfdGhyZXNob2xkID0gMDsNCj4NCj4gSSB0aGluayBzeXNm
cyBmaWxlIGNyZWF0aW9uIGlzIG5vdCB0aGUgcmlnaHQgcGxhY2UgdG8gZG8gdGhpcy4gSXQgc2hv
dWxkIGJlIGRvbmUNCj4gcHJvYmFibHkgbXVjaCBlYXJsaWVyIGF0IGEgcGxhY2Ugd2hlcmUgaXQg
c2F5cyB3aGF0IGZlYXR1cmVzIGFyZSBzdXBwb3J0ZWQgZm9yDQo+IHRoZSBTT0MuDQo+DQo+IFRo
YW5rcywNCj4gTGlqbw0KDQpbVGFvXSB0aGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbiwgd2lsbCB1
cGRhdGUgaXQgaW4gdjMuDQoNCj4NCj4gPiArDQo+ID4gICAgIGlmIChhbWRncHVfYmFkX3BhZ2Vf
dGhyZXNob2xkICE9IDApIHsNCj4gPiAgICAgICAgICAgICAvKiBhZGQgYmFkX3BhZ2VfZmVhdHVy
ZXMgZW50cnkgKi8NCj4gPiAgICAgICAgICAgICBiaW5fYXR0cl9ncHVfdnJhbV9iYWRfcGFnZXMu
cHJpdmF0ZSA9IE5VTEw7DQo=
