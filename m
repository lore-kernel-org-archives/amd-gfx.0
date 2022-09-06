Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD12BECAAD3
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 01:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488E310E543;
	Tue,  6 Sep 2022 01:43:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ACD910E543
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 01:43:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uj6YocOO1WNRGLpUBq+U7C1wwej5onlEK1n57asE4hSPCpjuIQkMRPo6hRJANVNgWMNg2gVaOW6ekemcl814C7+e1JaKGM36Wa4qFDWZcR3FVIPCly63fdv+un4HjjtYHR/hoFZgCavwUQJdZqXTmBDKty/gwgfEUKFkJ5MJhIo3X5PX2x5i9OmxNlp9yBEclzGSMpSLIjxGA3xBZGCoOukB8IjfeOXxEeD1CidXIUqN5m/m7J3/rksgOQ7ny8fAMJRqDP3cpbLLxFBc3zJNqiZYPM11oUF7fKH3xnuPejisVTaf0KWEuffEv89RQzYfX5RslaYoWUo2RB10P6TPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hH7SNzakS1zF/Ejda1JCeHQV+QplyCPmT0rJ+i6MAeU=;
 b=WwcCJz9I7PYnV6JK2mOzjPHO+KLO6CO7l6NsVg0XUhpOiB04KGI10zdb+dadnBCzNK/0stISuXTljj/bCLJsUJHP2LCzT9wWUzWpQ/cjb3fl/dteA3lMHtHzRSlD/Gw13nG43NjJ+OOKmR5R0k3l910xNhN0ktEmOK+7SioZtbq71odc4Gc2u31pzzYRb2vRw1E2fZE0jqG/2mRUWfTd1V565chFvWagxqHjT+0zEF23gpIvO+8yf98Gu+s+d0pU3XJYywXChtxUji++IR+KpY/UtZBamJ+hpEiPhyLGAEsB8/pdqKMWCRaCnCC41XjMiwyHau2XM6mpk6rNWPo7wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hH7SNzakS1zF/Ejda1JCeHQV+QplyCPmT0rJ+i6MAeU=;
 b=g9BkOwt72b5Bm692BYLPW5rIMvZJjAlmcw970Dg0VqBG3AHdv0P+8XxMxulNzUtdy9K7gdTjS/UYVACkYjvWMPkAskzXqXnkxwDd4b5GpZJdw3zUsVk7takNunIMbFKU0/l5ywZPA6+1XWEZDR68uT7AM7wE9mJ9nb9ytbn4IY8=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Tue, 6 Sep
 2022 01:43:32 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::21ff:b0c5:a511:4572]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::21ff:b0c5:a511:4572%6]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 01:43:32 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Olsak,
 Marek" <Marek.Olsak@amd.com>
