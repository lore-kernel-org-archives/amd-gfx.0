Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A29EC25B7E
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 06:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4342C10E42A;
	Tue,  4 Jun 2024 06:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZORpO9qV";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92B5F10E42A
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 06:52:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+UjuR4YXqCBy14ZdIZUSPcxSoIeIMLrVAut84R2LLDEkQVmhSqdQvRIACaPehPKqg+JuDHvmqRda6TBftLyqcqofoGYsztMJQwjgvUn9cA/1Fex3l1gbrrCPT/TIYs01q6qXxxOW+cl543v6hBvHWvbclHtTlION9y00sUoFWNeHWbqRXGR7bbjf5PUGeBdtnN9bEZFNFchQcdqJ7CL1kCSP9d3bd124TcVlnEGYZphh1W3piNqLgippyRTaNjYo0MighNcj++wf4lj/m0x6Nln9su2PKCEFfl0f3AG8BcuAT0uNXSuiBLDJ3TnadjTjTLQ2bLYXbfn6zjJcBkCRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAaWxO1Oij5GoK373JEe254da5gThWYxqYZDbivtMJc=;
 b=TBq/OPLyj7rMCmH7TA/c7dUDGkbmgaZwb1XgJ2q02G9fAg2mneRrpHouww8ZAqoxLDWsxPf3tHYcuVz/mAk4hrlx/oRPv6NHuTnzZpCyB5lixDpBWzF252HpXA+R3dtZrWxvwY01qCJYMl76tjYvLqrWH2kP34anZdgzxMdi9JsKPu0uCzZhU7GnwEXcFSQKNdXm1zhdmI2iQOWwG1oJCnZ6rDdTTpBGJ1rxJ4pC2bJbfjWZgNs32o9XqiI3Ug+/GMOzh2Bccrd9E5bVKoA+he1AFfeipeRLfl1WQsHJBvYFkaiJqywp/8SYkqWJNdeHlJN0UgbOzRJDxAFouJVrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAaWxO1Oij5GoK373JEe254da5gThWYxqYZDbivtMJc=;
 b=ZORpO9qV2hJO7MHIdCURAwBm8Br9Gw2IKAiUjtjjd119Q+KHVAnDYQJmDk5QdmNB3BTRQi2QZlCbzbVCFZ4bV4jGHN5xogCDT6AJ9cCmLRabEcZhJKy5NiRXPkX0FaUkNq/pqK2xNJw4p+D6RU/NnyWrh2jhPWs3JOy0yzdCWy0=
