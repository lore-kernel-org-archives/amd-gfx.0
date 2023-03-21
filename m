Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C4EC6FD20
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 19:46:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2903710E2E4;
	Tue, 21 Mar 2023 19:46:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D080510E2E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 19:46:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNdIbpv3n6X30Kpsx/CWANe7541kaFfPPUErkaak2bSipBb4umQYe6FV6kf2JDwQ0zX/+c+tQSbs9OxLyWhhzngcDXZ1FyiwDF9ayZ5LeZtRAjVGOj++OA9nK1Bh5h24LC/Ej/CyTU/7C9B7h4NnzMvzfyQ3xhnZVT3ibI78rT4JQdUhXIMahnVrrSjTPzz31Ks+3jZQx021muLQhCa4OMjDS6NplSgb8sW4J0/Q0YuEVdCuvaPLY7ylY9hiJN15XrlXlHWWm8iCY9Q6HqIyD23sMuJ8KFNOgU6mSALNqPos/t6U8mnshNpeMtAHGlIVUI6Q67CQgXmbuHSE+A4v3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJNRuTSRgMj9aHjBSqhugYsV8DfZS0O3Da6ayFxAXH8=;
 b=R8YGaDLs9kkJzDms4tIe8n5nGLp+hsScL+dJWwYdxGCOlkOQkuOesHdvJBngxpHUVLrhUxJEpTYS9i0CAXIDOlIBhsU/rS23oZnugeVaZ19NiannRLncU3lhQz2yJgm+Wu0qd8lobYBV3TCZihEgt/sBhNzL9b+35txtGcxZeaJl0F5CySuCDkJGjgzbrcRReQwz0KyXAwKX214zrd8gehmNuuTLD+LkdMmnv1vVi/2hFbkhtDKSuahFLMgN4NFmqvttnVXAWYINbqJ4DME1hM5PTPHhaaqPlZqmFVUAB+KmujS+GrdAhcWoJ3dpWzSyAotLp/nHFgiIAn+9Toy5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJNRuTSRgMj9aHjBSqhugYsV8DfZS0O3Da6ayFxAXH8=;
 b=aOJKN6XGWY6Nu82chew7SNeiyKWTv0UXDEiYX1nDVko+5ewMyLVP+P8/KQwFZSsr1WLuRODoDYjMjPIOWj+GYG8c+GHLi/lSAuRgZUyTHr8faN78ACZ28KADFG8I+9GkpJcsdR0v1zzb6CryYZqk7/q0eIPFjSceAqs4/MllOaY=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by CH2PR12MB4907.namprd12.prod.outlook.com (2603:10b6:610:68::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:45:58 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::4d0e:a57d:65d0:1e63]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::4d0e:a57d:65d0:1e63%4]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:45:58 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Russell, Kent" <Kent.Russell@amd.com>, "Mahfooz, Hamza"
 <Hamza.Mahfooz@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add print for iommu translation mode
Thread-Topic: [PATCH] drm/amdgpu: add print for iommu translation mode
Thread-Index: AQHZWQl3ZeT22psvKEmGWALdAzvmSq7/Y3MAgAAABwCAAACckIAGNnQAgAAN9uA=
Date: Tue, 21 Mar 2023 19:45:58 +0000
Message-ID: <DM6PR12MB30670BD673199DFF243972158A819@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20230317194757.1336098-1-Graham.Sider@amd.com>
 <0509601d-8d7c-26e2-26c9-8f4757a92ca2@amd.com>
 <DM5PR12MB1308BF656CB0C75BA0B9CED885BD9@DM5PR12MB1308.namprd12.prod.outlook.com>
 <DM6PR12MB30674A9D4B81185DA913A2278ABD9@DM6PR12MB3067.namprd12.prod.outlook.com>
 <5c9b1fc6-d404-a5ef-b89d-c02de7603644@gmail.com>
