Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E67C74A5B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Mar 2023 19:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C51210E3E3;
	Fri, 17 Mar 2023 19:58:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4104910E3E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Mar 2023 19:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdcDb/Kzi+riCEGKhde2UaTlMber6nAxa1Z4ehVtUx9JcPM1gZ3134sV2/QoI/V9fT8jKehFGjHShz6y9SKXepBkGKw/M6XDero0hCco1wSI8MNFM0ovjv1GliSjkHYQ3gKeu2GkVkZzKiKOyatOHu/ZvgP4sSt/ygHo4VYTevWPth0SXNqASNCR46UCLhDCQD4cppYAM6iw363GSehlRvHP+/aUKr9vaBmOAQKssaJ93QEhDNOfsAVy3CHM2TzwBDe/f632In1ZkGjvIkvxQSib8HfG3ZgOy/Y9X1QwORzOUN+JMoaS/8g2UBHT+wFMV23nSiL1ZLNvqyqfdOdiMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQOL5egOpHEyBEGX0NLNYBwKXPmDxCPtmJQeXMcQQI8=;
 b=FLDm4I0T51zK96kdREhwSZP0NgyLPPr7CDx9JzRlwOirOBA0PLPQTuFY8Of3uGmrh5OaEwrVrU07/tDSWe2DU6jtSdTnnJuwYk02ojrfjdqooddXMNRd5aetr9A2/4s0Pod4cROUYyrAzUkIRU3ORrzX9yX8K36QHZtfAJ7/wOLMFWo3eWz7irDGMHXxSS9HijyF3HRMlVVoW04DXcY0DJqEwxVcU4Bo+nkq7mKK2RkW3qkCSVjNADf7kpFFGtmuo5OOEEXtqIqEpIcrTIk4HDXxbsQsK3OTDcmtf7aOYMP8hv3C6foJYOfU6jurMYFc32mYLKDsqdoO27gTDGHI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQOL5egOpHEyBEGX0NLNYBwKXPmDxCPtmJQeXMcQQI8=;
 b=a08T7e77K6wrxHL/DE956Xt9wdu6J29FExGNBZvuzZIr4ESWC3wZKnaY8+igE2xZrj8lXtFQ2oghhdQSETc3u3l2Y7iuS7Sf/UbW99JmnOjcr8M4YQs3svH39dbYu4ztj/xqTOxGXfeHcPqadc1dM35h6gwkD0vhF30wjUgEqWs=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Fri, 17 Mar 2023 19:58:00 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::b607:1647:7734:a98d]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::b607:1647:7734:a98d%6]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 19:58:00 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Sider, Graham"
 <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add print for iommu translation mode
Thread-Topic: [PATCH] drm/amdgpu: add print for iommu translation mode
Thread-Index: AQHZWQl8PG/kKcjEokGP4RGcHPuuJK7/Y3MA////6IA=
Date: Fri, 17 Mar 2023 19:58:00 +0000
Message-ID: <DM5PR12MB1308BF656CB0C75BA0B9CED885BD9@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20230317194757.1336098-1-Graham.Sider@amd.com>
 <0509601d-8d7c-26e2-26c9-8f4757a92ca2@amd.com>
