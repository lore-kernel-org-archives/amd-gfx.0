Return-Path: <SRS0=g6Hj=N7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D08C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 05:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D11E61178
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Sep 2021 05:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D11E61178
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAA4E6E14F;
	Thu,  9 Sep 2021 05:54:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2D616E14F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Sep 2021 05:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAmcdzLUVCJarMYLHQelkHnPzhYxymYZhIBQAcwqIxLfEICHxR0n1XCEn9eYZtDFNXEaYr+e1VT6HPdq7GdqcDmHfeMPOlZgz+KHHS76bQEQZ0jVYNAMktGuP4tNE/4QooZT+oVeK6EHHTzyTqFzXvlJyhNiZf6vS6FE2S03XaCLwZpTO1ZyhsuKGj6+mPcH0/YA/tysbck1JBMQItYzvb/OV9DIXvR3C00qz0E3HlkCmzf31ObJSz5DjhCpo6Gz8v64udYMmrmCnCPUBoptQ38GAzVIpvBBY/EevNelIf1LLcUvBw/ssLdO+LqNFepnyU7ydnJuZuNR8Qkz0JOiag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ZFc4Z2wSD6woI1BgtPbGTlnTAfC1NuzRC/+YeMZoswU=;
 b=GSNLfUsdMsqiUGLgzFG2Hy1jk0fvR16C2tvDWGqg+Mjo/ZCMzqCF4u/fYIBuLfZGXe/DWTqXvkcc39qC74WMIy1xiz7hX3MZn7XxfdOtCPcD6m6MSqt8bCpWd5+G0223wHcZenEgNHKj/nqqhjpnZroy8E1L2bcE6B1uDaF6jq5Y8p04+2+9pni2KqB5zmoF0pPFK5cGTxrnos7w2oOmnegiZ20WExnOLU7XYflxv95clWz+KH3qjt+RXp3GP6OwFrc43l0eImmS1yUvqHZ2fhBIWboC5zRbaozwXtMtnv6O0/3mtPF6TK4RlTQRXxuKKnFEco2bja2OcyyIpg5mdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFc4Z2wSD6woI1BgtPbGTlnTAfC1NuzRC/+YeMZoswU=;
 b=pyBNSPKEajWOpuTtq9RGCn31sisvPg7UvqEDR1zMT/Y6SnLgZBVNkY6wQe2IxKVG+fqpU8NnTzXlUez/4aGlhuazBYJyna1KRPIgI/iUOZ2tujnArc/fcZ3LVmGv6MFZhq7pAnmtE72v9Y4aniybmd7ahKY8yq/K0N6n4IRM4OI=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5341.namprd12.prod.outlook.com (2603:10b6:5:39e::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.22; Thu, 9 Sep 2021 05:54:11 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::79d6:3902:9bcd:37ca%9]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 05:54:11 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Increase direct IB pool size