Received: from PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 06:52:11 +0000
Received: from PH0PR12MB5402.namprd12.prod.outlook.com
 ([fe80::4b6a:bc87:9417:b30c]) by PH0PR12MB5402.namprd12.prod.outlook.com
 ([fe80::4b6a:bc87:9417:b30c%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 06:52:11 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Huang, Tim"
 <Tim.Huang@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: replace int with unsigned int for imu_v12_0.c
Thread-Topic: [PATCH] drm/amdgpu: replace int with unsigned int for imu_v12_0.c
Thread-Index: AQHatXszvdNW9bsNjUaleNKtw9bdv7G1rB0AgAAO8KCAACdfgIABBKvA
Date: Tue, 4 Jun 2024 06:52:10 +0000
Message-ID: <PH0PR12MB5402B2364C9D2F5095CBE0E894F82@PH0PR12MB5402.namprd12.prod.outlook.com>
References: <20240603055925.353172-1-bob.zhou@amd.com>
 <643687ee-4f93-4448-8d09-c841e1ce2746@amd.com>
 <CO6PR12MB5394B8D4CCD80B551FFE43EA94FF2@CO6PR12MB5394.namprd12.prod.outlook.com>
 <faa146e9-c2cb-4831-af0a-539dac51d912@amd.com>
In-Reply-To: <faa146e9-c2cb-4831-af0a-539dac51d912@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5f9a48c3-e5da-4a48-b6aa-cc938407c8e3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-04T02:43:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5402:EE_|CYYPR12MB8869:EE_
x-ms-office365-filtering-correlation-id: 2f56a088-f68a-4b65-cf86-08dc8462dbec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?UU4vK0ZxSVpES2dGQlpIUUFzd3lTL2x3UVJzd2JzcDBYTmNnZzNCMVpQNTlj?=
 =?utf-8?B?UHYyMGZIV2dtVi95aWNmZDIzZ0xYdXUrOVlhWFFoeU9tNUk2aTNQNkpIQ0tU?=
 =?utf-8?B?dmRqMFZ6TFUyS2h1NVVhSjZYd3BGdnJjNHZYZFJlN1hKSGpsREJYYUVLRDF0?=
 =?utf-8?B?WFhMVGw1anBMVE9tMGVGeWFXL2oxODEza21uN0ozUThpY2tiU29JSEpUaUtB?=
 =?utf-8?B?cjZQZSttd0NRSytMR0xWREJVQWh5NmY2SmpMV1JJMGl4ekpjREg2bUZleEZP?=
 =?utf-8?B?N2JBa2xEZEJSTm1Dc0ZJbE1lZEZVMDdGZm92dHZtT3dCSmNRNkVDMjF6U3Bo?=
 =?utf-8?B?Y0J5eVpZWnhNKzE3SCthQS93V1ZqeU9lNkg2aHNxZ3BNTi9heW9BOThraVJi?=
 =?utf-8?B?WlFCSzRIdjRKRjZiUFpvckhyMUYwWHE1T2svNlk0c204ZHMvRVR6ZlVKL2RY?=
 =?utf-8?B?VEFrSUpnelRhVFRROE9PM1pQSDJYNnJ6bFl3ZFR3b1dNTk1SMlVuYW03NkJo?=
 =?utf-8?B?Z1QwVHNjV3ZmUjFYTDYrS3VMRjM2M0xmNzY3ZXZvWVMzaXhLTFRoQnl6K3pQ?=
 =?utf-8?B?RjliZ2pUN3RyUXVmVkFSOUx2WTBDbFhlKzRJa2pKVEFaM3AwRng1Vm04ZmRK?=
 =?utf-8?B?VFhDNzRzSE1YVTdFNWYybzhGZ1pvVklXQzBXSkFFRFJBTk5hc2lVQ3dnYXFM?=
 =?utf-8?B?YWVuVGR2N2hBSk43VjBrZllYKys3c0EvZWNMUUVLMWhpUjAycjFQNVFCNHhT?=
 =?utf-8?B?SjMzVEFiWHlMdm11NWR3SllxL1NzZzlFMktSU21ZcVVjZTVlTk9JdGtXako1?=
 =?utf-8?B?bm92WEc3QTlmQzhUZXRHbUMvRWVvTnJXWmYvcDdodUNIeXlCZnRldlBtVHE0?=
 =?utf-8?B?b0J6ellxU29JcUFnYktqZXR5V1F6aEkzdUc3anlHRDRqZHRrS3ZjSm8wMWhr?=
 =?utf-8?B?T0l6TzhWWG9vZ2hjY2RrbCtQU2N5bzhkZTFkb1RKNStyNFlab2pCNDBrL1FI?=
 =?utf-8?B?NkVHYkFVUEhNYnk3cWw3ZUp1dW9Dd2hra2hiT09RT01LOTZlUDIzK3h6MmJo?=
 =?utf-8?B?eGtnNzFQRkJKUnlVamU3TGNTbnlDa0o1Qk94UTRBbXBIWGZHekMzWVhlQzR5?=
 =?utf-8?B?bmFWcU5PM1VvS014Q0g0UWpCYm9mQTdXdTIzM003cXN1L0N1OUVWVkdFOXRK?=
 =?utf-8?B?MEhlV3BuQlhNZHBwNmZkNzlPVUZlZlRFUkhNSzdwMzBzY05vejhZMGx1NkxB?=
 =?utf-8?B?Tk90bitXemRsc3NBZnZzKzVTTHFFVGd2MTQzTW5EQ1VyTTlDakJSOWhucU1l?=
 =?utf-8?B?cG83YS9SaWNYMElGeU95MlFjR2YzWW5WTjRqYkhmTlhrV1phcGozWTBHU01w?=
 =?utf-8?B?T2kxZHNOVFRWcStsMEg0NG91TjJvQnFGemtId1VGQVI3dVh1d0pYT2pySFRL?=
 =?utf-8?B?RXBuYW10Q3RoeDk4akFTRVZqdHV6ekx2TzJyanhrUnFmK3hNVFg4cU1OaUtP?=
 =?utf-8?B?WUJDdjNzL1JmQXpRbG8rRFhFT0RkeFVYNm5JOWo4Zmk4L29US1llSy9iazk0?=
 =?utf-8?B?Y0I5M2VTRmZEVjJodWtnek8xeWppMDBtOHBKU2lhTjY5bUxIaVRzTlJHSE5y?=
 =?utf-8?B?OWRIbVMxTUN2Mm8vSGV6MEpjK1VJVmkrMHFnSmY2SGoxaFdMQzJzZGVUcldv?=
 =?utf-8?B?MFR6dWc3MWJLRmE4UjRVQXMvTElzbkNIYzUwK2dTdVVEMGFWV1UwYmo0eDNF?=
 =?utf-8?B?NlBEd2ZzS1ZhN0dUUDJXYkYwKzhwR1l5Z2dCSTRicTdQNlpDZ1Brd1JBSE4w?=
 =?utf-8?B?SkVDSTZkYmRQRThRRjZwUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5402.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHh4Mmg2UjJTSlhjZ0p6N2M4R1ZmVE5NNlRZbTRIV1BnTFNod1MySUpBbmhR?=
 =?utf-8?B?TEw3UWhmOFdNVjRPVWd4Y3hSM2hCbHovbU9CZEw2KzNMQU9QUC9sK3BuM0lJ?=
 =?utf-8?B?YlJvKzNLbTVLb3MyUXZVNFUxMGo5R2IrZ09xYVZicGI2cHh0dlIwWDd6dGJh?=
 =?utf-8?B?b3E2aHd3WjFkUHNNRWZsN3BoOHlxWFdLYU5VZGhJTDZpVlFIZmY2QWVsemJU?=
 =?utf-8?B?NGN4aHpMRUlTYkQxNTJERStKWjVST0RPQlpQN2UvVzBSUVEzT1RYS0lKYU11?=
 =?utf-8?B?QlFOd3pKakIwODNud2k0SHN2VnB6TlRkVFA4QnpqQldGNi9oNy9KSnVsSVk4?=
 =?utf-8?B?RlFtOEhGQWdFT1lBTTJnWWZXTlkxdHRWMjdnZTR6MVIwN1Q2ZzdmR0RCWXpF?=
 =?utf-8?B?VE9SaFl0OUJ5QkR5YzViTDQ1UFdiRTUybzBHSXUrVHdBMHFKTks3cE1ZVHVU?=
 =?utf-8?B?SlU2TEZWWjhzNEhUSFNBNHJKQXA5U1JlWUxDdDNWb1l4TW5HL2NPaUQrQjJr?=
 =?utf-8?B?dERKai9xSmZHRFhDQjZaV1FIcXc0U3g1aXVoUURGVndvQlQvVXdDM2pibVJq?=
 =?utf-8?B?dXduVklXNy9MK2k1bmFnaENBejhMMjIrVFBEeUl6MGhUa2FYRVZVYmQzUWlB?=
 =?utf-8?B?WktDWUtJamZDSjlTOFZLdERQK2Z5ZHI3a1hiSDJRbWZQM1d3NFcvNFJMUm9o?=
 =?utf-8?B?NVgxMTd4eVR2eUUycVQzVmlaUFFxWFJCd1pLb3QySEFyOXp6QksxMEI2Tkp4?=
 =?utf-8?B?Z05rQVVyTlJaRWE5b1B6dXJMZzRKWVVUT1VueU1naDB4NWwwdkg3RzVhN3lm?=
 =?utf-8?B?L1lmS3ovbzZFK2tTWXhTRW1wamkrR3JYdkhwZSt0Nm9Dbm9OeFkwQ0JRVG1a?=
 =?utf-8?B?dTl0dVZzMis5WkdYSDVDK2hXU1I0c3kxaE5oNVNVRllibDV0ZjdIVW9vaEFq?=
 =?utf-8?B?TTB0WCtIMTVuM1NLSW9YcWhRTnVGMk1mWEJRR2dPMVFLMFB2bFR1Qm80NmFm?=
 =?utf-8?B?K2RaNXFUd0EycGYrTnZTLzhMOVhOYnJlOXRlT0Y2SmUwWWkydktKdEcxTXpL?=
 =?utf-8?B?K3VzV0VFek5zMGtkdnpPcVQ3Vjgzd3JXM01xQVRMdTl3RnpiallveVJ3akFV?=
 =?utf-8?B?cFVOVUxLRVNRNUx3ZnJqT2FScWhucjg3TlhIOVdkdXk0ZFVZdlNoZ3Rqb1ps?=
 =?utf-8?B?RjJybmxtRllNMDdheGRPY1dnUWtVVytCZlBGUm1mL2xlZWhjSWNTRWx6RW8x?=
 =?utf-8?B?dlRvdnphRzc5RTI3UWRBWGNRK3VjRmRQZ0NTMGRmVEs0Q2dTeXMrNEFoWHBE?=
 =?utf-8?B?UldGaVNTSW5NMmIyYkgrZDRtM09MeTdJM2FtWGtWTFhlZjJDY2NiQXV1S2Nr?=
 =?utf-8?B?aFh0TlJFU3NiTmNWZFZndzRHajJhWXZNNk5VN05qdnUvZG1hYktaVEFDbUpy?=
 =?utf-8?B?R3kxRWhqQlh1RHJ5Y0pzRk82VC9tMjRuYkl1cE1TbTdLZEFJRmFJVXVSSVpW?=
 =?utf-8?B?S00rb2RkTHV3QTFkRE5obUhmOGYvTFgwT1h5RFlVRE0wZkYwOS8rVmxYaTRv?=
 =?utf-8?B?TENCY3BJejBBcTlFa3BIdURFVnFldE1YYnVmNi9ZbzRUek5ObkFjekhGeTFD?=
 =?utf-8?B?YXFydUY5SzlMSG42SklrNFdMU1pwb2ZRRFU0T3RmODBuVktHWjJEUXJLZjZ2?=
 =?utf-8?B?d0NCNkJua3BaZnJ3M1VDbDhJYWJhL0xOWjFLbVU3eVJSWlc1akNlejBsK3RC?=
 =?utf-8?B?eDc4NTdSY1Q1OEE0YkpIN0VRY2U4SkpQR1ZxSHRTYUhJcjFXYm9PeHI1MzBB?=
 =?utf-8?B?OFhuV0h1ZmFmcmtMN1dJY0VMTHYzeVNjQ3JBTVdvRXZsc0ozcjVvMnl5SmJY?=
 =?utf-8?B?R1QzTWFQNjM1cTZFQS9PWU9ScGEzWTRmcU95Nko4ZENwZjBRYnZIb0VVU1JV?=
 =?utf-8?B?N01UYVVDcEh0eDRObncrYXhiNTVuODRNT2hNbWVncGFMVTVESzBXMEFwSFR4?=
 =?utf-8?B?UXdhSkZ6L1hCRitnSkdhZEZLUFRqYmVPZXZaNlUvT1Rsd0c2RWJ4UUh1NDZ6?=
 =?utf-8?B?ZnNEREZtbEN5a2JrdFpnTTluZ3RhaFpBQ1J0NTUvdXhvT1dqUS96NmhzZFdP?=
 =?utf-8?Q?ncMg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5402.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f56a088-f68a-4b65-cf86-08dc8462dbec
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 06:52:11.0978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JuVP7WA66xSea0XZhVF/wbSh590/gxlZH8R/ziQKz98+66zX7qYohfZxRe3hz5+xQ/oM2C/5ZpYAZEigtK5dhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
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
Cg0KSGkgQ2hyaXN0aWFuLA0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMsIHRoZSBSUkVHMzJf
U09DMTUoKSBtYWNybyBzaG91bGQgcmV0dXJuIHRoZSAzMmJpdCB3aWRlIHZhbHVlIHNvIGl0IGNv
dWxkbid0IG5lZWQgdGhlIG1hc2suDQpBbmQgSSB3aWxsIHNlbmQgb3V0IHYyIHBhdGNoIHRvIG1v
ZGlmeSB0aGUgY29tbWl0IG1lc3NhZ2UgYW5kIHVzZSB1aW50MzJfdCBvciB1MzIgaW5zdGVhZCAu
DQoNClJlZ2FyZHMsDQpCb2INCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtv
ZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTZW50OiAyMDI05bm0
NuaciDPml6UgMTk6MTENClRvOiBaaG91LCBCb2IgPEJvYi5aaG91QGFtZC5jb20+OyBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgSHVhbmcsIFRpbSA8VGltLkh1YW5nQGFtZC5jb20+OyBa
aGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCkNjOiBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1kZ3B1OiByZXBsYWNlIGludCB3aXRoIHVuc2lnbmVkIGludCBmb3IgaW11X3YxMl8wLmMN
Cg0KQW0gMDMuMDYuMjQgdW0gMTA6NTMgc2NocmllYiBaaG91LCBCb2I6DQo+IFtBTUQgT2ZmaWNp
YWwgVXNlIE9ubHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQo+DQo+IEhpIENo
cmlzdGlhbiwNCj4NCj4gSXQgZml4ZXMgYSBwb3RlbnRpYWwgT3ZlcmZsb3dlZCBjb25zdGFudCAo
SU5URUdFUl9PVkVSRkxPVykgd2FybmluZyByZXBvcnRlZCBieSBDb3Zlcml0eS4NCg0KWW91IG5l
ZWQgdG8gbWVudGlvbiB0aGF0IGluIHRoZSBjb21taXQgbWVzc2FnZS4NCg0KQW5kIEkgaGF2ZW4n
dCBjaGVja2VkIHRoZSBoYXJkd2FyZSBkb2NzLCBidXQgaXQgY2FuIGJlIHRoYXQgdGhpcyBpc24n
dCB0aGUgcmlnaHQgc29sdXRpb24gZm9yIHRoZSB3YXJuaW5nLiBJbnN0ZWFkIHlvdSBzaG91bGQg
cHJvYmFibHkgdXNlIHRoZQ0KUlJFRzMyX1NPQzE1KCkgbWFjcm8gd2l0aCBhIG1hc2sgd2hpY2gg
b25seSBsZWF2ZXMgdGhlIHZhbGlkIGJpdHMgYXJvdW5kLg0KDQpPbmx5IHdoZW4gdGhlIHJlZ2lz
dGVyIGlzIHJlYWxseSAzMmJpdCB3aWRlIHlvdSBuZWVkIGFuIHVuc2lnbmVkIGRhdGF0eXBlIGFu
ZCBpZiB0aGF0IGlzIHRoZSBjYXNlIEkgc3VnZ2VzdCB0byB1c2UgZWl0aGVyIHVpbnQzMl90IG9y
IHUzMiBpbnN0ZWFkLg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+DQo+IFJlZ2FyZHMsDQo+
IEJvYg0KPg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENo
cmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiAyMDI05bm0NuaciDPm
l6UgMTU6NTYNCj4gVG86IFpob3UsIEJvYiA8Qm9iLlpob3VAYW1kLmNvbT47IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBIdWFuZywgVGltIDxUaW0uSHVhbmdAYW1kLmNvbT47IFpo
YW5nLCBKZXNzZShKaWUpDQo+IDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0KPiBDYzogRGV1Y2hlciwg
QWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBkcm0vYW1kZ3B1OiByZXBsYWNlIGludCB3aXRoIHVuc2lnbmVkIGludCBmb3INCj4gaW11
X3YxMl8wLmMNCj4NCj4gQW0gMDMuMDYuMjQgdW0gMDc6NTkgc2NocmllYiBCb2IgWmhvdToNCj4+
IFRoZSByZXR1cm4gdmFsdWUgb2YgUlJFRzMyX1NPQzE1IGlzIHVuc2lnbmVkIGludCwgc28gbW9k
aWZ5IHZhcmlhYmxlIHRvIHVuc2lnbmVkLg0KPiBBbmQgd2h5IGlzIHRoYXQgYW4gaW1wcm92ZW1l
bnQ/DQo+DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4+IFNpZ25lZC1vZmYtYnk6IEJv
YiBaaG91IDxib2IuemhvdUBhbWQuY29tPg0KPj4gLS0tDQo+PiAgICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9pbXVfdjEyXzAuYyB8IDYgKysrLS0tDQo+PiAgICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pbXVfdjEyXzAuYw0KPj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9pbXVfdjEyXzAuYw0KPj4gaW5kZXggMGM4ZWY5MDhkMTEyLi4yZDZmNzU0OWMy
YWYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pbXVfdjEyXzAu
Yw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaW11X3YxMl8wLmMNCj4+IEBA
IC0xMTksNyArMTE5LDcgQEAgc3RhdGljIGludCBpbXVfdjEyXzBfbG9hZF9taWNyb2NvZGUoc3Ry
dWN0DQo+PiBhbWRncHVfZGV2aWNlICphZGV2KQ0KPj4NCj4+ICAgIHN0YXRpYyBpbnQgaW11X3Yx
Ml8wX3dhaXRfZm9yX3Jlc2V0X3N0YXR1cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+
ICAgIHsNCj4+IC0gICAgIGludCBpLCBpbXVfcmVnX3ZhbCA9IDA7DQo+PiArICAgICB1bnNpZ25l
ZCBpbnQgaSwgaW11X3JlZ192YWwgPSAwOw0KPj4NCj4+ICAgICAgICBmb3IgKGkgPSAwOyBpIDwg
YWRldi0+dXNlY190aW1lb3V0OyBpKyspIHsNCj4+ICAgICAgICAgICAgICAgIGltdV9yZWdfdmFs
ID0gUlJFRzMyX1NPQzE1KEdDLCAwLA0KPj4gcmVnR0ZYX0lNVV9HRlhfUkVTRVRfQ1RSTCk7IEBA
DQo+PiAtMTM4LDcgKzEzOCw3IEBAIHN0YXRpYyBpbnQgaW11X3YxMl8wX3dhaXRfZm9yX3Jlc2V0
X3N0YXR1cyhzdHJ1Y3QNCj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+Pg0KPj4gICAgc3RhdGlj
IHZvaWQgaW11X3YxMl8wX3NldHVwKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPj4gICAg
ew0KPj4gLSAgICAgaW50IGltdV9yZWdfdmFsOw0KPj4gKyAgICAgdW5zaWduZWQgaW50IGltdV9y
ZWdfdmFsOw0KPj4NCj4+ICAgICAgICBXUkVHMzJfU09DMTUoR0MsIDAsIHJlZ0dGWF9JTVVfQzJQ
TVNHX0FDQ0VTU19DVFJMMCwgMHhmZmZmZmYpOw0KPj4gICAgICAgIFdSRUczMl9TT0MxNShHQywg
MCwgcmVnR0ZYX0lNVV9DMlBNU0dfQUNDRVNTX0NUUkwxLCAweGZmZmYpOw0KPj4gQEANCj4+IC0x
NTcsNyArMTU3LDcgQEAgc3RhdGljIHZvaWQgaW11X3YxMl8wX3NldHVwKHN0cnVjdCBhbWRncHVf
ZGV2aWNlDQo+PiAqYWRldikNCj4+DQo+PiAgICBzdGF0aWMgaW50IGltdV92MTJfMF9zdGFydChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+ICAgIHsNCj4+IC0gICAgIGludCBpbXVfcmVn
X3ZhbDsNCj4+ICsgICAgIHVuc2lnbmVkIGludCBpbXVfcmVnX3ZhbDsNCj4+DQo+PiAgICAgICAg
aW11X3JlZ192YWwgPSBSUkVHMzJfU09DMTUoR0MsIDAsIHJlZ0dGWF9JTVVfQ09SRV9DVFJMKTsN
Cj4+ICAgICAgICBpbXVfcmVnX3ZhbCAmPSAweGZmZmZmZmZlOw0KDQo=
