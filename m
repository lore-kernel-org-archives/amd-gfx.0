Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08020C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 20:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D63A113847;
	Wed,  8 Jun 2022 20:16:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A0A11385F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 20:16:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogULxKwk5Drb9di+wOZb9hDratEBSxz7i1dhtHcbNL+ubCQVPJIOtB/JKcMUGBATDMXxDCx4/pNk73/lu06PhnsfL93IVIMzTblBKBc+54CFs3zr/47ruE1ZARNP9PhTLrALyGOYLFp94wuJhZcIefP94MqMIY8uCuQdDn+BJCjekoK2DRwjh2Kb3k4JEWgEVZqQ9CtZL8g0+I8EFIyPDQUrQ5mSmwzcewHJas7ut0HQVEkWcC1s6UDTqEUedJKB9M7a9XJzKYTDUwp1WD52T8OhYs8XhCPaRR8S/BJ3jW3fRsse5KuBtBwwZ+Aaxo1INgA7lWboFh3IuyYygjE/ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5bZ1Vcc0vhrno4rDNxnit9tQhaj5rrdGsljFssbpqw=;
 b=QFzA6mst3i/NxtSSugRUq6eJeS9S3Cbv2e0jM/Acpb6HeLkVGkiY6Ua6MbXYaUnZssdrMdiF0oyoZw7uaz6YKF2Dq+1eycMKoPXnzd1ECJh+18UR6VoF+f+cYICVrKkV0y0lG/vcsPlpSajLkaaWIyUsQIQ0oVKtFzFGcUPJT8lzKgTh1ZiF9GQ3qunahXM4h+cXzJ/9A3H7EzEp55bL+li1A44J5IBPOc9s5qJCgobK/5cWdkWoK9HZw+XvjzZ03bcZskL+uBItEXCB61jTTVGilb6/dCPsh9LET1zZJFpDWdgeeezMXyXhyAzYWoPB892He8Gl15L8d9SUkjJUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5bZ1Vcc0vhrno4rDNxnit9tQhaj5rrdGsljFssbpqw=;
 b=MQUAzQ6jl4ZIXY6wgATitIbxg4x9Tb2tyDXHQZUXXtyNIGWrnKDmHw7akxZKadIZjvM/LoEgNYGfWloimO/3ltzzDgHjasV9fU1DGpEKJ2qqNBueFbV4XqaoPWVtTJ7fjJvmkjx8sj2QUjZVop4LfI0tl6jYVWZmhfLqlUqkvbk=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Wed, 8 Jun
 2022 20:16:10 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3d3a:523d:94fd:fa16]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3d3a:523d:94fd:fa16%6]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 20:16:10 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/4] drm/amdkfd: Pass MES/RS64 information to sysfs
Thread-Topic: [PATCH 2/4] drm/amdkfd: Pass MES/RS64 information to sysfs
Thread-Index: AQHYesD3rFZd6rvcRkOAtqRlimWm+q1F5yQAgAALa8A=
Date: Wed, 8 Jun 2022 20:16:09 +0000
Message-ID: <DM6PR12MB30672F7A19D4EF6BC35426C88AA49@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20220607225007.1372343-1-Graham.Sider@amd.com>
 <20220607225007.1372343-2-Graham.Sider@amd.com>
 <74f62219-6f2c-c4d4-566b-6e0017151e91@amd.com>