In-Reply-To: <0509601d-8d7c-26e2-26c9-8f4757a92ca2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-17T19:57:59Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7d905304-9143-4c4a-ae49-36ba80b47603;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1308:EE_|DM4PR12MB6592:EE_
x-ms-office365-filtering-correlation-id: 9d45553e-2d42-4915-e79e-08db2721e951
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ioS3xXvP47cWj6BrqraHHx3fLJRA8+zWONVJyxFBsy/lpk7ew7Zpw3NI3aJq5N4dp9IAO3bp82/953SekAyZvx+phne44+2/xuCPkjzDew7IOW+iQoJUEGGu5d72VD4iFFtJlyRevlsEOPEtRiH97bzid9fKg4tC21J5bC3mUt6BYMNGPHit1xE11M3kOm7WmUxLAXF3pKfeESaZgp6gl5enjiVvOCv0lhS2dty+GAKioXFfpMK7y8o9SjIhW7pacPiraWXRfGaIpZTTHskRBEM/x9t+/T3LIgVg8a4natiOVPFlBQw0a+Vc8Vxkqzw6FFNRmO0YPhQ4+FOaG5HoCLOaRlEivlovgRzdHrR/VS56vc2E2XPM4se6/xvXxtcTfCFTiUKXZ6LymrFEKRZFOMVfjdkCKQodtAQGURKuLLjdzApMXKYGp070egutGxxeILkyq+s+OfaJWjOuxzpIQiS58OJggo81b97bbOguMfd6ZpslacRmqV9Ox7eSZHXeg7OzXMcYtOZ7zpvkxzj9q6yp7v+PrGVsWKB+8GpOcCx2oV7I9zSZQjg2GRpdGZCnhbPAFYO09oAS3EVUMESO2oDFAqbVlHTD94G1wH1f85T4YN/2Nc9LMuSstpCgv3c3MNHxSYgGnz8t3CTXP9ix12tdjp4kKu3oSTTnQXUzoIElyDEs/mawfovjgSvitOKoTspqquVGSBA8+IbG7Xmo9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199018)(9686003)(52536014)(5660300002)(4326008)(8936002)(86362001)(26005)(41300700001)(6506007)(53546011)(186003)(33656002)(8676002)(2906002)(71200400001)(110136005)(66946007)(122000001)(7696005)(76116006)(66556008)(38070700005)(478600001)(316002)(83380400001)(55016003)(66476007)(66446008)(38100700002)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2paZCtlS1lvenNGNzJSaVJKL2JOOXVUMUtvalk3cVRjNXQ1YWd4bHhqVzcy?=
 =?utf-8?B?SHdCaFFEZjN3QUkrbFNMb2FOV1UzcDlxZXQ5MXlha1J4S0ZQV3pKZEhLM2Zy?=
 =?utf-8?B?QlJ2eExKaXhoanU1RGRVcE9PN0xtUDM4Vi9tdkFXdjBnaCs4ckR2MzBzMWVW?=
 =?utf-8?B?VVpubVZOeGd2NWt1ZXhUK2xtSzRWT2F3TnRYeUhVNVI2ZkV5V2dPeUJUV2N3?=
 =?utf-8?B?aTU2ZUZyS1gvcEtDcXNqYlU5N2hVY1JKRlRaM2t1N0FXUm9BLzFZVEpFT0Ft?=
 =?utf-8?B?a1FOUFhnVHJiZ0c2K2hXd3NHcjF1QnhGZHp1Zy9saHNlNDR5NlY0OUxaNnRT?=
 =?utf-8?B?QWZhdEZ5MUJST0ZYRUt0dHZOU2wzNGJXbUt2dXJaL2RPY2syN1JRdkRtaWpt?=
 =?utf-8?B?UWhZU0VLeUU2SW1JV2pjVlpOSDBmMHVoYlBGN1RmTDhwdnZjc0YzcWMxRXZp?=
 =?utf-8?B?Y3p0Y1JNVlg5RkJZbmtTYTlmZThtK1NhQVlHNXVkelNPbVNvV3JOZ3RqRmgw?=
 =?utf-8?B?b0ZBZ25VQ0tuakpQTjZMUUsvZm5LV0dxczBOWHRRcGt5NUZGTDlZMllwWWxG?=
 =?utf-8?B?cFFOZk43VGpJLzhPOUFnMEY3dVY4UWVoNG1mVVdDa09HaG1wM2xRQ3hCWDdt?=
 =?utf-8?B?eGxzUmRTYTlWNUFZNm9LdEVTNHBnM1VjWWNpTkpXL0xKZ1ZSK3hZRERKejdH?=
 =?utf-8?B?cTdQbXZNbmc1MDhocCtEajhBU00vblN5MTRIQkVxMkZQaEVvRmJHbVh6aW00?=
 =?utf-8?B?Yi9MdWdSckdlZVc4NGpjb1U1U3Rick5Ic1kvZTM3OHFiUjAreGtQSTcwckZt?=
 =?utf-8?B?bEVMVGx6WENMcWVZVm1xaEw0UjFEc04vVGliOXp5d2c1TTNzT1ZMRHJ4TXFX?=
 =?utf-8?B?cmFwakMzUUs2WTdVbm1lZURBSkMzNmx0TWdxZDIyQTdZWmRsZXdNcFBhUUtV?=
 =?utf-8?B?M3hjaGdrUDh1TWJxQjZuRkZPelQ2MTJlUDFKcWdaMnljdzVXMDBHT1VHdlF5?=
 =?utf-8?B?M2JTbG1sZUwzY3ZlUjd1Z1ZCay9UcDJCcFkwbUNSaTdpSDZPRmdQSmQvdEdX?=
 =?utf-8?B?ZXVTYysyczJSSU5yL0F3YkxkUEI3dVBTVWtaenhwcC9sYmhZMndDakNUUU12?=
 =?utf-8?B?aGZHWmN3V3ZqcWFPbms0M0szWllXcEs5VDBDUlR1L294RG1iZVdROHNNcmJ1?=
 =?utf-8?B?M3RZaWJENWtSOU9STzBQRnYySktMS1ZRVUlGZHB5Yit3S2ZXL0VUQkg5YWZl?=
 =?utf-8?B?aTJ2cHV6LzZXRUw0bkZIbERvTlN0dWNhZ3h5OUJPcVVkRlBIUFBHQ2FtT1FH?=
 =?utf-8?B?TFg3ajZLMS9HWDFNbTM3OWd3R1BHYms2ek9NamVrcjJMZGtKRHRlQkFYSFhF?=
 =?utf-8?B?TkQzQUtVa0NvZkNPQnJtVithRTdFZzZKNVB4aklIcXlRVyt6OGlKWXhwZlN5?=
 =?utf-8?B?UVJtRXFtKzFrSU1ZOXVaM1V1bFR6b3NQRUgvN0tHZU9Vb1EvZVFLSmZ2M2lQ?=
 =?utf-8?B?dk16WTQ1bUZRSys5cVFGSTZYV2dRUW1WcCtOc0VXdzN3YitWdllkZk9SVzVM?=
 =?utf-8?B?ZmpQUVBHS25GUkVFSGpxUXBZZzdGcjE1UFA0TFZ3S21CeVk1MnNua3FaSzFI?=
 =?utf-8?B?TXRMZDlYUkw2ZmZ1dVNFY2hxREV5WnZUODlCK2ZtWFVXK0dPNlNaVzQwYXlG?=
 =?utf-8?B?bEQyTU9sWVR4ZXY1VHdJaDVta1VGRURDZ3l3aFR3cmw5VXM4UkVUbmlYaGN3?=
 =?utf-8?B?Vy9iemN1cEVqeGNrMWRIMEVFOUxodUxlVWVNUE1RWmUyTUlBSFZGVmlySzNB?=
 =?utf-8?B?emxvU0FOKzZPRHk3SHpUT0lRQkdiRWpoeCs2eXRvWnBPUlFqVmlCa09DZHg0?=
 =?utf-8?B?cTFoR28yblFmb3dxclJzS3JCSXY0OHdUL0RIQnVZdm9NbzRhdGw5L2pFbmNV?=
 =?utf-8?B?SytvejdSM1pVWDFGSUlIZ04rUyt4Q2xGNjY2OTdaMndnb3FLVE1TL0g5WHVp?=
 =?utf-8?B?WEtHY2JZbWYvYUphWTlmaDh2aUd1Tm9uYnc3enZNengrTThyZU1rL200UVdv?=
 =?utf-8?B?REVPaVpMYS9TRHlaVXkwZDRIN1dZV1h5WmhlaGlMZ2tCaWJMdUFIQTRJRVR0?=
 =?utf-8?Q?mdXQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d45553e-2d42-4915-e79e-08db2721e951
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 19:58:00.4763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5AUoCvrALlIkgroLTDgFUdEMQ2055tshNvdzCPV/09P/s1V8IJrtTtoRkbY7JeOlKrbyPxJ1ldj4f7TZL9OOEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVl
ZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBIYW16YQ0KPiBNYWhmb296DQo+IFNlbnQ6IEZyaWRh
eSwgTWFyY2ggMTcsIDIwMjMgMzo1OCBQTQ0KPiBUbzogU2lkZXIsIEdyYWhhbSA8R3JhaGFtLlNp
ZGVyQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogS3VlaGxp
bmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBkcm0vYW1kZ3B1OiBhZGQgcHJpbnQgZm9yIGlvbW11IHRyYW5zbGF0aW9uIG1vZGUNCj4gDQo+
IA0KPiBPbiAzLzE3LzIzIDE1OjQ3LCBHcmFoYW0gU2lkZXIgd3JvdGU6DQo+ID4gQWRkIGxvZyB0
byBkaXNwbGF5IHdoZXRoZXIgUkFNIGlzIGRpcmVjdCB2cyBETUEgbWFwcGVkLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogR3JhaGFtIFNpZGVyIDxHcmFoYW0uU2lkZXJAYW1kLmNvbT4NCj4gDQo+
IElmIHRoaXMgaW5mb3JtYXRpb24gaXMgb25seSB1c2VmdWwgZm9yIGRlYnVnZ2luZyBwdXJwb3Nl
cywgcGxlYXNlIHVzZQ0KPiBkcm1fZGJnKCkgaW5zdGVhZCBvZiBwcl9pbmZvKCkuDQo+IA0KPiA+
IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwg
NiArKysrKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGV2aWNlLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMNCj4gPiBpbmRleCA4YmJhNWU2ODcyYTEuLjg3OTdhOTUyMzI0NCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4gPiBAQCAtMzUy
OCw4ICszNTI4LDEyIEBAIHN0YXRpYyB2b2lkDQo+IGFtZGdwdV9kZXZpY2VfY2hlY2tfaW9tbXVf
ZGlyZWN0X21hcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gPiAgIAlzdHJ1Y3QgaW9t
bXVfZG9tYWluICpkb21haW47DQo+ID4NCj4gPiAgIAlkb21haW4gPSBpb21tdV9nZXRfZG9tYWlu
X2Zvcl9kZXYoYWRldi0+ZGV2KTsNCj4gPiAtCWlmICghZG9tYWluIHx8IGRvbWFpbi0+dHlwZSA9
PSBJT01NVV9ET01BSU5fSURFTlRJVFkpDQo+ID4gKwlpZiAoIWRvbWFpbiB8fCBkb21haW4tPnR5
cGUgPT0gSU9NTVVfRE9NQUlOX0lERU5USVRZKSB7DQo+ID4gKwkJcHJfaW5mbygiUkFNIGlzIGRp
cmVjdCBtYXBwZWQgdG8gR1BVIChub3QgdHJhc2xhdGVkIGJ5DQp0cmFzbGF0ZWQgLT4gdHJhbnNs
YXRlZA0KDQogS2VudA0KPiBJT01NVSlcbiIpOw0KPiA+ICAgCQlhZGV2LT5yYW1faXNfZGlyZWN0
X21hcHBlZCA9IHRydWU7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCXByX2luZm8oIlJBTSBpcyBE
TUEgbWFwcGVkIHRvIEdQVSAodHJhbnNsYXRlZCBieQ0KPiBJT01NVSlcbiIpOw0KPiA+ICsJfQ0K
PiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZSAqYW1kZ3B1
X2Rldl9hdHRyaWJ1dGVzW10gPSB7DQo+IA0KPiAtLQ0KPiBIYW16YQ0K
