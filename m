Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F619CF256C
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 03:53:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C7410E05F;
	Wed, 19 Nov 2025 03:53:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w9oGbVZk";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF6010E05F
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 03:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bG/PGLKomwaH85l4aJDSzmctsuFTp57wTA55hVaqAHugDNo4sRVMZnlNKmbrpnsEGunEnMwBu51M0KI2ZC2Xed8CWk8zQSjmgJogGW0Yx0S529Zao3gSbBy46Siy+sDDekALlQqaB/8KO1s1Ezor+Yv/rCjmWkPVth77F0Cm+dznI1PwJaWYIY13Zw2ARqSD7js22bH4l0BmJlrN2/ShH09wuEHaLkPElV1LcHrvtXs2A9W9bjwPYV5XoV6GiwSXxzK0lb2BGieNfS34+9mZBksox/jadqCj4FtFeAWqpMBlSQxVfZq+EX4NEZGp6a0Rs1+HC3FwjiOKTbzG1ggNeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gdi7xhYj2TrlzkrdYFvosyF+P64r2ep3n9tgm1OEgOQ=;
 b=tr04VaCibJPiKpllNSEcB5gf85P+N0R42WLDS44cTrLNA7IRHcKyrAU+rs0pPzJBHmAt9oWirNjQ63qnvC92H62meXVOjF37SUcrq7l/3HTpdy84xsFUken/mNudjzkoH23gAoCTm5NNKeF+DKXEznmuMfZ7GVpdQNVqohXyFth0h/xkvs6x6FwRYLCivG0k4oUznAiVChXUT618wD2Leo064VNlDVmJjV6tY3iHCKUm1G2x/QsBRWI6Le/JHvPkGRiXb1xnq1vKU/Q+LssDpKMwPAcQvsv/FNP7kulfSGYndDDZoIYIl9GbdU0qgOhfkc8HFK27JMwjXNQWkgO/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdi7xhYj2TrlzkrdYFvosyF+P64r2ep3n9tgm1OEgOQ=;
 b=w9oGbVZk+c+MOjShrfEGqCzgBK0kjHKECBBqzA4yxgE/pm9q2puk4Lbj99poJCMVjbSz7mnXJlyuLlRcdgR7jj9IZ0sg0JFk/Fvv+kD2RBdXqsCerddWAYAEtS0aijENkzpd8CsNc4hyXuRu25A6k51khbk0estXreGUiHrAdmY=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Wed, 19 Nov
 2025 03:53:01 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 03:53:01 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix amdgpu_irq enabled counter unbalanced on
 smu v11.0
Thread-Topic: [PATCH] drm/amd/pm: fix amdgpu_irq enabled counter unbalanced on
 smu v11.0
Thread-Index: AQHcWQCTt3HEQx9OnU2muVIb27v98rT5XAEAgAAAkFA=
Date: Wed, 19 Nov 2025 03:53:01 +0000
Message-ID: <PH7PR12MB5997BB16DDF26145970B094182D7A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20251119025927.1813858-1-kevinyang.wang@amd.com>
 <CADnq5_N8Gid+=Q29mwNDW9Qx771qPnoKxPocL=NZ_vDKf0ZJzw@mail.gmail.com>