Thread-Topic: [PATCH 1/2] drm/amdgpu: Increase direct IB pool size
Thread-Index: AQHXpT8MSA2RqCNT5US18UJVCGUmXg==
Date: Thu, 9 Sep 2021 05:54:10 +0000
Message-ID: <DM4PR12MB5165BCC3E4E26C7EE4E85F3B87D59@DM4PR12MB5165.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-09T05:54:10.664Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: bb712622-de08-c05f-9b29-d033e14040bb
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc853bb9-ff2f-4434-eb79-08d973563f09
x-ms-traffictypediagnostic: DM4PR12MB5341:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5341995618AD3ABDD441060987D59@DM4PR12MB5341.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BEjrVQO08FdDIp4pbnoiNtaXRZdZs/snAJt6KJX1UKj4m3igU9tTX6Y6yY0ie06TMuWoczERtlLUkgEEEF3FezNisfG9uhzWXovPp2Hy/kstRlkOfBEGMj3FaWZ8furHn51ftZ2KmqgqD0tIgu+3vGkP/dBf/5i9MLsylC1isuI4iBNe9HWqANZVI4/aHQ60GbaWYwPd3mHg/JA110+wi5HpG+IkYnjFJdBju4aKc4aWBWAE1lFOVKKGoQwPgZiPx4DKo5nYxyX0nXakkrqvAwejb9lEesInkerGx+BMexcFAhgx0iahZcPjoYHMZwMm2g6cHsoHaCMkOaudb/uFIeypDNHQdf55NsaxZNkDamgDBpJ4wwqr8xks+7lpjhaHmUj29FZAh1GwMJPqlnJY+HNsSNSSG7MISl960z63gMMeA1qq9q3Yj3kbAGSER3/DVDx8rLRLo4JGeIxEK69qbXaqR6aDSTnkrrFoL/lRlu4fSFcUEEjv+JHCxE9Ia83oJbUJTNemSvYfw28sjpGzK6Vr05saqhoeE5echrNrjdRyGjXX6LWFHQh7Rtw6lkkfBfDq9X+gbyTe2OY9eoslS2+l71cPzp71vfkYWvlbw89Uvw03x/NFm7qm9EyVQ1csuPZwLXtfGHVRPiviuM4+SgFVNOlnVJR3gx4dMmQ+aQT/mvNhXrE5ZBFU2txJFCDaeFInjzRYgLGR2NPeULHnaA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(83380400001)(71200400001)(186003)(86362001)(316002)(91956017)(4744005)(54906003)(26005)(5660300002)(38070700005)(55016002)(8936002)(6916009)(4326008)(122000001)(9686003)(66556008)(38100700002)(64756008)(76116006)(66476007)(6506007)(66946007)(66446008)(2906002)(33656002)(52536014)(7696005)(478600001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TEF2WUVQUk9JbHRjTW5SSStBRFB2S1pWdkRwNERhOHpSUTd4THVSaHdxZ2lx?=
 =?gb2312?B?V3NyMk53bForUE00OWUwSHBJWHRuTzNuQ1dEZUllelJ3QmU2b1VkRlRRT2VO?=
 =?gb2312?B?TC9Md1Y5YUJHNVlxd0JOMW0xV2swNE56R0diSmVFTTIxbGc4ZUpGZHRpRmtp?=
 =?gb2312?B?RHBKR214RnN2aDJaZlczWVpvQmhxRzZCR1RyblpxRkRjNW1ZcHZ2SGRDK0I2?=
 =?gb2312?B?YVJxQmw1N1BmRitiWGtoWTF0TTVmU2lTZ1doVFl0Rmptc2hIL3JmK202dTIr?=
 =?gb2312?B?ZFg3Nmt0dnVsNlN2elY3Z0tLTmJZUXVBdmIyZlcvaFZCYjhIdXBnQUYxSTZN?=
 =?gb2312?B?bU4veno5d1NFNTVKSkhPTzI4UXJlVHk4Y2NFZlEvVC9nVzNZYUV5bWhSSzlj?=
 =?gb2312?B?dVVoNG0vTHAyUmt4K3pLeUtORjVGN0liSUdnZTkvU2lEV21sZ1ZmOHpmWnQy?=
 =?gb2312?B?V3VNNHFlbGhaRlJSRG9ianMxejhvaGlTTzk1TkJNV29oSHltdm95dzhzVDZQ?=
 =?gb2312?B?RmNiek5sMW5PS2lQUFNMN0VVV1laMy9HdHFsQlgwTE1PYUtCTzZBTUpFcVpI?=
 =?gb2312?B?Q1FBL2dicUtTTmlWckJaMWM5TTl3d1UvYnN4TGFJRDkrY1JrU28vQmc5VXZO?=
 =?gb2312?B?bVNIdnZ4bmpUV2xmMWtoNTVnV1FTS0pTQkd1MUFXeHZUbVBmd21xNUZqRUdB?=
 =?gb2312?B?dzdyNDBQSmRZb253aXlQZGN3VWowSnlEdFNkYzVmQXBRMGVSNzJYY1c2WU9w?=
 =?gb2312?B?THVXM2ppaG9IMGZUcmFxZnFFdlJXdExPaEx3akRaSFd0V2JRM1ZIRnZpUmkr?=
 =?gb2312?B?TkE5WlZ5OTNoQy84NnVWeXA1VlB2YlhxVjFOekZNcHBNRmFkZjREdFMvYzhM?=
 =?gb2312?B?VEQwU08rQUlXY05iZGJzL3o0enU0VWlPL1hrTnRKTmZnQ0RlSDBLU2pVSVFa?=
 =?gb2312?B?WjAwMms4TGZWZVhRYllLKzVhekkzclZOS0xYbkFiR0tXS2VpTjhxd2RjZFpo?=
 =?gb2312?B?NVM0Z2UreFBFQ0Vna2VGeHExYWo0Y2NibGt0NGhXY2xyTStmYkN0anoyT0Yw?=
 =?gb2312?B?Q0d3cWp2Nlc0VWl5ekJFVFg5a1JrRlVuWkljZmVyb3NTVWxYaHU1WlVrblVj?=
 =?gb2312?B?SXd5UDEzZUtlZHRGWG96bEZjTTk2a2pnYjVzUG5FRFFKOVZiSm9HT2h2YTBh?=
 =?gb2312?B?cnhUU09MK0RRdUZRWjJua1NOVkh1dk9nUXcwNElnUE1IajM5RGl5TUhudWRn?=
 =?gb2312?B?NkNvd3hrM2s3YTFpVEpqaVZNWDZwSU0wbVZKQjViNklFRmNCTkc0YXl6eE5U?=
 =?gb2312?B?TUo1QUFqNUdUTngwSnMxUjY3cXJrVGhpSDR6dnJ2VUNoOTdsUE9MV1FvaU9r?=
 =?gb2312?B?bUZpVGE3Ukdwd2ZVQzJKdEt4bC9ZeDZ0WDNYWWZyYnU4cHR6d0FTS2hGdC9v?=
 =?gb2312?B?VFNFcTNRTG5EMjEyYWxHZGFFbnk2UlZWU1oxWkw2YTFYZWtTTXR1NC9QaHR6?=
 =?gb2312?B?eVpXRC9ERXdpVFhuVlF2RitXOTNMMkorZFBWV09DM2dCbDdWaldqYUVNbW1x?=
 =?gb2312?B?Wm5vRmdwZU5oak9PRDR1SE9DZFF3OGc1N2M1eUlKcFliSWMySC8raERmeUgr?=
 =?gb2312?B?SitPTjhHUklDQVE5RGFQSzd4WGlmT3NUU21FUHZRTkw0ZVN1THRFai9vNDBO?=
 =?gb2312?B?S2crYnh6bzRCSGRHS2lEVUtYVGNyNkhHbG9VNEpZTm9OTUxndW9oOE96WC9C?=
 =?gb2312?Q?05Dakvc8jxCoBt4yf2eFMBnO8Wqkwp+vC6E6Cs5?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc853bb9-ff2f-4434-eb79-08d973563f09
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 05:54:10.9272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ZeS1keKQJHVOFlsvZoez1X14JkTfrwyoY24dsJGItdJtTWf1L6O7qyuKdo4ogZP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5341
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KRGlyZWN0IElCIHBvb2wgaXMgdXNlZCBmb3IgdmNl
L3V2ZC92Y24gSUIgZXh0cmEgbXNnIHRvby4gSW5jcmVhc2UgaXRzDQpzaXplIHRvIDY0IHBhZ2Vz
Lg0KDQpTaWduZWQtb2ZmLWJ5OiB4aW5odWkgcGFuIDx4aW5odWkucGFuQGFtZC5jb20+DQotLS0N
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYyB8IDIgKy0NCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2liLmMNCmluZGV4IGMwNzZhNmI5YTVhMi4uY2QyYzcwNzNmZGQ5IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2liLmMNCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5jDQpAQCAtMzA4LDcgKzMwOCw3
IEBAIGludCBhbWRncHVfaWJfcG9vbF9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0K
DQogICAgICAgIGZvciAoaSA9IDA7IGkgPCBBTURHUFVfSUJfUE9PTF9NQVg7IGkrKykgew0KICAg
ICAgICAgICAgICAgIGlmIChpID09IEFNREdQVV9JQl9QT09MX0RJUkVDVCkNCi0gICAgICAgICAg
ICAgICAgICAgICAgIHNpemUgPSBQQUdFX1NJWkUgKiA2Ow0KKyAgICAgICAgICAgICAgICAgICAg
ICAgc2l6ZSA9IFBBR0VfU0laRSAqIDY0Ow0KICAgICAgICAgICAgICAgIGVsc2UNCiAgICAgICAg
ICAgICAgICAgICAgICAgIHNpemUgPSBBTURHUFVfSUJfUE9PTF9TSVpFOw0KDQotLQ0KMi4yNS4x
DQoNCg==
