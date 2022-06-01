Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5743C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 16:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C4F10EF2D;
	Wed,  1 Jun 2022 16:41:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D65110EF2D
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 16:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpWlJW24dFT5c7NGjL6A6a1NSH+hdvbNdf0i0XGQ1lbIF6a/f7G3Mf9qlbGykcGjwaetcgXA6eLDpsbqgcOGYWDU5uPX7tJDVqSja9xJjMxqhRze2kEDXIYp6dqp+sbDqN1k9iHry5+vHpZge+37JUOLJuWLr6ZJ3sGlOSpV61ePnzyh5ORGr4E9DeJfKMD7GrpQuv73NfaBT2tGDn9IDpSKl8FWaeTNxWwly+FRBoeCpGOPFcmryiAb2ATnzkKEdz/hWiCfpY94G6tRWKrqsdP+ZNKzhdKayLimQuEKulorLMvpgWUxewViiDU7p/T3sVcOVfS42oXYweAbOqFJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rx1u9QlUxuvmjeMoZp8BqbOr7IofqxufOXRzQlk2uSw=;
 b=apRgCnJ/NHAHSmX2C+J3AfldZCaHsLknHR7HzxCxCnLzQDonc/mdVZw8AKlGBCDtarcbdDFpWqmc5QdZoklbmIKOKyXCcM87ZImUIYmSdpj5kMP65KLCZI8CjqqtCVueChxt80U3xtmfLe/rOepL8HYeWiqpDf+61fY6qs562B5fmPO5eBl1CGxvIlAt+T7eqgotN7x6OYiYSQUz7ZgA5RdODQZ/ADvI6kpCBK+B0OC1YEooz3wE/JNFEgL+GCcNe8RyNQh9IiO8L1M8iVaJg/MSz/yaNnLmV7rZRKE2RZnrEXFjY4ycpfC4Kp1ksCByimHZOOYMgH1STajmbqi2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rx1u9QlUxuvmjeMoZp8BqbOr7IofqxufOXRzQlk2uSw=;
 b=KNlAa4elqBr8Qk0jIHmiNXEqCi1DZPGac5WkwxnFwYTY7YAE0llCcKbF8PAH7wco1X8LWq4tk5pzIKjR79Qo/XI0WFKTYE9Pe9hHtK7LEONUv6bFQVkw2YDd2R5NbQiIIqSsE7rHrpqIKWWHhERsZzgMZ7ai039XdUOz8tjTm48=