In-Reply-To: <CADnq5_N8Gid+=Q29mwNDW9Qx771qPnoKxPocL=NZ_vDKf0ZJzw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-19T03:47:54.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|IA0PR12MB8745:EE_
x-ms-office365-filtering-correlation-id: a598637c-0df3-448b-fc1d-08de271f22ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Q3VhSEVBZEpmT3FtTlp5NVRsY0hUL0ZtanBacjJacUtTMFp2Sy9WekJlTFdU?=
 =?utf-8?B?bWgzd0FWN2x3SnZVVDBNLzhWM3k1amsrK1FOVGlHOC9hSWNUUVNiZDk1MzVP?=
 =?utf-8?B?SDlIOGY4aW9hVjZlMFRzUEhiRHNGWGtReExiUW5yUVZEb1RNQmpHdmhFcU5I?=
 =?utf-8?B?WE03dzN2OFpBSWNlSUthZFBDaUpsUnl3ckRZMlVOVTFtMENraVkvZUtSaUV6?=
 =?utf-8?B?U1FHTHViVzMxTm1kTWtBMFFlMUNOOVlmdU4zcWFVWWR5ODk1bGpFOURCWDgy?=
 =?utf-8?B?L2c4TEpJU01qdkg4R0p4MVZvMzUrTnJsdkdYUnB4a1NTNWIzQWdtenZLMHVi?=
 =?utf-8?B?WHhIMVNBMkkvRmNxbHBjanYwdmFiS0g2VUx6SGFZLzRVdUtTZllkd2VaRXFo?=
 =?utf-8?B?UmdGYUlIaFFNcjlTYWs3WVNzNjhOeXllTzllNUpJUDBseDNkV2xYMktZbkgy?=
 =?utf-8?B?Yit6RkhmT05NMXQraWdoV3o0V0h5bnFzNUtPNWlHUXhRL3hnTGx4L3V3R2dI?=
 =?utf-8?B?ZDQ5TTdVT1lWbXBEdzNCb25ScmFNSVF5ci8zOTdFNENTWEtWNTdXckQxRlpC?=
 =?utf-8?B?NDBHZGNDY2tVbllqSm5vbXUveDhKaDMrM0QvcFRaY1pkSEhGbXpTRUJkNjJp?=
 =?utf-8?B?V2hkL1hjLytJQVZ0TUhZQ2ZMdWl6UDFHUGZlRUVtMGV1cTFKdmIrdXJkeWRC?=
 =?utf-8?B?MmkwQ0g5bkZhSVFzclBNdy9iUUVjemRWazVuelpGUmR4VytUNm1aQ1QzWE40?=
 =?utf-8?B?U012UnlSYUR3SUNwMEVrcWhWamFTM2tzSG0reldLbThwWHdKQ2tQZ2FvOEpV?=
 =?utf-8?B?QWxuNGNPM3l6aFJvMEZrY0V5ZjkzQ0VncS9hREI5Zm5ianR6Mm1kQ25QL2wv?=
 =?utf-8?B?dUsvTkZvVlZMQUViRnd1MVZWVE1id2lyRllLa1R0V3h4c0FZZ2hRVU9zZE1r?=
 =?utf-8?B?MDNkUXpwVUhtYWtMazNIaE5pU2Z1eVh6Y0RlWXJUNVFRNThoeWo0RzljeFc1?=
 =?utf-8?B?R0ZlWXpITFc1bmV3ZGYxbTJ4cDU4QzNHUjBCRVIyWmVaakFRTzZDdVFPdUdK?=
 =?utf-8?B?SzNNdjkxSkFGaTZFeDdpRnRCL3B0OXZ3MTBhRFVvTHVYOTl2YzJ6aFlDdnJl?=
 =?utf-8?B?UUxvMU9TWDdwNVVvdVh4eXQybUJZYU5pSlZmNk1Oek4veEVxcmZwcTN5MEVp?=
 =?utf-8?B?Z1F3dStLemlNekdqb3JRem5TTlY0Z01DVlZmRkMxQnV5dWRxbTBHSnJ5Yzla?=
 =?utf-8?B?SFRzdFFjcFBhTkh2WlM2blhwOHdRS3NkT1NmelEyOWxKQ0QxazYrbXYyemcw?=
 =?utf-8?B?Vng1LzZwc3lyNjZkU2Q3ZHJFdXNqWVNQeUEzMjhoVDRMTDJNblJnKzB6ZytC?=
 =?utf-8?B?R1VIeExZTjRrQkR5TkQxQXU0cTZWYWd3a0E4VVJUN043MHdaSUJoVGtaUmZF?=
 =?utf-8?B?TnhOdU15dnBwVVpVL2RJNUpNVXc3MnJ4V2tRT3Y0RXZaemRVQjcxUk1Uc1py?=
 =?utf-8?B?OFRkVjdYOUJwNjMvZEdUMDg0M1BhN2FzNXJTdUxaKy9BcHMvQ0dlN2Z3c094?=
 =?utf-8?B?M1pVYnRpL21nUW84Rnd1V3hMOVlaTHdqSmlkeDRSNmVMWU9aNWttVHJTNWdz?=
 =?utf-8?B?Y0dLTTVVM3UxTXZOYUFwQ0tpUlZaSnAwZzgwdFVTRXhzZFZTc1JpbWlvVHBQ?=
 =?utf-8?B?Zlc3WUo5ZmhyWmVWZUdaWXlMRzRpRm1uRnBDc3JacWlZb2tzdjJSYlUrZThk?=
 =?utf-8?B?NEpDUUdBK2duTk00RFROY1V3RThlL2wzREd5L21NTTFnZWRJMW5oZm4za0dR?=
 =?utf-8?B?azZnOWw1eWxZNnJQU3kvdWphQzI0aFNHZENsQjBXMExpNUZCdzBoSGFMTHJs?=
 =?utf-8?B?djUxQlN4YXpHODVPd0RFVzRmUlp5b004cmR4T2toTmVScWdKeDBZTUcvOUU5?=
 =?utf-8?B?VHkvU2RpWmVmWVJ6WUErWHhOYnZRRURTKzNmVkVXdVB0YnpXalF5QW5VajhF?=
 =?utf-8?B?bSs0UWpvWTBWN3dGZmFNdTl0QWFtT3R3K2NudFpDblpzSmtXUjlKejF2Ulg0?=
 =?utf-8?Q?mgGC6o?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUJ5UlV5Ung2UkQwbUtzS3ZKVldlYU5GMVI0cmMra3NUTHozQnlSMUY3VzRB?=
 =?utf-8?B?RmJHbFBOUGd1bVpvUmxUUjgzdTRZRGVrV0dETTZtSzhoY3VHcUJ6Rjkxc1dT?=
 =?utf-8?B?Vy8xdXBVdGt2Ui9UaEY1M1BYY0VzYnd3TU1tbmhpQzY1emQxRE5SUUMvTmNr?=
 =?utf-8?B?aVl5V1JwU1lhUnF3dm1DbzhkcjBjNHN3b0RtN3JiNkp3NG1LZzExK3NPWCt3?=
 =?utf-8?B?Y2lZYXBEVDU0ZGEyQnpvTkxYNitBQkpQMGllekw2VkdRU1JveEUzY1c0dzl1?=
 =?utf-8?B?SUoxcGJoNE5MT3gwcnJMSlRhVlIyRHpFdHpsUDBpTE5pdEJVZy9sNDFjMzZ3?=
 =?utf-8?B?RGFzU0JBM1Yra1YxSWZUMUdwei9lRDY4cXVnVHZPdnFkZ29SSW9qRXFrTFRI?=
 =?utf-8?B?dEJGUHBGRTFKeFFwNHFuNE9KSkpKazU2SHptK0ZXMGQrVjM0RmVnaEFTaldH?=
 =?utf-8?B?cGxHZ3hxWkhmNVdQOHdkQjBqSDZTL1ZBQUdicU5HK08xN1NROVNNL1BRVGly?=
 =?utf-8?B?dXlYQ0JGdDBhSHR0THFEbGE0M05jMVhGY3BlWU5JQ1JKQks2djJGTkFWS3c0?=
 =?utf-8?B?Y0ltZzZKNktvcmtQYUlERk53TWJVbDNadGRFY1YrMDZiYjBMZC9zNk9ta1pB?=
 =?utf-8?B?RVdDbGN4aUZQdDc1dmRKaHp1K2wwaktHMFgvRUgrYjhlVUlZZ1lhN1FzTnNu?=
 =?utf-8?B?bi9vcElweUp1ZFNiTGZpc1UyVmo3UVJ2Q0pkRlhJSWMzY0svWENRSWdINHZR?=
 =?utf-8?B?WXFvbWw2U1k0czA2eVdkTWFrRnRMRTZZUWtBV0tNbXg4SWRrWk8vQ1kzQXk2?=
 =?utf-8?B?cCs2ekk2ejBRZFRxYW1oUUE5WU1aRG1WdXdqSnVrL0VUWldibS9hVUYvK2Z6?=
 =?utf-8?B?RDZWdnJoaEJWWEpaOUpxVDZXSXp4bHBjd1c0aWVLZVdyTzd4UXlSODkzY3Vy?=
 =?utf-8?B?RXlRT3dlMlBaeGdidEVWZElJc0Z2TVF5RXl3SkE2QlJoM2tPK3Q4eFVTSG5h?=
 =?utf-8?B?MFNBTWlrbDJjdU1hTWRiSHVleTJ4V3R2Si9Hem1YNzh0MVlja2FtR1FNdHlR?=
 =?utf-8?B?eWhRZHAzSHB1eFdMeGhPL1BmK1EyMzVqVm8wVnFUOW5uVjZnOGF1UFd1c0pF?=
 =?utf-8?B?aGhUMTJrWGhVc1M1QTJqYVJveHZlNUNtMDZTblBJM2NNWjcxTmJGUHY2RUdv?=
 =?utf-8?B?SW9Oai9qdGpTK2M3aTB4VTJqdWxqMXlLcU9BdVU5SmJUMHQrWHlBb0E1S0lR?=
 =?utf-8?B?Wk9LQ3RnY0dlZHFaMm9iSy9RK2Q1cTNSd1VIV0E0dm1RME8vSGNoSDZRRWhC?=
 =?utf-8?B?V3VMUCtZUy9CRXY5bmppTC9LZnBoOHFZVmh5ZmtMdnNwNE5wZ3pMSXlFUHJI?=
 =?utf-8?B?NmFzMEhCb1pGb0FrNEtNUEE0UlduLy80a1lDbUxWQzZSaUg1cXJjQS9VbExS?=
 =?utf-8?B?cFZleVRSMmYyU3lYeHlpVUtrRG13b2xBYkd5NDB5STk3NUE4czNFaWZDZU8r?=
 =?utf-8?B?UmNuRUs1S2hWcE45bWQxTnAvYm80NmF4NjJLeFV4WWxMRFJFczlhenU3dDdE?=
 =?utf-8?B?WGV3eGNpSVd2bHJPbUh2N3VGMzZWd3NZMTIwakh5WjYzTGZzWFpDUVljVDls?=
 =?utf-8?B?bUVQT09xMk5pL0V1aUw5OURRWEpXcG44NmZ2ejhEck54emdPdUdaemxoZ2x6?=
 =?utf-8?B?UUk1dDRCWklOMmw5NHFaWDc4TXJpVTExK2dJZ1VjV24ydHhkUklZMTloeTlH?=
 =?utf-8?B?djlhWFAvQzNsNTg1RFprOTdBZWc5d3VXck1UTCtNZVNwelhVTFBLWVV6RkJ0?=
 =?utf-8?B?a1JGaDFOMVFSZ2FJMk1ET2MvWmpxK1VObmZJVUozM3dVUXlqb1NiR0VMdk5P?=
 =?utf-8?B?TnN4cGRzV3h1RzZySmZlb2lKNjRqWjJSS2lZSG5aS0JXYWROdEg2dmM0VVRI?=
 =?utf-8?B?L1VtTXlhOGRIdXZjdDVwd25KOXVYVmFyT1preWdxSDRVVkljL1JvVzVBajBW?=
 =?utf-8?B?S0xiQ2tPbGpUNHU0WmhPSjZZWWpTTEpGTmRNeitMdS81TENkLzJaR015WllG?=
 =?utf-8?B?N1NQczM3NnRadXBBRW1tb0NtK1JMc2Z3VklXaTJ5d0lwMTRaNjlBZFZQK2ZM?=
 =?utf-8?Q?eBQQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a598637c-0df3-448b-fc1d-08de271f22ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 03:53:01.6122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oz0nYqa/jCnjuw4x2ZL7N6QpEmIo1fHxe4EVbq1kLdS567F1lPKwp1alhwZpOkjn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745
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
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRl
dWNoZXJAZ21haWwuY29tPg0KU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxOSwgMjAyNSAxMTo0
NiBBTQ0KVG86IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQuY29tPg0KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywgSGF3a2luZyA8SGF3a2luZy5a
aGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgTGksIENhbmRpY2UgPENhbmRpY2UuTGlAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGRybS9hbWQvcG06IGZpeCBhbWRncHVfaXJxIGVuYWJsZWQgY291bnRlciB1bmJhbGFuY2Vk
IG9uIHNtdSB2MTEuMA0KDQpPbiBUdWUsIE5vdiAxOCwgMjAyNSBhdCA5OjU54oCvUE0gWWFuZyBX
YW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPiB3cm90ZToNCj4NCj4gZml4IGFtZGdwdV9pcnEg
ZW5hYmxlZCBjb3VudGVyIHVuYmFsYW5jZWQgaXNzdWUgb24gc211X3YxMV8wX2Rpc2FibGVfdGhl
cm1hbF9hbGVydC4NCj4NCj4gWyAgMzU3Ljc3MzE0NF0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBd
LS0tLS0tLS0tLS0tIFsgIDM1Ny43NzMxNTZdDQo+IFdBUk5JTkc6IENQVTogMjEgUElEOiAyMjAy
IGF0DQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pcnEuYzo2MzkgYW1kZ3B1
X2lycV9wdXQrMHhkOC8weGYwIFthbWRncHVdIC4uLg0KPiBbICAzNTcuNzc0NjUxXSBUYWludGVk
OiBbRV09VU5TSUdORURfTU9EVUxFIFsgIDM1Ny43NzQ2NTZdIEhhcmR3YXJlDQo+IG5hbWU6IEdJ
R0FCWVRFIE1aMDEtQ0UwLTAwL01aMDEtQ0UwLTAwLCBCSU9TIEYxNGEgMDgvMTQvMjAyMCBbDQo+
IDM1Ny43NzQ2NjRdIFJJUDogMDAxMDphbWRncHVfaXJxX3B1dCsweGQ4LzB4ZjAgW2FtZGdwdV0g
WyAgMzU3Ljc3NTU2M10NCj4gQ29kZTogMzEgZjYgMzEgZmYgZTkgZjkgYzMgNGYgY2IgNDQgODkg
ZjIgNGMgODkgZTYgNGMgODkgZWYgZTggZGIgZmMNCj4gZmYgZmYgNWIgNDEgNWMgNDEgNWQgNDEg
NWUgNWQgMzEgZDIgMzEgZjYgMzEgZmYgZTkgZDggYzMgNGYgY2IgPDBmPiAwYg0KPiBlYiBjMyBi
OCBmZSBmZiBmZiBmZiBlYiA5NyBlOSBkMyA4ZCA4YiAwMCAwZiAxZiA4NCAwMCAwMCAwMCBbDQo+
IDM1Ny43NzU1NzNdIFJTUDogMDAxODpmZmZmZDI4NjE2ZWNiYTU4IEVGTEFHUzogMDAwMTAyNDYg
WyAgMzU3Ljc3NTU4NF0NCj4gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAwMDAwMDAw
MDAwMSBSQ1g6IDAwMDAwMDAwMDAwMDAwMDAgWw0KPiAzNTcuNzc1NTkyXSBSRFg6IDAwMDAwMDAw
MDAwMDAwMDAgUlNJOiAwMDAwMDAwMDAwMDAwMDAwIFJESToNCj4gMDAwMDAwMDAwMDAwMDAwMCBb
ICAzNTcuNzc1NTk4XSBSQlA6IGZmZmZkMjg2MTZlY2JhNzggUjA4Og0KPiAwMDAwMDAwMDAwMDAw
MDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMCBbICAzNTcuNzc1NjA1XSBSMTA6DQo+IDAwMDAwMDAw
MDAwMDAwMDAgUjExOiAwMDAwMDAwMDAwMDAwMDAwIFIxMjogZmZmZjhhYWMyMDFhODAwOCBbDQo+
IDM1Ny43NzU2MTFdIFIxMzogZmZmZjhhYWMwZTYwMDAwMCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDAg
UjE1Og0KPiBmZmZmOGFhYzIwMWE4MDAwIFsgIDM1Ny43NzU2MThdIEZTOiAgMDAwMDc1MWM2OTdi
N2M0MCgwMDAwKSBHUzpmZmZmOGFjYjRmYmEyMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAw
MDAgWyAgMzU3Ljc3NTYyN10gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAw
MDA4MDA1MDAzMyBbICAzNTcuNzc1NjM0XSBDUjI6IDAwMDA1YTg0NGE1ZTcwMjggQ1IzOiAwMDAw
MDAxMDM5YTBmMDAwIENSNDogMDAwMDAwMDAwMDM1MDZmMCBbICAzNTcuNzc1NjQyXSBDYWxsIFRy
YWNlOg0KPiBbICAzNTcuNzc1NjQ5XSAgPFRBU0s+DQo+IFsgIDM1Ny43NzU2NjNdICBzbXVfdjEx
XzBfZGlzYWJsZV90aGVybWFsX2FsZXJ0KzB4MTcvMHgzMCBbYW1kZ3B1XSBbDQo+IDM1Ny43NzY3
MDRdICBzbXVfc21jX2h3X2NsZWFudXArMHg3OS8weDUwMCBbYW1kZ3B1XSBbICAzNTcuNzc3ODU3
XQ0KPiBzbXVfaHdfZmluaSsweDEzOS8weDIwMCBbYW1kZ3B1XSBbICAzNTcuNzc4OTA4XQ0KPiBh
bWRncHVfaXBfYmxvY2tfaHdfZmluaSsweDI5LzB4YzAgW2FtZGdwdV0gWyAgMzU3Ljc3OTY5OF0N
Cj4gYW1kZ3B1X2RldmljZV9maW5pX2h3KzB4MmU1LzB4NTYwIFthbWRncHVdIFsgIDM1Ny43ODA0
ODddICA/DQo+IGJsb2NraW5nX25vdGlmaWVyX2NoYWluX3VucmVnaXN0ZXIrMHgzZS8weDcwDQo+
IFsgIDM1Ny43ODA1MTFdICBhbWRncHVfZHJpdmVyX3VubG9hZF9rbXMrMHg0Yi8weDcwIFthbWRn
cHVdIFsNCj4gMzU3Ljc4MTMzNF0gIGFtZGdwdV9wY2lfcmVtb3ZlKzB4NTAvMHg5MCBbYW1kZ3B1
XSBbICAzNTcuNzgyMTI2XQ0KPiBwY2lfZGV2aWNlX3JlbW92ZSsweDQxLzB4YzAgWyAgMzU3Ljc4
MjE0NV0gIGRldmljZV9yZW1vdmUrMHg0Ni8weDgwIFsNCj4gMzU3Ljc4MjE1OV0gIGRldmljZV9y
ZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCsweDIwMy8weDI3MA0KPiBbICAzNTcuNzgyMTY5XSAgPyBz
cnNvX3JldHVybl90aHVuaysweDUvMHg1ZiBbICAzNTcuNzgyMTg5XQ0KPiBkcml2ZXJfZGV0YWNo
KzB4NGEvMHhhMCBbICAzNTcuNzgyMjAxXSAgYnVzX3JlbW92ZV9kcml2ZXIrMHg4My8weDExMCBb
DQo+IDM1Ny43ODIyMTZdICBkcml2ZXJfdW5yZWdpc3RlcisweDMxLzB4NjAgWyAgMzU3Ljc4MjIy
N10NCj4gcGNpX3VucmVnaXN0ZXJfZHJpdmVyKzB4NDAvMHg5MCBbICAzNTcuNzgyMjQ0XSAgYW1k
Z3B1X2V4aXQrMHgxNS8weDNiDQo+IFthbWRncHVdDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFlhbmcg
V2FuZyA8a2V2aW55YW5nLndhbmdAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3N3c211L3NtdTExL3NtdV92MTFfMC5jIHwgNyArKysrKystDQo+ICAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3NtdV92MTFfMC5jDQo+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9zbXVfdjExXzAuYw0KPiBpbmRleCA3OGU0MTg2
ZDA2Y2MuLjI0ZDlmNTc2ODQ2YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9zd3NtdS9zbXUxMS9zbXVfdjExXzAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L3NtdTExL3NtdV92MTFfMC5jDQo+IEBAIC0xMDIyLDcgKzEwMjIsMTIgQEAgaW50IHNt
dV92MTFfMF9lbmFibGVfdGhlcm1hbF9hbGVydChzdHJ1Y3QNCj4gc211X2NvbnRleHQgKnNtdSkN
Cj4NCj4gIGludCBzbXVfdjExXzBfZGlzYWJsZV90aGVybWFsX2FsZXJ0KHN0cnVjdCBzbXVfY29u
dGV4dCAqc211KSAgew0KPiAtICAgICAgIHJldHVybiBhbWRncHVfaXJxX3B1dChzbXUtPmFkZXYs
ICZzbXUtPmlycV9zb3VyY2UsIDApOw0KPiArICAgICAgIGludCByZXQgPSAwOw0KPiArDQo+ICsg
ICAgICAgaWYgKHNtdS0+c211X3RhYmxlLnRoZXJtYWxfY29udHJvbGxlcl90eXBlKQ0KPiArICAg
ICAgICAgICAgICAgcmV0ID0gYW1kZ3B1X2lycV9nZXQoc211LT5hZGV2LCAmc211LT5pcnFfc291
cmNlLCAwKTsNCg0KU2hvdWxkbid0IHRoaXMgYmUgYW1kZ3B1X2lycV9wdXQoKT8gIFdpdGggdGhh
dCBmaXhlZCwNClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+DQoNCltrZXZpbl06DQoNClllcywgdGhhbmtzLCBteSBtaXN0YWtlLCBmb3JnZXQgdG8g
c3luYyBsb2NhbCBjaGFuZ2VzIHRvIHBhdGNoIGZpbGUgYmVmb3JlIHNlbmRpbmcgb3V0IHJldmll
dywgd2lsbCBmaXggaXQgYmVmb3JlIHN1Ym1pdHRpbmcuDQoNCkJlc3QgUmVnYXJkcywNCktldmlu
DQoNCj4gKw0KPiArICAgICAgIHJldHVybiByZXQ7DQo+ICB9DQo+DQo+ICBzdGF0aWMgdWludDE2
X3QgY29udmVydF90b192ZGRjKHVpbnQ4X3QgdmlkKQ0KPiAtLQ0KPiAyLjM0LjENCj4NCg==
