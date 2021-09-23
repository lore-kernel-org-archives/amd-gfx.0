Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF95C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 12:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CFE60F6D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 12:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89CFE60F6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F0FD6ED0D;
	Thu, 23 Sep 2021 12:09:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C6646ED0D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 12:09:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAm5aqlmyR2W2bkNBCBhxqsjqumKCOm0GZzqCtr0o81xgIUlblnHDARPj+jmQ2ajrqAV7QqKQFktHv+4FfGpqZ2jlf1J49oOHKAaDJE9FgBNGvQMM7dOlmkhUw1yNMMLypb/b62bOaiZcRbmtHunBLtaI5/vcBze46IMMq5MYxcKGRlH0r7fiwBJuU+OJ1OnhGsi+jj6rUophNFr6TDhd598Z/AM9smuXPgScjSxdutXoNcLJK/QvoqyJyXUuqTbRnpkGF4sjOu8pte2KW9e5+ioNPooFxLAeP5CoN+u9wDl14ME46hUdDhGW9hYSV2DEvD5CVNAJ5LEReANLvlF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=IMT9ChRPmLwrYmpnDLa1aM0JuMt/zuwsH8eU2pslSUM=;
 b=OEOj1iAHLIKUMIkEsf88acH0QgglAo6NQt0iYwEW2RS87usViSWCQZcPTCRMKDBkMwKvppn1ciNJ+f4+GWUTxOUXiBnxQj8+C40sBtmXKD27qtw+SaB7EYs6JShV1ckeo4hI4Qmfz91tH7eOUYHRNkm70BMEEs9d/qZOrEiyV2TY9DCga9ZDGzwcVloFMEE5Xx1Ure0fsP4Zkge7Ph5Xn5pTBcW8qNwcgVpuqpCU7YPEwe3MNoSnHMWyot/pOW0jTEXwESoNdszbzcJJwDZnbUq/1PuWak6vPS9oxEME3/UD3dsl4XPm//RsA+2Le6343HWIVCjn8x2QYbFiIzQoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMT9ChRPmLwrYmpnDLa1aM0JuMt/zuwsH8eU2pslSUM=;
 b=K6axeok1NXUM96WeRxVDjaAJvOr/Q1sZDOjNKEn2rJnTj9YO/xhLhpDzd1bYepfQHChcUaqP2oe/tlWVJxrAdwnBytg3vhwCO4T6+FX4goB0T8QSd3MmGawZbucxZckkRdqu5mbJOH/+eUZ+N0e9La4pXpt9bzkCiBtqI14EYJw=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB2859.namprd12.prod.outlook.com (2603:10b6:5:15d::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.17; Thu, 23 Sep 2021 12:09:50 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 12:09:50 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, Christian K nig
 <C3B6christian.koenig@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/kfd: fix ttm_bo_release warning
Thread-Topic: [PATCH] drm/kfd: fix ttm_bo_release warning
Thread-Index: AQHXsF+MFLhwcdC4i0yA4fQIMdExrauxfp0AgAAFQcA=
Date: Thu, 23 Sep 2021 12:09:49 +0000
Message-ID: <DM6PR12MB4250123CDF0A1F69AD1C1131FBA39@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210923094405.144613-1-lang.yu@amd.com>
 <063d904f-4083-f5db-b3d0-eb4e080b055f@amd.com>
In-Reply-To: <063d904f-4083-f5db-b3d0-eb4e080b055f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-23T12:09:27Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=69f890f2-a0f4-4b18-9e6e-ec20dfa3ce98;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55de0fab-85e9-431c-a28c-08d97e8b0b07
x-ms-traffictypediagnostic: DM6PR12MB2859:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB285966348A2B7662ED68F67FFBA39@DM6PR12MB2859.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YhOR69dse/y8k1ZnKSR0MuYX/KPEz+oBNu8x60SnYLeZe6A5Fgy6FUdzpd59bGDLjQ+OlcL6RX04Vfop+ybbJYjx2ZGMBBtiRY0O2qPqup8YV+zdrfcwYFcGVMvdV264Br5IlSWyo1JA9uEHVWlSFXFUGYeV0NvB1HTZ80nfrxGzkSrySQvCUWuTBiW3TzNxEc7Ec7N3w1qhpFZwvL4PNiaW7aQ/PKoLYZ2wOUc3NX9tv/3zLmjnzK/dVlFzNSFmxFijnVOGrwxLH0MutrwO4MH8d81MqXqetBldzbT7QvhkOwAICtzkawwVunkz32NRlpe9GSNkWG5LVcfS8ZrbPnICRU2oSlOtXan7pdtKeAHzpckq9sEA7PV/fi4vdiNUYFyoEgqgspSmQZLm3HcQ+3g8wF+nWZlGhh+B6M4PugraZYz4Ekwt9fnUyqK3IoIRZ2SP5BrgOctHGdZGaic0XRXNTPmboFoIbVYs7En+RLkracJsEnbxPUstAhayZM5mh4UEs6/AIRs/vb9ab/qu+i0wTf2KW5kEH95oe5uml9Q2/eVM5jl9HmJazlcSUbO7Jp+p7Lhzn74jV6MdiORqVWyyR3YLsx2OPOsMsRMXVemO4ozpt2LxT2Ao4W7i+IY+ZHlg+OoYq1MMjl0ptmhDeSAft52YBrP0+qbpbsLEl4bHUA7tfOYqtgbgW4sQomGo9rkpYAZOoT0VlV8l7kInxQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(64756008)(76116006)(110136005)(66556008)(66946007)(6506007)(66446008)(7696005)(4326008)(71200400001)(83380400001)(5660300002)(26005)(508600001)(66476007)(8676002)(316002)(33656002)(52536014)(54906003)(122000001)(55016002)(38070700005)(86362001)(9686003)(8936002)(38100700002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUVmcW45MXZxNGk4eTFEdXY4Qi8yMTNtVXJFWXNKN3piQ1V4bnNLYXZlbjJM?=
 =?utf-8?B?eFcySk9XNmZwWHA1TXNzSnM5RUFiQ3hOdnQyRUFleTFsdFZ1Y1ovWlc3Zy9N?=
 =?utf-8?B?T05LdG81K1YxZXpySWlDYWVPa2Zkc2xnRFk4bXVCTDFNcFRBZmI2a3QyMHMz?=
 =?utf-8?B?cDhVZUVrdktJek5JVnZLdStGdTFZYVBOTWoxRUJWSDN2OHNEb1U4WlVuamtZ?=
 =?utf-8?B?VE9JMHhFOVNSUERiYWlyWkpaRW42ZFVuRm05U2hReEtINk5VU0EzemZXQTJs?=
 =?utf-8?B?Q0FPQSs5QU9xU3RCVlRMTU9SVS9NT2s0VWc0RkFwQkxhN1hZOFZsWm83U1RS?=
 =?utf-8?B?VWZNeEZrc01jajMrUkJmcC9kVjh3eGZ6UHZzOXZWV3FLN0VaNTJyQXV4ZWlP?=
 =?utf-8?B?R0FweUE1R285Y0hLajdnck5Od3cxU29QeXlSZ0RhNEV0c2lUS1BGZFFMUE5H?=
 =?utf-8?B?ZHk5SnNMWStyU3hBZ0NzR0dLcFFQNWFZUzQ4bkdxZU5nQXlCNlRWa2RObHIr?=
 =?utf-8?B?VlBSRXUrc1pvbGsxZ3EvMy90dnBQODRMd3dCd1ZEWW5MS2NJVGMrQ3JpVk9O?=
 =?utf-8?B?Z2NESU5EK01jbHkveWticXFNYy9JRnByZ2QyVDhQYmh6OXNuQ0sweVJLdnI3?=
 =?utf-8?B?b0t5Z00zMTAxN2tleTNHRTBZaVlWMHNiNnhEV29oRDNYSDJnZkY5STVHSHY4?=
 =?utf-8?B?cGQvNVJDSjJVL1R0dXVhT0I5a2Q3Ykg4cFRuUWNvV21va3Q4RzBYQkY5YjBv?=
 =?utf-8?B?QnA2MnVFTmRRdnZVUGtVQzhUWFJySXNjMDU4M2lINytGbjBVclhibUVxd0wz?=
 =?utf-8?B?aWNZMndHZVErSXpnekg4R0srektjWE56ZDdSWDFDMGdKeFJjS1pHMFplQ0JG?=
 =?utf-8?B?RGxFU1dWYndkUDdPVXY0YmRWSjN4Y2pKcnhCMldqdXByOThwZVNSNEZyc0N6?=
 =?utf-8?B?UDdGOW9xWnIvT2xOUC8vZktSb3dISHZ1Vzl1ZEZ0dTl4RWJUMEhnZHB2K3BY?=
 =?utf-8?B?eFFpaDRyWXIxbGllVWxvNHhpWnRUUE9aOGN6cnFIL1prdFNGRmk3VzNYRWZn?=
 =?utf-8?B?SWxqaHh1S0xyTTNTTWh0cmVsKzNVT3NBR3NIVXdSUzYyRTZmMDFtS2lNMGt2?=
 =?utf-8?B?dXJlTnpxSVlHL2c3UmVQQTdHSk8wRlRwZTBqSllIYy9PdWk0c05EKy90RTBs?=
 =?utf-8?B?aGpDS1pFdTRjT2ltK0ZEa2JGeWV2cXZLeXdTalg1cTNQY1dPYkJBSE82bVNU?=
 =?utf-8?B?MWROQ2pDckZTa2hkbFl2cXYyeEZYWWdXYTFPbW9OMUpBSGxKKzlvMlNnYm9Q?=
 =?utf-8?B?NURhN3NWa0lMcnE5b2haOUxGa09SZzFQMWMxdEhqaVNSUUtFQWx4Q3pDUGV1?=
 =?utf-8?B?aGhMeGxGcEJ3ZzVlbDljVVltK3hCNFhnN1YyT0NGdTQ4VWZHemttcVplQUhC?=
 =?utf-8?B?SXhSdlh2NnB6U2tLeGxlOGx2b2ZOYkZGR2wvdUxoWCt4eGNvdnF3aXZqTTNP?=
 =?utf-8?B?SmswZVdaUnR0TklvY0lsaGwyUEVwWkZhSlEzZ2thQ05QK3k1ZTZnNitUeW9I?=
 =?utf-8?B?d3JsdkRtSEphOFNkZG9WbmlsVGVHT1BFd3p0MWdxK3Q5MTRGM01DQU5pS09v?=
 =?utf-8?B?ZWdDTkpwTERqY3FDN3NMU3pUTjFFcGQraEFFbmsvQ0ZNNHdKVjJqbVp2bG5W?=
 =?utf-8?B?NTl5dTByUnVwSlBGNXNGS205K2JYWmpCenB6RUxweU13Q3RUZWYvaW9NdW9i?=
 =?utf-8?Q?mHEQanOw9iJ51r9v1eDHfC/MMwuEYmGHe0SyIZb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55de0fab-85e9-431c-a28c-08d97e8b0b07
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 12:09:49.8736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UKVR+cPwKKqYj/zxVn8Desem75/vEuV+nEPikwlQW8GS86ArR9aakAz0apxlTP9jurqys/bJZnX2weB7qzN6YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2859
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+
U2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyMywgMjAyMSA3OjQwIFBNDQo+VG86IFl1LCBMYW5n
IDxMYW5nLll1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPkNjOiBL
dWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBDaHJpc3RpYW4gSyBuaWcN
Cj48QzNCNmNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT47IEh1YW5nLCBSYXkgPFJheS5IdWFuZ0Bh
bWQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9rZmQ6IGZpeCB0dG1fYm9fcmVsZWFz
ZSB3YXJuaW5nDQo+DQo+DQo+DQo+QW0gMjMuMDkuMjEgdW0gMTE6NDQgc2NocmllYiBMYW5nIFl1
Og0KPj4gSWYgYSBCTyBpcyBwaW5uZWQsIHVucGluIGl0IGJlZm9yZSBmcmVlaW5nIGl0Lg0KPj4N
Cj4+IENhbGwgVHJhY2U6DQo+PiAJdHRtX2JvX3B1dCsweDMwLzB4NTAgW3R0bV0NCj4+IAlhbWRn
cHVfYm9fdW5yZWYrMHgxZS8weDMwIFthbWRncHVdDQo+PiAJYW1kZ3B1X2dlbV9vYmplY3RfZnJl
ZSsweDM0LzB4NTAgW2FtZGdwdV0NCj4+IAlkcm1fZ2VtX29iamVjdF9mcmVlKzB4MWQvMHgzMCBb
ZHJtXQ0KPj4gCWFtZGdwdV9hbWRrZmRfZ3B1dm1fZnJlZV9tZW1vcnlfb2ZfZ3B1KzB4MzFmLzB4
M2EwIFthbWRncHVdDQo+PiAJa2ZkX3Byb2Nlc3NfZGV2aWNlX2ZyZWVfYm9zKzB4YTMvMHhmMCBb
YW1kZ3B1XQ0KPj4gCWtmZF9wcm9jZXNzX3dxX3JlbGVhc2UrMHgyMjQvMHgyZTAgW2FtZGdwdV0N
Cj4+IAlwcm9jZXNzX29uZV93b3JrKzB4MjIwLzB4M2MwDQo+PiAJd29ya2VyX3RocmVhZCsweDRk
LzB4M2YwDQo+PiAJa3RocmVhZCsweDExNC8weDE1MA0KPj4gCXByb2Nlc3Nfb25lX3dvcmsrMHgz
YzAvMHgzYzANCj4+IAlrdGhyZWFkX3BhcmsrMHg5MC8weDkwDQo+PiAJcmV0X2Zyb21fZm9yaysw
eDIyLzB4MzANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMYW5nIFl1IDxsYW5nLnl1QGFtZC5jb20+
DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9n
cHV2bS5jIHwgMyArKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2Zk
X2dwdXZtLmMNCj5iL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1
dm0uYw0KPj4gaW5kZXggMmQ2YjJkNzdiNzM4Li43ZTY5M2IwNjQwNzIgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMNCj4+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPj4g
QEAgLTE1NjcsNiArMTU2Nyw5IEBAIGludCBhbWRncHVfYW1ka2ZkX2dwdXZtX2ZyZWVfbWVtb3J5
X29mX2dwdSgNCj4+ICAgCXByX2RlYnVnKCJSZWxlYXNlIFZBIDB4JWxseCAtIDB4JWxseFxuIiwg
bWVtLT52YSwNCj4+ICAgCQltZW0tPnZhICsgYm9fc2l6ZSAqICgxICsgbWVtLT5hcWxfcXVldWUp
KTsNCj4+DQo+PiArCWlmIChtZW0tPmJvLT50Ym8ucGluX2NvdW50KQ0KPj4gKwkJYW1kZ3B1X2Jv
X3VucGluKG1lbS0+Ym8pOw0KPj4gKw0KPg0KPk5BSywgdXNpbmcgbWVtLT5iby0+dGJvLnBpbl9j
b3VudCBsaWtlIHRoaXMgaXMgaWxsZWdhbC4NCg0KSSBkaWRuJ3QgIGdldCB5b3VyIHBvaW50LiBJ
IHJlZmVycmVkIHRvIGZ1bmN0aW9uLSJ2b2lkIGFtZGdwdV9ib191bnBpbihzdHJ1Y3QgYW1kZ3B1
X2JvICpibykiLA0Kd2hpY2ggdXNlcyBpdCBsaWtlIHRoaXMuDQoNCj5XaGVyZSB3YXMgdGhlIEJP
IHBpbm5lZCBpbiB0aGUgZmlyc3QgcGxhY2U/DQoNCkkgZm91bmQgdHdvIHBsYWNlczoNCg0KCXJl
dCA9IGtmZF9wcm9jZXNzX2FsbG9jX2dwdXZtKHBkZCwgcXBkLT5pYl9iYXNlLCBQQUdFX1NJWkUs
IGZsYWdzLA0KCQkJCSAgICAgICZrYWRkcik7DQoNCglyZXQgPSBrZmRfcHJvY2Vzc19hbGxvY19n
cHV2bShwZGQsIHFwZC0+Y3dzcl9iYXNlLA0KCQkJCSAgICAgIEtGRF9DV1NSX1RCQV9UTUFfU0la
RSwgZmxhZ3MsICZrYWRkcik7DQpSZWdhcmRzLA0KTGFuZw0KDQo+Q2hyaXN0aWFuLg0KPg0KPj4g
ICAJcmV0ID0gdW5yZXNlcnZlX2JvX2FuZF92bXMoJmN0eCwgZmFsc2UsIGZhbHNlKTsNCj4+DQo+
PiAgIAkvKiBSZW1vdmUgZnJvbSBWTSBpbnRlcm5hbCBkYXRhIHN0cnVjdHVyZXMgKi8NCg==