Received: from CY4PR12MB1496.namprd12.prod.outlook.com (2603:10b6:910:10::8)
 by PH0PR12MB5465.namprd12.prod.outlook.com (2603:10b6:510:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 1 Jun
 2022 16:41:35 +0000
Received: from CY4PR12MB1496.namprd12.prod.outlook.com
 ([fe80::b802:f477:9024:61a2]) by CY4PR12MB1496.namprd12.prod.outlook.com
 ([fe80::b802:f477:9024:61a2%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 16:41:35 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Correct if identation that causes GCC warning
Thread-Topic: [PATCH] drm/amdgpu: Correct if identation that causes GCC warning
Thread-Index: AQHYdcHyMeYprTR7n0meTAZLQB7dBa06wBUg
Date: Wed, 1 Jun 2022 16:41:34 +0000
Message-ID: <CY4PR12MB149632D498AE218D514FD08191DF9@CY4PR12MB1496.namprd12.prod.outlook.com>
References: <20220601141400.889921-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220601141400.889921-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-01T16:36:53Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0296f128-a525-4172-a533-253242d36112;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-01T16:41:33Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 1e6eebe1-60dd-4c2b-8cbe-75c53362e817
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd489ae2-c375-43ff-a189-08da43ed9749
x-ms-traffictypediagnostic: PH0PR12MB5465:EE_
x-microsoft-antispam-prvs: <PH0PR12MB5465C1CD0912CC82E59B224191DF9@PH0PR12MB5465.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 09sB4VUYaD6Vc7BqljRokc3szB536Xk3PHgSWa2LawKc2LLvpKnY/Jms/NOcb55/R62kDyrTS2LZBexANHxDVM/S8adIJFP/v5/16hdiGlifQmFDG1dBd9zTtsCMZbhjzZWACyU/ABTu1KrRQmntUSpZFr+wyaDmBSrX7Vtdh4bxfDqQRqeGIlMdKafTLTa7oSEnc1WOrl9Lzb0z2aHLr4cALQXe4hO8NW6/6Iam4yNEzlfrpQvLKmC5ltDWpgiYvvKG3h9UqB1C+lCTI2f9taSu986fjsrJmehM1DteTchsUdzvSIedOQYxMEFcQ6g9oqgu1gWKyomONZMdVFBPpGyUzmmFxHXSL8PExBmPbgRAI+YdXxCa6hv/W/U/s7VBXEkJy6Uc78cykxWld7XnMuR4t3UdR0c7Dwsvo2BQTqEIHwDnjjjSO4zpIKaRWNdPXmRcGEQT5PNLgCM1tSexO9NqKmzoDXh8DgxkcjrdwoE5TLfY7MjE9JJ89PRtTWsf/YeUH9KiYKzAr3nAWOVBAqPk7keozdhz81ew3Pc7ena2mESZn7iAad9ZOI1fikGfHYrh3yEsaw9MKty5f2SauyaNH1Anl5ksYkNrrR72z50mWgLnOfEPfBoRZalfd6pNDVELbMqxfXZB5QbxpabHJjUPneLL74L+Yk7NPXTHAwsw1sz38vG0uAG9jWdFwTQb5wOHiK+mykXdXLByhDz6Pg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1496.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(9686003)(66476007)(33656002)(316002)(66446008)(66556008)(110136005)(54906003)(186003)(52536014)(83380400001)(53546011)(6506007)(7696005)(508600001)(76116006)(66946007)(8936002)(4326008)(86362001)(71200400001)(38070700005)(2906002)(38100700002)(55016003)(5660300002)(8676002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzJUWnZ4WWNUclFZM1crTko4N3kxdS8zUm1HYXBtL0Y5WmkzWUNmNGVMQkpq?=
 =?utf-8?B?dkFWa2FKS2tjSHBFVmU1aGpGakNHcEVTRW5RRWVhMHRnb21tMW1aSDJSSUYy?=
 =?utf-8?B?NGFJU0FacHNOVWxOYksrSW5KeWpJZXA2YmhMcTBDdndIOW5IeDVacnhNT1d6?=
 =?utf-8?B?cFlFT1RMWTFaSytEWW5Yb2twT0c5c05YdFhSY2piUUx0YmsyU3BHaEtYZ3hS?=
 =?utf-8?B?cFdKWUtjVkF4MXBYWlBxUVpMK3RXZWd0R0M3MnJYMFVHeGJJaHFnV3F2UmVW?=
 =?utf-8?B?QThnMWo5bzJzbHVSSG1tNFZ2N0dZWkJHV3ZHRzNYaHZ1ZlhTRUtsY05CQU4r?=
 =?utf-8?B?RFg4VkV1NEFwaEVBVmhNV01pd3JWQTYzV3pLRlJjOW1EREpybXQwQmFCM3N0?=
 =?utf-8?B?WXRvNy9JSWd4Rmo2M28vMjVyVE1kZjUyUjlIa3RkNWpSWXp0V2hkMUJKRFJY?=
 =?utf-8?B?WjBTNzJ4UVdVcyt6d0t3bUo5WTYzZ2EvOEllK1BULzNoclFXZGh1cWFwZFpr?=
 =?utf-8?B?cmZRYlR0bjVDQmc0d2FERHZtSUh0QWIwcmtOckxGd0dXWWRhelo0SkZCdlNv?=
 =?utf-8?B?WEdoMTkrL0dWNWdxaHd4MU03MFVnV3dHTm5MWjRSSFB0dlVndElpUFVIMUVQ?=
 =?utf-8?B?VHpXa04zYXhHU1VscGplUEU4MGFKL0k0aE1jckkwWjd2R1pES2NleU5EL1ph?=
 =?utf-8?B?RmZlWWlSeDVQZXc1UU84RWkrZmlXNHVXWFhabnpXZFpPMk9hTlE1NVZJUmdG?=
 =?utf-8?B?cDRFbmczcHNnRWZQdThQWUpqOWFLdEJhQmJmMnN2ZzR3azA4QXJPVWlXajhN?=
 =?utf-8?B?dmpDNnMyV1FwSTBoQld3eDNnd1NTT1VySDFmT0NFUGhJUmV4SU1NOHRETng1?=
 =?utf-8?B?MkwzK3d5RnVkNnNoTnhzOFZSVXhPZUFZQTJ1Y1FYU1ZRVEt4dm43cEwyakFM?=
 =?utf-8?B?cG8wZEhKb21Zd3pDRy8zaUs1SEpPeFJyUzlUYnRFR0ZtSFZmdXhXMzlSOStK?=
 =?utf-8?B?ZEJuLzFNSFExTkY5dXF6WmNkTWpOT0Z5dkZGR0tVaG5sVEFnM3ZPL0p6U2Ro?=
 =?utf-8?B?R01CWlVuam9oZ293cFMyT3U4dzNPcVluM09ZMTJxKzZaQTc5OU5TRXlseGxQ?=
 =?utf-8?B?amZuaGEvSVphS1hITzJyd0NNblkxZlZwTTlpRVZZWXRMTFM4VERmSmxucS9O?=
 =?utf-8?B?SHhLWlI1T2M3bDNrck1wVXpvMW9ZamlrRDV4TU9SdnVlVXNUcXlTNjdqdlZ5?=
 =?utf-8?B?czFHamxONXVDcjhmbTJDanhhbW85dUU2WncwWjRkZUY4L3o1dktNQnJDd0wz?=
 =?utf-8?B?ZjRZd2wxNHFJM3Znd0c0M084QmNyVWhMTEdmSVZWVEl4VFNKVzNGR28vbC9E?=
 =?utf-8?B?THNFMGhDUlhNd3doK1ZrSkgzN1drVTlSa1hSRmxVa1V2WGZWMEZPWXlhVjYy?=
 =?utf-8?B?VVJlSUd5K0hZSTVTRTZkUFFFdFN6a2NlUmNrci9sQ1RyRUhWZlIyWVYwL2ZF?=
 =?utf-8?B?K3RtYlFveUhEYk8xQTIxak1yNmY3c2MxYlBrQ3pLSzVXS1hCU0txbHlyL1lq?=
 =?utf-8?B?eUZUaDREeElXSWkvWUNvQlNQRzg1VHNqclRGY0drY2JOS3RUZ0p3VDBQbit1?=
 =?utf-8?B?dDE5MzExU1h5TEtCTGIwTzkyR3lpVVJsQ3JrMkpPeGswVGo2alVaUDRrQml3?=
 =?utf-8?B?emJHaFY2Ritld01VZFdJdzBUeHlBV25lZHFreU9vMFp0MlQ3WmViSWVRL2Q4?=
 =?utf-8?B?dlM3NW1QeUxiYnlYaS82RmZoQ1djWXFrdXoyUDBLM3p6bTJZRmM3NWhQUlRK?=
 =?utf-8?B?M2ZxaHBBOStGaVhvaDZQcW4rYzNNRTEvZHBSallpVFZyek5nd09zcmVXNFcx?=
 =?utf-8?B?QTlDcDdVQllab0pPTE56RDRBeXdhNmdzSEZydUx0dUJrQ0NRME5Gd0NCM2tC?=
 =?utf-8?B?Yk1RTGhwUThSR3QvZTZlUFJlb25GSndHMFg3ZW9MZHdWaTRza2NhWkxhcWhW?=
 =?utf-8?B?S2pjVWtMVzhGZU5iNGU4cFZEWDlGQXdsUWd0MmJjdjhJOW9vUHlDSnlXL2RK?=
 =?utf-8?B?L2FQU0RaeFhVNWExUlBGTERScWJ0ZWg1L2FTVlkwZE10L2ZmbzlOdUtHNTZB?=
 =?utf-8?B?WVpwYW1RWElUWHNkTEFuYjBBMUd0YVhFYXpQcVREQlIvVUZQZGJoV0k5Z2Fw?=
 =?utf-8?B?cXlSU2greWZPc3dYbnhhdSsyWmE2amZoUTFRSUJlT3RhQmJ1citWNGxEL1NX?=
 =?utf-8?B?TCt5UldXbDVvK2FKWlhtcmhiVE9BaXZFY3lKSStzbWdPcWdpNnV4R0drUnlP?=
 =?utf-8?B?bjNTcE9iazBGaldidDZxYjFyVmxOaUNuZ1M5Z3JrMGV3OVBXZzBaUDArUkk0?=
 =?utf-8?Q?5LcQHzhbzsYw/DKB12bIDayHj8zU3wI4YaF+v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1496.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd489ae2-c375-43ff-a189-08da43ed9749
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 16:41:35.0216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t5OXSCZjsjRm+ttaXnchPNrNXR5qTCnyagIQ3NWX9T3upDdKReCnP39VutQq79Lo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5465
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFJvZHJpZ28sDQoNClNvcnJ5
LCBteSBiYWQhIFRoYW5rcyBmb3IgdGhlIGZpeCwgYnV0IG9ubHkgYWRqdXN0IHRoZSBpbmRlbnRh
dGlvbiB3aWxsIG1pc3MgYW5vdGhlciBjb2RlIHBhdGggZm9yIGFtZGdwdV9yYXNfYmxvY2tfbGF0
ZV9pbml0Lg0KTGV0IG1lIHN1Ym1pdCBhIG5ldyBvbmUgdG8gZml4IGl0Lg0KDQoNCg0KVGhhbmtz
LA0KQ2FuZGljZQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU2lxdWVpcmEs
IFJvZHJpZ28gPFJvZHJpZ28uU2lxdWVpcmFAYW1kLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIEp1
bmUgMSwgMjAyMiAxMDoxNCBQTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpD
YzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgTGksIENh
bmRpY2UgPENhbmRpY2UuTGlAYW1kLmNvbT47IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5n
QGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IENvcnJlY3QgaWYgaWRlbnRh
dGlvbiB0aGF0IGNhdXNlcyBHQ0Mgd2FybmluZw0KDQpHQ0MgaXMgY29tcGxhaW5pbmcgYWJvdXQg
bWlzbGVhZGluZyBpbmRlbnRhdGlvbjoNCg0KZXJyb3I6IHRoaXMg4oCYaWbigJkgY2xhdXNlIGRv
ZXMgbm90IGd1YXJkLi4uIFstV2Vycm9yPW1pc2xlYWRpbmctaW5kZW50YXRpb25dDQogIDYwMyB8
ICBpZiAocikNCg0KVGhpcyBjb21taXQgYWRqdXN0cyB0aGUgY29tbWl0IGluZGVudGF0aW9uLg0K
DQpDYzogQ2FuZGljZSBMaSA8Y2FuZGljZS5saUBhbWQuY29tPg0KQ2M6IEhhd2tpbmcgWmhhbmcg
PEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCg0KU2lnbmVkLW9mZi1ieTogUm9kcmlnbyBTaXF1ZWly
YSA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dmeC5jIHwgNiArKystLS0NCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dmeC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2dmeC5jDQppbmRleCA5OWMxYTJkM2RhZTguLmUxZjRjNWYzMDY0NSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZnguYw0KKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5jDQpAQCAtNTk5LDkgKzU5OSw5IEBAIGludCBhbWRn
cHVfZ2Z4X3Jhc19sYXRlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBy
YXNfY29tbW9uX2lmICpyDQogCQlpZiAoIWFtZGdwdV9wZXJzaXN0ZW50X2VkY19oYXJ2ZXN0aW5n
X3N1cHBvcnRlZChhZGV2KSkNCiAJCQlhbWRncHVfcmFzX3Jlc2V0X2Vycm9yX3N0YXR1cyhhZGV2
LCBBTURHUFVfUkFTX0JMT0NLX19HRlgpOw0KIA0KLQlyID0gYW1kZ3B1X3Jhc19ibG9ja19sYXRl
X2luaXQoYWRldiwgcmFzX2Jsb2NrKTsNCi0JaWYgKHIpDQotCQlyZXR1cm4gcjsNCisJCXIgPSBh
bWRncHVfcmFzX2Jsb2NrX2xhdGVfaW5pdChhZGV2LCByYXNfYmxvY2spOw0KKwkJaWYgKHIpDQor
CQkJcmV0dXJuIHI7DQogDQogCQlyID0gYW1kZ3B1X2lycV9nZXQoYWRldiwgJmFkZXYtPmdmeC5j
cF9lY2NfZXJyb3JfaXJxLCAwKTsNCiAJCWlmIChyKQ0KLS0gDQoyLjI1LjENCg==