In-Reply-To: <5c9b1fc6-d404-a5ef-b89d-c02de7603644@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-21T19:45:56Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=6bfae432-1924-4dd2-9eb1-c51a81c02adc;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-21T19:45:56Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 0fdd41d9-fc79-4a8f-9ed0-a4541e9c2563
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3067:EE_|CH2PR12MB4907:EE_
x-ms-office365-filtering-correlation-id: f9440037-6957-487c-db85-08db2a44e487
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZrgjT7xmkGAvmRt8RRwOlvbBZY7JthA1QoInQeGG9Qd/wANQue38w9xvwSMZLsy/sIAcjndIlK/22H8zV1tgTQb3IvQNbRdhEt8LoeizW/UjZb4v32a1c7/TBHUJd1+qA1lAchk/WKUW8NEeJpVFZJ+ZkLn9jq3Xvgk+EbHDz3CeadQx9wUVXb524wFhFoRlzI6JJywlgzU3MFopMvFGBE2xzhe2VnhcRwnj0lGKFglJVsS4Hxj7Ap/0VG1l1TvKRcviTwIF3dDvj5waasB2uVdCKeOKY1v7MX2uTMGKoqIsGuDQCh8NPzfvQOOW+nT4QYycDfftNzDras89Ub+tWDzfmoP4VBGtwuWxY2e/d4LI1Wrs9SfjCnIaLTEMCxslSoZCdaN7K0nhL8Qix0Arji7cj8Rwi3mzfNRKXSBAP0hSvrre1ou9u1XRyQDHjL40JALYDwpaLZRzoMQp5oFXfJ/fRfS7gAfsy/FvpFyBv4PKAsuHQDhIPOrLqWuB4+Q+fmOiWgbKPg29a1UPc1GvCE/uExNc0SvCNqx1lNweTJqJjU8sINBVGE886ZGV7NPNbSgLaO3QJWlJDttWU9tB3xWcokgpUeJOMN2ndHejxQ/KK4ZXBjPCv25/CLUUha4Bf/2FHedjKRlCIr44SzBqxoYI8G552bzMzc9b+/xsroIx6E9jtRfsqBnwJJ+B/bC9vDwHyuyOSNyJvMcYVh/J0w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199018)(66574015)(110136005)(71200400001)(7696005)(38100700002)(316002)(33656002)(8676002)(55016003)(66946007)(41300700001)(5660300002)(8936002)(66556008)(4326008)(64756008)(52536014)(66446008)(76116006)(66476007)(2906002)(478600001)(86362001)(122000001)(83380400001)(6506007)(38070700005)(186003)(53546011)(26005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1V2bmlWOE1ic3lJUG4zcEdNdkVRMUl0TVVEL2poKzUxWmRkeThKV3JWVXQr?=
 =?utf-8?B?UkZkOGw4RVIwZ3piUnExOHMyWGRVZVFwU3RiNDFJY2tjaVM3OUdFODFXb3Np?=
 =?utf-8?B?akovaHpnb1kwczFSSDNsRkZIUDlyS0ZjR3QzYlpXZkR2N1BVanZNWWFhY3Bi?=
 =?utf-8?B?UURNY2RLclFhZC9PSU5xNklBcmsxVkVIRDZkSkRSMzJzdmRnQ1J3RmJoRC8y?=
 =?utf-8?B?K2x6azBCbG9UWmZ2NzFsZXNmY01Ob0pEZHIwN3B6dkRFSVdhSEZrM3dkbGgy?=
 =?utf-8?B?OVRJZUFqMk4xSzJUMmpFQ1FVbWZsa2lZSzJWKysydVlocVRPUHhEa0c5alQ5?=
 =?utf-8?B?VUxxcUtDSkx6Ym5QY0VZdlBZS0ZGYS9XUng1ZW94clFndUw1em9SRDBwaVkv?=
 =?utf-8?B?K1hiS1JCbHBOcnBOdngzdEpucXR0OUxySmk1TUJRTWtMRnljaHpzRkJ3VnF3?=
 =?utf-8?B?ZUtrTTE4OGxxY2VIbmFzejdiSVpHeW5WbG1Sc3ZacUtVYWI2dHBNRSsyTStQ?=
 =?utf-8?B?SjNSZWU0Um95cTd5ZnViWDMrbWFpdjNwOTFzWEJaNkR3VERNajRSRTJCQzNB?=
 =?utf-8?B?V0lXbWlGQ3o4czRrK2ZiOXprQmloSU5ML3cxNlpJNGUwR3hLck1tT3Z4MUdG?=
 =?utf-8?B?MVlsUUVBYm10eWRyQmk0b05aQTJPQ3RvSHVDRG9QRE9BRjFDd2ZIUEFvcmxn?=
 =?utf-8?B?TS81UVBXV25LZ0tXemNtcitKaGVQL29UUDBlZm9JMFZwWVAxWnk4eTVRaWtn?=
 =?utf-8?B?ZEtlbXJTVDY2WTRHNHFvdTJIUVltRzBMclA4YXZQK1k5d2JyYlNiaE9PZndZ?=
 =?utf-8?B?UURyQ3RUVENza0ttSnQ4Q0t2dU1HVE9ScUtLZDVGMUM5dFBhb0RKbVRuczRX?=
 =?utf-8?B?VHF4ejdtTjhxTlZNSXJ1QU8rbXI2YUE3cFlQQ20xZ2tPck52YW5MYkpYSnVz?=
 =?utf-8?B?UlBNSzQ5ekxSdlorMDVqamVwWWkwZGtVUUJEMDBNMVRNSVlVeURWVFp6ZlJO?=
 =?utf-8?B?Y2xYVFREY0RwSHRaUEF5THl1Z1hxVTAxT0hKaWJrMkdseEphTWc1QnNCK3Z2?=
 =?utf-8?B?WVczT1NEU1pHWVQ2ZHhvaXd1SlMvNUtvaklUNWhxbG9FTmZ2QWJGeG1UUWJN?=
 =?utf-8?B?ZlBrRWhwR1U4RUg5WnRwR2tQTFhuQ0l1cFdxWUkwYXlYa0xDUDZLU2NBaTc1?=
 =?utf-8?B?MEJWbXM4aGtWd3kydXhNWVNzNGhsRkJjeXNEUk53OWpZNXduTXVRSS94c25n?=
 =?utf-8?B?WXZOTXk5Njl5Z0dackRaemp2aVVYckhvQU9WZUY5NzIxZGdMK0tFZzg3MlF3?=
 =?utf-8?B?T1AvVjc5WjJFMk5VT0NLc0dhU1NOZXRZbVpEQkJQRXJhdStPTG1tUzhrRnVs?=
 =?utf-8?B?Sit1ditydTNhKzdnVFIzNDlGdVZNVTlkemhHcVkwSzEyQmNHRHFDUjE5ZlY5?=
 =?utf-8?B?QXN6dmd4Tnd0dzIxSUVNODAvWFJGQVQvVlcrbnRuaEpjVHR0RE9kUTNHMnlW?=
 =?utf-8?B?QkpPdnpBQ3RsWllwTTVUY2twdnpZZEl5aStZbG1FVkVGZU04RHcxYUtoZmt0?=
 =?utf-8?B?Nnp2T20wMW5xeTR0Ujg5SXhiWTMrdEMzYkxha1lFci9uNGlKMHhyNzBmMDJh?=
 =?utf-8?B?SHE5UGxHZ0lrRmZCMzBKTkRjakdVN2pOSUp4SjltR25zcVNpNWNzTEpncnFx?=
 =?utf-8?B?ZmxoWlBJN2dLazhYQXo1UkpmTHJCTytoMDJ5Q0t3UXlUTnp6VWR3bUloZG5E?=
 =?utf-8?B?OFRvTGo4ZGhzWVNQWElvK1YyY3ZPZkVKT0Z3K1NvUThJQXUxcTVqY21kcExC?=
 =?utf-8?B?Q2FIZ25CRFJhd0pGdEdnS2dOYUdMaFIwc2tXSCtGZktNcFNrUDh4dU1aTzB5?=
 =?utf-8?B?RmpveGtHRDRBRXpkT3p1c1pkMExkQ09ZZFhmT29rMzdNeUNPV2lXclpDRkpz?=
 =?utf-8?B?akhGTCtha0d6T005SWNSN1E4aiswSWJteVpOS3NxeXZEeFY1dWJjWXRPUXVS?=
 =?utf-8?B?a2FqOVBUVjYxelpYYUNsdXZYemYvSnYzWEhPUlAyaWVoYUJnNyt2VFppeWdp?=
 =?utf-8?B?eFdnNUtUS1Y2cmlYQU9MR0M1QzFGVXo1eXVLOHFmU2lZUDhGYUwweHQ0eFYz?=
 =?utf-8?Q?tWls=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9440037-6957-487c-db85-08db2a44e487
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 19:45:58.2996 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RlLLx6iTnHi4pxIsB67d3ra4I2vRrOmH85Jg/gdIqovGroaKNFfXq0P01gTGhn8CLdHMev0bxRqQk6fYY5/9ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4907
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaHJpc3Rp
YW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NCj4gU2VudDogVHVl
c2RheSwgTWFyY2ggMjEsIDIwMjMgMjo1MyBQTQ0KPiBUbzogU2lkZXIsIEdyYWhhbSA8R3JhaGFt
LlNpZGVyQGFtZC5jb20+OyBSdXNzZWxsLCBLZW50DQo+IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT47
IE1haGZvb3osIEhhbXphIDxIYW16YS5NYWhmb296QGFtZC5jb20+Ow0KPiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0Bh
bWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBhZGQgcHJpbnQgZm9y
IGlvbW11IHRyYW5zbGF0aW9uIG1vZGUNCj4gDQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmln
aW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyDQo+IGNhdXRpb24gd2hl
biBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4g
DQo+IA0KPiBBbSAxNy4wMy4yMyB1bSAyMTowNCBzY2hyaWViIFNpZGVyLCBHcmFoYW06DQo+ID4g
W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQo+ID4NCj4gPg0KPiA+DQo+ID4+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFJ1c3NlbGwsIEtlbnQgPEtlbnQu
UnVzc2VsbEBhbWQuY29tPg0KPiA+PiBTZW50OiBGcmlkYXksIE1hcmNoIDE3LCAyMDIzIDM6NTgg
UE0NCj4gPj4gVG86IE1haGZvb3osIEhhbXphIDxIYW16YS5NYWhmb296QGFtZC5jb20+OyBTaWRl
ciwgR3JhaGFtDQo+ID4+IDxHcmFoYW0uU2lkZXJAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+ID4+IENjOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFt
ZC5jb20+DQo+ID4+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGRybS9hbWRncHU6IGFkZCBwcmludCBm
b3IgaW9tbXUgdHJhbnNsYXRpb24gbW9kZQ0KPiA+Pg0KPiA+PiBbQU1EIE9mZmljaWFsIFVzZSBP
bmx5IC0gR2VuZXJhbF0NCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4+PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YNCj4gPj4+IEhhbXphIE1haGZvb3oNCj4gPj4+IFNl
bnQ6IEZyaWRheSwgTWFyY2ggMTcsIDIwMjMgMzo1OCBQTQ0KPiA+Pj4gVG86IFNpZGVyLCBHcmFo
YW0gPEdyYWhhbS5TaWRlckBhbWQuY29tPjsNCj4gPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnDQo+ID4+PiBDYzogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29t
Pg0KPiA+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogYWRkIHByaW50IGZvciBp
b21tdSB0cmFuc2xhdGlvbg0KPiA+Pj4gbW9kZQ0KPiA+Pj4NCj4gPj4+DQo+ID4+PiBPbiAzLzE3
LzIzIDE1OjQ3LCBHcmFoYW0gU2lkZXIgd3JvdGU6DQo+ID4+Pj4gQWRkIGxvZyB0byBkaXNwbGF5
IHdoZXRoZXIgUkFNIGlzIGRpcmVjdCB2cyBETUEgbWFwcGVkLg0KPiA+Pj4+DQo+ID4+Pj4gU2ln
bmVkLW9mZi1ieTogR3JhaGFtIFNpZGVyIDxHcmFoYW0uU2lkZXJAYW1kLmNvbT4NCj4gPj4+IElm
IHRoaXMgaW5mb3JtYXRpb24gaXMgb25seSB1c2VmdWwgZm9yIGRlYnVnZ2luZyBwdXJwb3Nlcywg
cGxlYXNlDQo+ID4+PiB1c2UNCj4gPj4+IGRybV9kYmcoKSBpbnN0ZWFkIG9mIHByX2luZm8oKS4N
Cj4gPiBJdCdzIHVzZWZ1bCBmb3IgbW9yZSB0aGFuIGp1c3QgZGVidWcgSSB3b3VsZCBzYXkuIEp1
c3QgYSBxdWljayB3YXkgdG8gZ3JlcA0KPiB3aGV0aGVyIElPTU1VIGlzIG9mZi9wdCB2cyBkZXZp
Y2UgaXNvbGF0aW9uIG1vZGUuDQo+IA0KPiBNaG0sIHNob3VsZG4ndCB0aGUgSU9NTVUgY29kZSBu
b3RlIHRoYXQgYXMgd2VsbD8NCj4NCg0KQXMgb2YgcmlnaHQgbm93LCBub3QgZXhhY3RseS4gQ29w
eS1wYXN0aW5nIEZlbGl4J3MgY29tbWVudCBoZXJlOg0KDQpUaGUga2VybmVsIGxvZyBbY3VycmVu
dGx5XSB0ZWxscyB5b3UgdGhlIGRlZmF1bHQgSU9NTVUgZG9tYWluLCBidXQgaXQgbWF5IG5vdCBt
YXRjaCB0aGUgZG9tYWluIGFjdHVhbGx5IHVzZWQgZm9yIHRoZSBHUFUuIFdpdGhvdXQgdGhpcyBt
ZXNzYWdlIHRoZXJlIGlzIG5vIGVhc3kgd2F5IHRvIHRlbGwgZnJvbSBhIGtlcm5lbCBsb2cuIFRo
aXMgd2lsbCBoZWxwIHdpdGggdHJpYWdpbmcgaXNzdWVzIGZyb20gbG9ncyBwcm92aWRlZCBieSBl
eHRlcm5hbCBhbmQgaW50ZXJuYWwgdXNlcnMuDQoNCkdyYWhhbQ0KDQo+IA0KPiBDaHJpc3RpYW4u
DQo+IA0KPiA+DQo+ID4gR3JhaGFtDQo+ID4NCj4gPj4+PiAtLS0NCj4gPj4+PiAgICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA2ICsrKysrLQ0KPiA+Pj4+ICAg
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPj4+Pg0K
PiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2
aWNlLmMNCj4gPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5j
DQo+ID4+Pj4gaW5kZXggOGJiYTVlNjg3MmExLi44Nzk3YTk1MjMyNDQgMTAwNjQ0DQo+ID4+Pj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4+Pj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+ID4+Pj4g
QEAgLTM1MjgsOCArMzUyOCwxMiBAQCBzdGF0aWMgdm9pZA0KPiA+Pj4gYW1kZ3B1X2RldmljZV9j
aGVja19pb21tdV9kaXJlY3RfbWFwKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2KQ0KPiA+
Pj4+ICAgICAgICAgICAgc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluOw0KPiA+Pj4+DQo+ID4+
Pj4gICAgICAgICAgICBkb21haW4gPSBpb21tdV9nZXRfZG9tYWluX2Zvcl9kZXYoYWRldi0+ZGV2
KTsNCj4gPj4+PiAtICBpZiAoIWRvbWFpbiB8fCBkb21haW4tPnR5cGUgPT0gSU9NTVVfRE9NQUlO
X0lERU5USVRZKQ0KPiA+Pj4+ICsgIGlmICghZG9tYWluIHx8IGRvbWFpbi0+dHlwZSA9PSBJT01N
VV9ET01BSU5fSURFTlRJVFkpIHsNCj4gPj4+PiArICAgICAgICAgIHByX2luZm8oIlJBTSBpcyBk
aXJlY3QgbWFwcGVkIHRvIEdQVSAobm90IHRyYXNsYXRlZCBieQ0KPiA+PiB0cmFzbGF0ZWQgLT4g
dHJhbnNsYXRlZA0KPiA+Pg0KPiA+IFRoYW5rcywgbXkga2V5Ym9hcmQga2VlcHMgc2tpcHBpbmcg
dGhlIG9uIHRoZSAnbicga2V5IGxhdGVseSA6KCB0aW1lIGZvciBhDQo+IGNsZWFuLg0KPiA+DQo+
ID4gR3JhaGFtDQo+ID4NCj4gPj4gICBLZW50DQo+ID4+PiBJT01NVSlcbiIpOw0KPiA+Pj4+ICAg
ICAgICAgICAgICAgICAgICBhZGV2LT5yYW1faXNfZGlyZWN0X21hcHBlZCA9IHRydWU7DQo+ID4+
Pj4gKyAgfSBlbHNlIHsNCj4gPj4+PiArICAgICAgICAgIHByX2luZm8oIlJBTSBpcyBETUEgbWFw
cGVkIHRvIEdQVSAodHJhbnNsYXRlZCBieQ0KPiA+Pj4gSU9NTVUpXG4iKTsNCj4gPj4+PiArICB9
DQo+ID4+Pj4gICAgfQ0KPiA+Pj4+DQo+ID4+Pj4gICAgc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRy
aWJ1dGUgKmFtZGdwdV9kZXZfYXR0cmlidXRlc1tdID0gew0KPiA+Pj4gLS0NCj4gPj4+IEhhbXph
DQo=