In-Reply-To: <74f62219-6f2c-c4d4-566b-6e0017151e91@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-08T20:16:08Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=743d41a6-1595-475b-b738-22201026d486;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-08T20:16:08Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d724d946-bdad-458c-be10-2cea372d3439
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0745196a-01a6-4b55-4f21-08da498bba39
x-ms-traffictypediagnostic: DM6PR12MB3404:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3404CE6158F64B5A1227757B8AA49@DM6PR12MB3404.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fVXkmyPl6eUOib2Pa9TFrSh9W+M/aHYF3ngXcH+4B6YYufgx6f2luE4aU5lFrr4rUKPTiSZsprOPKjJSR/MUICKNsDq7gnLjEFjPkfB5FU2/AnI6p8NXEaau0KuH13jlPFc2QzC5WFA7gecEKTrwvJ18eZh2Tw857gRn/HN0aNBCWOI8n+9eLMJBM62Hzi+Ad/VsTJE6r1jdi9DG7EJkAc2iqUoWlaixhz3ngMGPJRM/Brf8jqoKGNVm7qrD7zeRgNRJ4btiEzBLdxzLtYDaLeIgrvQcp/berOjgCoLFTyFtFZ3x2ssEmUYGiig842XOXcs4Y9CIbWnLmW3D8XQ9nTyHPm9OBZrmMidug+ndvKrQM/u0FbOR2sZYmwi7f/Wp9Ao4S0EYEVW1LOl6nV+F+yvS4ifmtRwphZdSmyQTho++Yu5OY3qXsEGxttry/ychC/Eg+StYpNS0RLvrAlN9m3slVjtGGVJeOK3L2ZJk0FWn6yRfJIwiiF8MSMuL6sxk4GTdt6tDWc5FEIesG4XyEc72F3hAWa8nGUQaXtuTUKRQZRCwo7ensmmTdSWnuGPZz0j8I62BeO/HJFHag4MMt9HNwT1RwIXyDZRMhBBPJ9/3NBEQAw3fhgDlho0KGiO2cWCPyokSjrv3L7HgaBV6Vc11acClLKshAJ0GFCTrPD2tB3id8yl4yjg/VpGujcQRdyLnZ4SFVOSN2zPzz/2VWQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(55016003)(316002)(66556008)(71200400001)(110136005)(122000001)(8676002)(2906002)(186003)(38070700005)(66476007)(6506007)(53546011)(508600001)(86362001)(38100700002)(33656002)(4326008)(9686003)(8936002)(7696005)(5660300002)(66946007)(26005)(52536014)(76116006)(64756008)(83380400001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bU82RDEvdjIzSkUrUzFvRTUyM1ZQTndHQzliYTVCOGUrckdlWUtpekhSSy9I?=
 =?utf-8?B?QjI4cTdjdlc3NXpqRnNkQVpFQU5oK1l2T3luUElMV28walpXL0p5VTVLTEVl?=
 =?utf-8?B?SmdNcTdRSGpnUXpHWnM1QW9hSWl2eDF3NEJ0Zk5vYU5kSTkyVmQ4OGkwK05E?=
 =?utf-8?B?TzMxMnJPcHE3dWQyUmo4akluUjk0UElSN29kdGV6dDVyZ0ZjNjNJN2IzOHMw?=
 =?utf-8?B?ZFFweTdUN24zaU83Y2RRa3A0cld3a29CZ2JSSXMrU001U0NDSVZ4YWIyT3hW?=
 =?utf-8?B?eXRKd2c5clJDcmNXSFF2b1lGRGZWOTB3RHJSbG1KRFJCdnp3ejFHNzN0blBp?=
 =?utf-8?B?eGg2NFdwMlZ2QkhSa1pIaERRRlVEODhwbERacWVFQnBmU2dxbU9qb2lkUDJw?=
 =?utf-8?B?M2NMY2lsd0tpU3JpVjloZTJXcTV2cEdoSUFCbnNHY0xaYk12alpYbWF3UWw5?=
 =?utf-8?B?KzZtMmtHaVVGWDVwNEJpekZGeHZWOXZ3TjN4TWZORzVHUE5QS3VmMytLbHNr?=
 =?utf-8?B?bEF6Z0lLK0NHb3l0dm1MNEs4ditPUDIwMndxNEpQZE93VTFsNG5Fckg5UVQw?=
 =?utf-8?B?NDNhTm1YeDBSckxvK2VxWTQyak9TakNVVjdLQjVtUFJSMmxvMG1YdFg1V0o3?=
 =?utf-8?B?YnRSallVQVdNeWFad2F4UEJhdk5XQWZnWVhwWmNndGF4bmE5QVJrRzB1YzlI?=
 =?utf-8?B?dDl3dHJmbTNuRHh0WFJzQjhwK096LzJZZUNlTDhBcUM0NjVyVlVCMTZpVmVS?=
 =?utf-8?B?RnNZZjVoYU5vRWJxVmoyTnBQMDV3d1JEbDdCVFh3cXVuMEpZZlVMRVkxZWZn?=
 =?utf-8?B?Tkk4bnoxVDVKQVFRRzhRbWVWR0YvbUtaU3czSys4ZHJ3VUlxVk8zRzJBVzVp?=
 =?utf-8?B?Nk5UN25yeGRjSjBCVlFGcGJDS1Q5blBoZmd5QmROMUd2ajVsMHZNS3dlaGNK?=
 =?utf-8?B?QXZuS3pvUmZYYkdWZkFydy8vWDFoN1BRTmY2VlpoK3p6RkF0RzI1b284RWZz?=
 =?utf-8?B?NnB2MFJxYktUNjA1UkVnV1l3ZDUwR2xhQ3l3bEtadDIrMEJLZUU3ZjUzT0Vx?=
 =?utf-8?B?WmlBL0VkelVQVS9KZ2YyQVJ2RkZMSlh4d2lpbEt4WkpKSzlBN1Azbk5Rc214?=
 =?utf-8?B?Yk1HeU1tWXJMRVgzRkRCUkJLUDhEaWNTVVR2cmxUZ2w2c1BvaHV5b2VuTVdV?=
 =?utf-8?B?ZnV1bWpqZkxmdVQ4RkFNUWNLb3JQdEZtWlBwSFA5aHdlZ1pMTDB1S1NOQWRS?=
 =?utf-8?B?SzVTT0FLa0VqRjBVWHljMEVCUHUvblZMdE0yRlc4VW5XRmVUVy9qaTVQaXRZ?=
 =?utf-8?B?UHUvYXR6bk5ZU01STEtzV1lrTUQrdWxLYkc4VzdNYW51OFVsMVJRQWYyNGFn?=
 =?utf-8?B?SHowN2U3WXI2WFRTYlZtRUt2MnMzNlBMVElYNVdlZEVSaW9IdWVBYTgyMTZJ?=
 =?utf-8?B?a0ZMN3N3YkpnaGJyVzBPOVJxeVhyV3FhRU9kUitNS1dkVlA3VkNlT1ptWDV0?=
 =?utf-8?B?eHIzUy80YjEwSUx5WmtNVUVUS3JEOGkwWmRITUVlOW9nMXQ4TUhqdkxwckc2?=
 =?utf-8?B?aWcrbVU3V09pclBMNExHN0RldDdzTldQaUh0Z2RhQ3pLS0QrbjZkdVE2NmdS?=
 =?utf-8?B?ME8vVVl4VFlKRzNseHZiTEQrb0RqUUtXTVk0RnF1YWdwaW5mZzVGN2V5WU80?=
 =?utf-8?B?ZHY4VDZ0TFQ1SElrV0VnRGgvdFN5NjA0UDk3YmVPNkFldndiNmV3aXpuaXgr?=
 =?utf-8?B?RXJpQjVueGgzaGpsaklkMDNkZTlGbVJQZlVkQVllaEIvL2RrREJJak5GQUMy?=
 =?utf-8?B?ZHRVQlBtRDRvNW81ZEp1R1laTEM2RElEd0RJWjUydmN5Y3hxQTlaUTMyekJ5?=
 =?utf-8?B?MkUvUFNhMnJFcVUzcFJBVWpKNXNLdS9SMFhlay9UWWRXRWNWWG9NelcyNnEr?=
 =?utf-8?B?Ykt4UFRyUkJqc2NucmJIcWd3UTVPcWNyY1doYlVjdXh5YzJLM0hJWitNK0Ew?=
 =?utf-8?B?TzRYK3hFU1gvL2J2R0hqSUx6SFFmVEtqc3kvYkpVWk9RZUhiMVdGTHNVY1U3?=
 =?utf-8?B?ZEQ1M0lGVkVtMUtlNzhRM2s4bHY4WmEvKzRGRG1YN3VKNkdkUUM4bFI2cGEy?=
 =?utf-8?B?OVI1eWRpaDY3NlllSjVWZGloQTRCVThsdDlvdWRjR1NQV29pbEJpOWxqS2dw?=
 =?utf-8?B?QXRZT3h6OXlISGIvZmM1ZGg1eDYzUWpiK0tDSkVBZzBQSnVNR1NrNmREWXdh?=
 =?utf-8?B?czJBQ0w4UnBneFpOeFNPSVdoYVRJKzFkOHhPTFEzWGJoNmEvbzVqR1dsckFG?=
 =?utf-8?B?NXQxeVd4cHp4ZCthM0hyTndxR3ZMSWx5S2hvOUdaS1hocW5TdnpDUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0745196a-01a6-4b55-4f21-08da498bba39
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 20:16:09.9477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2J7m+OHXtzF+Jt4ERrQQWdJ3lSro2k+oLYWVlCqt330c/Oz9K3jpPt/UoZXRbzDTaoL6TibsE0IQTy/BI4wtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3404
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkkgd2FzIG9yaWdpbmFsbHkgdXNp
bmcgdGhlIE1FUyBzY2hlZHVsZXIgdmVyc2lvbiBpbiBUaHVuayB0byBjaGVjayB3aGV0aGVyIHRv
IHVzZSB1c2VycHRyIG9yIG5vbi1wYWdlZCBtZW1vcnkgZm9yIHRoZSBxdWV1ZSBhbGxvY2F0aW9u
LiBKdXN0IHRvZGF5IHRob3VnaCBJJ3ZlIGNoYW5nZWQgdGhpcyB0byBhbHdheXMgdXNlIG5vbi1w
YWdlZCBzbyB0aGlzIGlzbid0IG5lZWRlZCBhbnltb3JlLiBNYXliZSBpbnN0ZWFkIHdlIGNhbiB0
aGluayBhYm91dCBhZGRpbmcgdGhpcyB0byBkZWJ1Z2ZzLCBJIGFncmVlLg0KDQpUaGFua3MsDQpH
cmFoYW0gDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLdWVobGluZywgRmVs
aXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBKdW5lIDgsIDIw
MjIgMzozMSBQTQ0KVG86IFNpZGVyLCBHcmFoYW0gPEdyYWhhbS5TaWRlckBhbWQuY29tPjsgYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBZYW5nLCBQaGlsaXAgPFBoaWxpcC5ZYW5n
QGFtZC5jb20+OyBKb3NoaSwgTXVrdWwgPE11a3VsLkpvc2hpQGFtZC5jb20+DQpTdWJqZWN0OiBS
ZTogW1BBVENIIDIvNF0gZHJtL2FtZGtmZDogUGFzcyBNRVMvUlM2NCBpbmZvcm1hdGlvbiB0byBz
eXNmcw0KDQpPbiAyMDIyLTA2LTA3IDE4OjUwLCBHcmFoYW0gU2lkZXIgd3JvdGU6DQo+IE1ha2Ug
TUVTL1JTNjQgQ1AgZW5hYmxlbWVudCBhbmQgTUVTIHNjaGVkdWxlci9NRVMgS0lRIHZlcnNpb25z
IA0KPiBhdmFpbGFibGUgdGhyb3VnaCBzeXNmcy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogR3JhaGFt
IFNpZGVyIDxHcmFoYW0uU2lkZXJAYW1kLmNvbT4NCg0KV2h5IGRvIHdlIG5lZWQgdG8gZXhwb3Nl
IHRoaXMgdG8gdXNlciBtb2RlIGFwcGxpY2F0aW9ucz8gVGhleSBkb24ndCBpbnRlcmFjdCBkaXJl
Y3RseSB3aXRoIHRoZSBzY2hlZHVsZXIgb3IgdGhlIEtJUS4gSSBjYW5ub3QgdGhpbmsgb2YgYW55
IHJlYXNvbmFibGUgY29uZGl0aW9ucyBpbiB1c2VybW9kZSB0aGF0IHdvdWxkIG5lZWQgdGhlIHNj
aGVkdWxlciBvciBLSVEgdmVyc2lvbiBudW1iZXIuIEl0IG1heSBtYWtlIHNlbnNlIGluIGRlYnVn
ZnMsIGJ1dCBub3QgaGVyZS4NCg0KUmVnYXJkcywNCiDCoCBGZWxpeA0KDQoNCj4gLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMgfCA4ICsrKysrKysrDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMgDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMNCj4gaW5kZXggMDJlZmFlNGY1NTQ5Li41MWM4
YTI4NWJhYWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90
b3BvbG9neS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9n
eS5jDQo+IEBAIC01NzEsNiArNTcxLDE0IEBAIHN0YXRpYyBzc2l6ZV90IG5vZGVfc2hvdyhzdHJ1
Y3Qga29iamVjdCAqa29iaiwgc3RydWN0IGF0dHJpYnV0ZSAqYXR0ciwNCj4gICAJCQkJICAgICAg
ZGV2LT5ncHUtPnNkbWFfZndfdmVyc2lvbik7DQo+ICAgCQlzeXNmc19zaG93XzY0Yml0X3Byb3Ao
YnVmZmVyLCBvZmZzLCAidW5pcXVlX2lkIiwNCj4gICAJCQkJICAgICAgZGV2LT5ncHUtPmFkZXYt
PnVuaXF1ZV9pZCk7DQo+ICsJCXN5c2ZzX3Nob3dfMzJiaXRfcHJvcChidWZmZXIsIG9mZnMsICJt
ZXNfZW5hYmxlZCIsDQo+ICsJCQkJICAgICAgKHVpbnQzMl90KWRldi0+Z3B1LT5hZGV2LT5lbmFi
bGVfbWVzKTsNCj4gKwkJc3lzZnNfc2hvd18zMmJpdF9wcm9wKGJ1ZmZlciwgb2ZmcywgInJzNjRf
Y3BfZW5hYmxlZCIsDQo+ICsJCQkJICAgICAgKHVpbnQzMl90KWRldi0+Z3B1LT5hZGV2LT5nZngu
cnM2NF9lbmFibGUpOw0KPiArCQlzeXNmc19zaG93XzMyYml0X3Byb3AoYnVmZmVyLCBvZmZzLCAi
bWVzX3NjaGVkX3ZlcnNpb24iLA0KPiArCQkJCSAgICAgIGRldi0+Z3B1LT5hZGV2LT5tZXMuc2No
ZWRfdmVyc2lvbik7DQo+ICsJCXN5c2ZzX3Nob3dfMzJiaXRfcHJvcChidWZmZXIsIG9mZnMsICJt
ZXNfa2lxX3ZlcnNpb24iLA0KPiArCQkJCSAgICAgIGRldi0+Z3B1LT5hZGV2LT5tZXMua2lxX3Zl
cnNpb24pOw0KPiAgIA0KPiAgIAl9DQo+ICAgDQo=