Subject: RE: Gang submit
Thread-Topic: Gang submit
Thread-Index: AQHYLtfvDT02Z6BZ70ee+sUALrEaQq3SxXOw
Date: Tue, 6 Sep 2022 01:43:32 +0000
Message-ID: <BL1PR12MB52691BCF633B4F87318AE9CC847E9@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20220303082308.38217-1-christian.koenig@amd.com>
In-Reply-To: <20220303082308.38217-1-christian.koenig@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-06T01:39:56Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ab18f6b3-ee7e-43c0-8328-e29d413ea192;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-06T01:43:28Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 1b7af8f8-4469-4602-9793-3250bf2f9afb
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09501b10-779f-4f61-1621-08da8fa93499
x-ms-traffictypediagnostic: PH7PR12MB5620:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8vI0kgc7by77ViiNCqQEQEn9ss84GXPWOwoHG7AuTnR7ndg8SwP+CnKPf9OWv3WgVvRpn1zsZFlg8KHPsI59QKHTz10iBMwQr88DJ/LIjoOdill+UzEFb3vW6EciazUegSOxyF4P3xjkv7xadOieMVcKH7omEA6eCLnPd5gMLDE5Gqanfa6nsvB+PXnisXwpS1iPHYX0fs6DLFcMkB6SfUMul1x1JmqZv5IRjq3Y4l6RfH5+U6JKDDTrPV+pl35+1oNNEFNaJCUAM8gcajURN9/QxcbjcDFcGiRdJkC4EDo5n0yAWGFS6kEfKjm8iHj2oDttXSGe9QsaNbpvd6+Orx31AWcuZpprsQX+bbiQ1rukoBEYpWyN7izoXhBFGMWvO9N55RK8sgyLNupPqho+LwzF3CDHEwzWQdMpk06L9cog9SLnllRPLQ/BJIInTAeMZrdNdcyq6nC202SdAkOsnVm5GhLHrVYrjc4yWlkJPkgivmBdswh52MbmkWwTn0sqrYGbktL22COYPvnz13R2PD31CLZzssthNOX3FnRowb45UD4G5MUBIkOUdMYBYUeZqMhICHEbyUWE8UtsVsleZyfaSmXF6N/hJEM+VAMxTKOna5UKLfjwHNRL9ttpigqZYfKJgIvX0xmnGavZ57SUFnYtrAmRIZYeUjkbydO28zGsiI8QhTUegT90cW1iPkbPL7UKsHkOjcReKg7N+5/Te9of44YnpoyWfg1fUbKzKhJjHLMnjNmhhS+YqRHB35geToclFGW0NQVkmKRW5Scq2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(7696005)(186003)(83380400001)(66574015)(55016003)(41300700001)(478600001)(6506007)(71200400001)(9686003)(38070700005)(86362001)(53546011)(38100700002)(122000001)(26005)(33656002)(3480700007)(6636002)(316002)(8936002)(2906002)(7116003)(66556008)(66946007)(8676002)(66446008)(52536014)(64756008)(110136005)(76116006)(66476007)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXgxZ3FLZ1pVeEhCcTRRbWRSckVmQnpzL1VNUS9VZnRXQTJqQk1RZTFvMldw?=
 =?utf-8?B?ZER1eHFnelg4TllVMGh1dUI1bGNCSklzL3Z5WWRBbk5KYTBPQ2ZKOWRTbHc3?=
 =?utf-8?B?aEwzd2VjeGJDRU9XVjRYcGhvd2tMY0hycThuYTMzaXJaU0VMYmo1Tkhrc1E5?=
 =?utf-8?B?emIzSU1Nb3BNUmpoQVlPK1c4MkRkVDZ2bUpmN3lSTm9KNWlzNFR1MktlYTNm?=
 =?utf-8?B?bFhPN3dNV3RFMDhGTUFLYjNKTWtIMGZhU1NDOVdWOFQxdlZVN29iWVltZ2Ny?=
 =?utf-8?B?azFORWRDaTM1YXJtSHg2ZVlseWpZWi9xYkZZZTJtamsyaTdZRHpRN0xVREMw?=
 =?utf-8?B?a2dOaVA4b3R0alBDSHpkQTREMmRwTHoxbjdsMXNxZDNkS1YrMkttRkxKVDdv?=
 =?utf-8?B?a3MyT1hHUVhYc1p2cG03Y0FLcEFGNkp3THRCMENzWWk0YUN3MXJGclhKRjZK?=
 =?utf-8?B?SkRaa1Vpc2NXTGNwZ3ZJbHlYWDdha1VJc2phVWxBUzFsdXAwNU5lekFveWth?=
 =?utf-8?B?amhIVWNGRGVWcDRvM3ZCK3p6bEFpT2M5Yk9WOUp5VDJWZzNOUU1MQWZPUzNm?=
 =?utf-8?B?UEk1SzNsUWsyejVaczk2ZHI3VmpFcDlFRjUxSDczaVdjQzBMMzlqd1Z2Z25n?=
 =?utf-8?B?V1VzWUg1T09OV21HYzdGUUFCUVBZdzJ1SkNmZDA3UDJZWDk3NFVHWExhSG9S?=
 =?utf-8?B?MTZ4eFAwekxsRXduYXUvazlacXQ5ODQzRlozVWZRNVNMV2dQcDFseHNoOE95?=
 =?utf-8?B?S0NCT2JzWHMyd205U2c2ZFlWVU9nZlFQeHIyQzdzNnFyZGI3QkEwcFBVdnlI?=
 =?utf-8?B?dENuYXhBdEQyT3lCOWVyUlI3bE5zSVlZTUh6UVJ6RzYxaDNTZUxodmJ2SDJi?=
 =?utf-8?B?d05yajJRSWlBUXROTG5XT3IvK2VTa0xzUi9GTUFCU2c0anZrSVZXRzNKR0xE?=
 =?utf-8?B?TmJkdHZsNXFmTFF3aFYxamhmaHNOZzloYnpNblVoTVoyYWhMUnN5b0NwZExS?=
 =?utf-8?B?RW4vN21ONHVhbTVDc3lBYmtNUy90b0tEZDZjQ09EY3hUR2JFZ3FzSm9FVHA3?=
 =?utf-8?B?bDJCdFZGV3lzbi85dGh5bGQ5dnJaNU9KNTlKMFdLUlBtYnppVVJTM1RpR1p3?=
 =?utf-8?B?eXZPOEJINDFydWJNVXF1UDEyZHh5VkRhVEU0RDFuV3k1Z1FRUXFwUzlhN2tP?=
 =?utf-8?B?OXNSZExTQ1h3WHZmeDIwUHRHMW1HZWl5VURqbUFNMFFQMWt0andDYlNRMTJt?=
 =?utf-8?B?ektQUXRkZ2N2bFFkanZ6Z1pWL2hsb2JSUkM2YVdFNjhDTG1Cc2RaVGQ1OHcz?=
 =?utf-8?B?YkxsMDhpd2VKL0VtdzBvMmVVU1lmRXFtdjVHelk5UFBJM1VXNHBBak9vU2RN?=
 =?utf-8?B?UmFTdGJ3dldTRnBxTmZjMWV1KzVkaVljNlp6NUVEd3FHd1NNWVJra2ZscGZK?=
 =?utf-8?B?dzhJeUdYUXJqeWQ1aWtrd3hPeVlnM1lZTUdQbzVxODhURWt2VTVpVWNsbyta?=
 =?utf-8?B?NlFrWlA0TDBEdkV0SnhKNERSb0JIK2ZBb0x1cDRWNHAyRHh4N08zSCtVM2Ri?=
 =?utf-8?B?YzZsMnBMR2NxTWhTb09FTkJqbG1xUk5OOUo5czJMQWRxNVJKWDBhM081YnVP?=
 =?utf-8?B?Z2dCQlBBOWEzUHZKZGFyZktiRWsyaytLbFh0c2xwbk9tci9QMk11UDdYSUZZ?=
 =?utf-8?B?a0JvZGdRMkFQaUxXZUwxUlRBUjc2YlpxUkgrcGR2d3p3T0FnREhSZ05ZcFpY?=
 =?utf-8?B?MWdScGsvL2dNQURCd2haMGxEUXVnaXVvQnl3S3VacjJuYjRFMTFJLzl4SkJM?=
 =?utf-8?B?Yk9CL2Zpak5qM3BhaE90MjI1YUdsR3BhblUrUm92UjdiRjZUMkxIVVE3Um9G?=
 =?utf-8?B?MFF3YjlNR2RHRXNXenVQZEF2UHRqdksySVRpNTRxNko2WkswOGxURVB2a0li?=
 =?utf-8?B?Smx5YjMxSUl2akFMeFV1OFAxOFdVZ1FmVnBzSnRwWU5PVzJwM1k5YStlZWdZ?=
 =?utf-8?B?SVJHVzBFbGFEandsUGFsdXBzZC9ka0EvWkI5TUF4M1gxRUtIN3d0NUp2elJw?=
 =?utf-8?B?WUxFV3MrSlZWMkRuaEhBM2REU3UyWGQ5QkxMY3REZUpjV1c5WGtncHFFT0d6?=
 =?utf-8?Q?WtMc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09501b10-779f-4f61-1621-08da8fa93499
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 01:43:32.0414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zbZEJ+gJitKlAadr+UUpgWN7rGamHap51Sy9/ABA7inBngHGWRCShJSdvBzVPH5L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIENocmlzdGlhbg0KDQoNCj4g
QSBnYW5nIHN1Ym1pc3Npb24gZ3VhcmFudGVlcyB0aGF0IG11bHRpcGxlIElCcyBjYW4gcnVuIG9u
IGRpZmZlcmVudCBlbmdpbmVzIGF0IHRoZSBzYW1lIHRpbWUuDQo+IFRoZSBlZmZlY3QgaXMgdGhh
dCBhcyBsb25nIGFzIG1lbWJlcnMgb2YgYSBnYW5nIGFyZSB3YWl0aW5nIHRvIGJlIHN1Ym1pdHRl
ZCBubyBvdGhlciBnYW5nIGNhbiBzdGFydCBwdXNoaW5nIGpvYnMgdG8gdGhlIGhhcmR3YXJlIGFu
ZCBzbyBkZWFkbG9ja3MgYXJlIGVmZmVjdGl2ZWx5IHByZXZlbnRlZC4NCg0KQ291bGQgeW91IHBs
ZWFzZSBoZWxwIHRvIGV4cGxhaW4gb3IgY29uZmlybToNCg0KMSkgSWYgb25lIGdmeCBpYiBhbmQg
b25lIGNvbXB1dGUgaWIgYXJlIGluIGEgZ2FuZywgY2FuIHRoZXkgcnVuIGxpdGVyYWxseSAgaW4g
cGFyYWxsZWwgb24gR1BVID8gDQoyKSBpZiBvbmUgZ2Z4IGliIGFuZCBvbmUgY29tcHV0ZSBpYiBh
cmUgYmVsb25nIHRvIHR3byBnYW5nLCB0aGV5IHdpbGwgYmUgcHV0IHRvIHRoZSBnZnggYW5kIGNv
bXB1dGUgcmluZyBvbmUgYnkgb25lIChlLmc6ICBnYW5nMS1nZngtaWIgc2NoZWR1bGVkIGFuZCBz
aWduYWxlZCwgYW5kIHRoZW4gZ2FuZzItY29tcHV0ZS1pYiBzY2hlZHVsZWQgKQ0KDQpUaGFua3Mg
DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQpNb25rIExpdSB8IENsb3VkIEdQVSAmIFZpcnR1YWxpemF0aW9uIFNvbHV0
aW9uIHwgQU1EDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQp3ZSBhcmUgaGlyaW5nIHNvZnR3YXJlIG1hbmFnZXIgZm9y
IENWUyBjb3JlIHRlYW0NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
CkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9u
IEJlaGFsZiBPZiBDaHJpc3RpYW4gS8O2bmlnDQpTZW50OiAyMDIy5bm0M+aciDPml6UgMTY6MjMN
ClRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgT2xzYWssIE1hcmVrIDxNYXJlay5P
bHNha0BhbWQuY29tPg0KU3ViamVjdDogR2FuZyBzdWJtaXQNCg0KSGkgZ3V5cywNCg0KdGhpcyBw
YXRjaCBzZXQgaW1wbGVtZW50cyB0aGUgdGhlIHJlcXVpcmVtZW50IGZvciBzbyBjYWxsZWQgZ2Fu
ZyBzdWJtaXNzaW9ucyBpbiB0aGUgQ1MgaW50ZXJmYWNlLg0KDQpBIGdhbmcgc3VibWlzc2lvbiBn
dWFyYW50ZWVzIHRoYXQgbXVsdGlwbGUgSUJzIGNhbiBydW4gb24gZGlmZmVyZW50IGVuZ2luZXMg
YXQgdGhlIHNhbWUgdGltZS4NCg0KVGhpcyBpcyBpbXBsZW1lbnRlZCBieSBrZWVwaW5nIGEgZ2xv
YmFsIHBlci1kZXZpY2UgZ2FuZyBhcm91bmQgcmVwcmVzZW50ZWQgYnkgYSBkbWFfZmVuY2Ugd2hp
Y2ggc2lnbmFscyBhcyBzb29uIGFzIGFsbCBqb2JzIGluIGEgZ2FuZyBhcmUgcHVzaGVkIHRvIHRo
ZSBoYXJkd2FyZS4NCg0KVGhlIGVmZmVjdCBpcyB0aGF0IGFzIGxvbmcgYXMgbWVtYmVycyBvZiBh
IGdhbmcgYXJlIHdhaXRpbmcgdG8gYmUgc3VibWl0dGVkIG5vIG90aGVyIGdhbmcgY2FuIHN0YXJ0
IHB1c2hpbmcgam9icyB0byB0aGUgaGFyZHdhcmUgYW5kIHNvIGRlYWRsb2NrcyBhcmUgZWZmZWN0
aXZlbHkgcHJldmVudGVkLg0KDQpUaGUgd2hvbGUgc2V0IGlzIGJhc2VkIG9uIHRvcCBvZiBteSBk
bWFfcmVzdl91c2FnZSB3b3JrIGFuZCBhIGZldyBwYXRjaGVzIG1lcmdlZCBvdmVyIGZyb20gYW1k
LXN0YWdpbmctZHJtLW5leHQsIHNvIGl0IHdvbid0IGVhc2lseSBhcHBseSBhbnl3aGVyZS4NCg0K
UGxlYXNlIHJldmlldyBhbmQgY29tbWVudCwNCkNocmlzdGlhbi4NCg0K
