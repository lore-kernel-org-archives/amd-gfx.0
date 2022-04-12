Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0A6C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 01:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F36AE10E694;
	Tue, 12 Apr 2022 01:52:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FBCD10E694
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 01:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXLu6MtnOL6aDuxHFNLPW2f/lQrBOiolUR/zpfFU8bOx9fEeYOGrVdrV5Og5fF7rC21NZ0TaHAFQXh7X4LDUIA09osrQ/v+apsekzUfe7/3DjwMxmSgz4C170eSg8ucdglsxjvlmW1WEv3KrwjoyKtckm5cA3UJeQ48cMNLjHcW/DOk7mKG0CAKJFJDcQpLdkBRmp3EcgQu/VZy0qgky4SMp5N6/iS1HDPoDJrx0o+cInLQtIAO02Ibe/6X770mReyMGoP1AcwCIvrOZeu35qNP7pmuQ+/n8thM8+sibAJBnQiyHuhmXH3gwOzuzfRMaA6nWFp7MFDz8e6fTube52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPJNDKR+0z1IdbaPLx+hYycVN7QnMTbhvFKYS4Bd2Ic=;
 b=dNRHLnGsaDV24LE59+0Oh+h6d30kbbUV+Kew7U/CRJBO0VLOKK2bTx3cWh8w+e2G095kO6ncLMTS/ko7T+qVMfkTNjlHQIhVsM9xGxXSNTaR2wo4xYoJi3bHFpbNfqX/Csz5i1xh5UoKtTS97kPLd8cZLL05Nz4MBW4Evo5lWrEOGwZ8NMdd0Nw4ga2m3FOAFfj9xZ0vhI85vCC8BRLtGDrwztHQi95c1HQYx78DBWS/QlIwMXGdFppqSsE7wt91KBBASvudrXhpkJb3KaukucAq0oJKblED2WOzfJYj9JJw2F4ItIJSr0cHDLNMn+lVi24ksRLEwlDvyveWvwtsqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPJNDKR+0z1IdbaPLx+hYycVN7QnMTbhvFKYS4Bd2Ic=;
 b=xT0JlKTV4DZenDChbk9I+wzUBwgTnqb7ztSAmvbebo6WHiuWnOKbUkHTKz3n4I280oPdaaRFyhbZuiVCdYAGupZu10AANw47AhlLf7yU6a+LJJB0OYTBeO8dQJprzUkHF+4qPNWj28S6XTMjJ40f4iVb85mv4p25dK++XG++yiQ=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BY5PR12MB4017.namprd12.prod.outlook.com (2603:10b6:a03:1ac::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 01:52:35 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::610b:3e61:665b:cdc4]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::610b:3e61:665b:cdc4%6]) with mapi id 15.20.5144.029; Tue, 12 Apr 2022
 01:52:35 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH ] drm/amdgpu: fix discovery ip failed
Thread-Topic: [PATCH ] drm/amdgpu: fix discovery ip failed
Thread-Index: AQHYTbe1etcmhYF/6kOujyyr27oLtKzrgykA
Date: Tue, 12 Apr 2022 01:52:35 +0000
Message-ID: <DM4PR12MB51529669CBDA773CD36D420FE3ED9@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <DM4PR12MB51525F878057240AE5C91F14E3EA9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <bbd6939b-227c-f197-5d10-ba9194fd2b76@molgen.mpg.de>
In-Reply-To: <bbd6939b-227c-f197-5d10-ba9194fd2b76@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-12T01:47:42Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f7f97aff-f7b9-42ae-a6f4-78718e0a466b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-12T01:52:31Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 3d5d25b2-84ee-4eaa-be2d-5bc72dc5e7a3
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 593a302a-d4ba-4385-ce68-08da1c271de0
x-ms-traffictypediagnostic: BY5PR12MB4017:EE_
x-microsoft-antispam-prvs: <BY5PR12MB40178A4B83A10F502342BA3EE3ED9@BY5PR12MB4017.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9DvzsuZgSuPX3wYe9eM277eKV3lHiOV/qagolfTIVJZKxpSpN6TfDTJstMA/RFqUuFwrzsIE3aTEk3xSWy706FirTV2Z0b/aLQHrgoh8KKTO9o/plLcpjh71cWmMI4ltY0+BQDCDmEbrLegTTR3/qGUCJhRkYclFU1+aFOpl4rInaXCTeyNNIsY7uIE0YvntjQMMayuiYxTYsJSoTF9UpAEP8qTFFpIOPirIbsUQo2K0/T6py5jWH0n2ptipLoQNXfK4VL4KMNs2tlgmjOvOXRzlSN+chXqWVpu94zN9jPVD9HB2W8F+vvZxWTpwqaM4yqDznoDBfPlwhX/Mwvibwmferj7p1gjmCNfrAXfiu9soNMbdaHrTPDiRjwHn0C2lwHRPi3Xbz3kTkRmadmH2WiTB7GcMTZEyDZfuLQZ2GrQ48wpg4U6SXrQi8TdQQLvsVJcP3lQ+m9Fw44EqcY7kNXWQlzRD3jy++xIIrgNGiAkmdos1Q0UkFITLfcD+TdfDl7HQ+9W175yBBnU6tqRg0LXrrldRwFF55rbguvoGRS7bJ30/gtYzLuUBZlkxsSvBYXeSnMMdJCfckw2Awoz3qIMGC6wZi1Bi6ixYkQhgr3y6WtCgBsRYBJn+tT8+x2G4b7hStN1vm/RTF1zU1EhwRfK9yBW5/ST4g7hmXqa3gLeZNsM7OpX28hmLD61bNx4cjH7I+DnTXWCDOSWE/xWVTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7696005)(53546011)(55016003)(9686003)(83380400001)(186003)(26005)(8936002)(64756008)(66446008)(66476007)(66556008)(66946007)(4326008)(8676002)(2906002)(5660300002)(508600001)(76116006)(6506007)(71200400001)(52536014)(316002)(6916009)(54906003)(38100700002)(33656002)(122000001)(38070700005)(99936003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlNYZGRMRlBIUVkyc1NMRDhaZU5ZeUlMY0ZxU0FjQzliV2IvVHVMUGN0dVZI?=
 =?utf-8?B?b3RuVExGYS9GQXpGZzAzWm5xS2kwUDRldlVVUGZOK0l6cEd5WWYvMEplZ1Vh?=
 =?utf-8?B?Y2k0REQ4ZTJtM3BUTkV3Vm9LeTM5RmxXTzhzNXZOSmhjUjhLMnpIZ1djdzkv?=
 =?utf-8?B?MnV5RDRHMFg0NUIvaE1hdVFDanUvdzhhZVBFYnIrMkpuZ1pCcWR6S3d1UkN5?=
 =?utf-8?B?U1lsTjZKbEhLdEhLc3NYTHJyQmIyNHFIM1oxZUxFRWRWSmJvY2tsa014WndU?=
 =?utf-8?B?d04vOFNSRHhOdHdWQ0lJM0xPQVVyQVdadzlrbHdEalc0THoxNHhrbmJ3YjJS?=
 =?utf-8?B?LzRialNyQW9jMWdqQVlhWFdBVFdzZ3pPTmhPNE9KWlJTV2pBdEU3aHorNU9F?=
 =?utf-8?B?VWpveU9zTTdhTGZpaUpZRnF3dExjcHRKSHR1Qlk2Z1ZNczhRQ21vYjdONTc0?=
 =?utf-8?B?VFZ3MG9oY2MyMzRtZmxHZHQyZlNFZ2ZnZjd0MWxaUHhjSTgyY3p2VEdQdUcx?=
 =?utf-8?B?L1Ricy9QMy9tdlZBVXE3NHQwN1dsT3R0Vnh3MlYzSXpqbVo0ekxrQnZySHVp?=
 =?utf-8?B?YzNqc3RnQVluazJoUkVsWnFuUmpmN3pWWjh5WWFtWG1mVVdjbWxjenN0U3Bs?=
 =?utf-8?B?V1VVWDBhaENBVnBkN0pjVklFYWRBL0lMTFZGaW9wY0lYL01xZEFaVmhSSHp3?=
 =?utf-8?B?QUFITGEzWm50MVVib3JVd1BGZ09FSkU1VU1tS242QVVNRVppUlBENHhyemUr?=
 =?utf-8?B?NndIOGJ5SDNFcmZuME9oRTl5c01OQ1pEUk0rNEw0dStwQThXSndzelBSZEhk?=
 =?utf-8?B?amJ0dW9SMlN5SlJCaXJqQ044NnowNTNCblhHcTlTRVpXNzk4clJuMDNRNjRY?=
 =?utf-8?B?RmpwNVEwczNuY0NSaHgxdlNFSlgzc1VZR1JvbnlyYVRtUmxsVWhZZDFmODhR?=
 =?utf-8?B?Vldic1VIVGtQdzc1elB2VEhTSDFid3FOclFJdFlLRDZyWDVaSm8ybmQ3NVVI?=
 =?utf-8?B?dDlyWWRET2YyRldHOEJGWEJjcjU0anVjd1NUV1BNb040VWJTZVV4QWcvSkpU?=
 =?utf-8?B?RzdQY2FsMm51WFY4K0NsMzByK3UrYUxXenFuVk11Qlo2bU1vcXhJU0NRZ1Nu?=
 =?utf-8?B?bkVYZlc3QUhSTG85R0pWVTBjOUVoZndCV20xcm12KzFJby8wbEo4MlduUDBy?=
 =?utf-8?B?UUc5dzAyeENzTk81ZmdZc3JPd040V3kxYkdiKys5UXJJU0N1QitEL1c5SWhF?=
 =?utf-8?B?M2JydXhZaEM1YjhGb2UyQS81UE50TTl0eEw1Y3V4MjhQbENGcUtUclhJand1?=
 =?utf-8?B?ekNXeTZqV3RieDA1Qlk1QkdTVDlJN1pYUUs4bDRQTVJkT3BCY0JsV0xaNkk5?=
 =?utf-8?B?eFVjR0lmUUUyWjVyZVl6S3dIdUJJUUJWNXcrczBwMUVPalBDVzFwR3JNOUJY?=
 =?utf-8?B?Y1NSVHdKbHM2WjhXeTlWcFAyLzdOMGxJbEc3U1ZXdWhQUHNOSHovcUk3dTlQ?=
 =?utf-8?B?V29NUFpRc0c5bW9ZamRKb0RoRlVBdjlxd2dQSnBVNzJjTm96WnNWRGpVcktm?=
 =?utf-8?B?QVRuWkdnRVd5UXQ5WmpsQlJxYklUM24yVEVtd3BINm1OaUZXZXNEa1E0Zm1R?=
 =?utf-8?B?NTY0VHM5RThha1NOOW1BaU9mTEVRVnpCcnNtSXQ3dkVGaFp6U091RXVBVGc5?=
 =?utf-8?B?SjRDOHdiVU5pZzhtbUZ2ZzdRMy9xbnNXcU1HV29lVW1TY3UzOS9wLy9YbFdp?=
 =?utf-8?B?aFdYZHJWSWNmYU1MN2VZRjFmT0g2Mjd6WWNUMUxKaEtyNUVQVFpHUkNISUlX?=
 =?utf-8?B?Z0tQejg4QWpLN2o3K3JUSGpXd3FVMUpsYmdyK3ZTWCs3Ulcxd3pjcXVlK0xm?=
 =?utf-8?B?eE9rSTVpOWE3N2NMRFJlME9EWTNsekJBQVFNcFVPcUFlU0o0SWFDalUwVVBv?=
 =?utf-8?B?ZFRqL2lIZ1ltL3lZVDA3Q0M2Tm0rMnRKV1RVeUxwMnAvQlFwam9uL0N4R284?=
 =?utf-8?B?aEI4L2xCa3dLYWw2c3F1OExqZDF4Nm9Zb2Q3L3VqZWhlWlE0NzVrWjhOYUh5?=
 =?utf-8?B?ZmN0U3pNbW1VZnFBR2JpUjcrZ3BWaXVTeXZQL0lXNEY5NUkrUVdtczlRR2g4?=
 =?utf-8?B?aFJ0WHVTeVJ3WXovU0xZdG1mMUMxU2YzWlJCVVR5d2VCMHo3TmJDUUNuVmQy?=
 =?utf-8?B?UXJwOVQ4cXJpK3dlbHUrZC9rWEo2QmpLSk5DNXprQzBSVitqK09SaVZOb0lr?=
 =?utf-8?B?WFZrQ0hRQkpXa2E4MUNUaGw4TG9wSTU3Ri9pMllTaGl0b2MzMjVNRmVVSGE4?=
 =?utf-8?B?RFFiaGxLaENmUWMrMmp1MG5QME9heTNTYXg3Y3lUcnBqa3B0TU5QUT09?=
Content-Type: multipart/mixed;
 boundary="_002_DM4PR12MB51529669CBDA773CD36D420FE3ED9DM4PR12MB5152namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593a302a-d4ba-4385-ce68-08da1c271de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 01:52:35.5671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KWQoubuGzWis9ycKj+6nloJMvy5nhJeGG5sdalMqZRzNtuH4B4j+8VR6nBOp1d9oYLEEnO7MTzjxdLrBg/nCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4017
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
 Yifan" <Yifan1.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_002_DM4PR12MB51529669CBDA773CD36D420FE3ED9DM4PR12MB5152namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVGhhbmtzICBQYXVsIE1lbnplbA0KQXR0YWNoICB0
aGUgcGF0Y2ggZmlsZSAuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQYXVs
IE1lbnplbCA8cG1lbnplbEBtb2xnZW4ubXBnLmRlPiANClNlbnQ6IE1vbmRheSwgMTEgQXByaWwg
MjAyMiAxMToyMSBwbQ0KVG86IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQuY29t
Pg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywgWWlmYW4gPFlpZmFu
MS5aaGFuZ0BhbWQuY29tPjsgSHVhbmcsIFJheSA8UmF5Lkh1YW5nQGFtZC5jb20+DQpTdWJqZWN0
OiBSZTogW1BBVENIIF0gZHJtL2FtZGdwdTogZml4IGRpc2NvdmVyeSBpcCBmYWlsZWQNCg0KW0NB
VVRJT046IEV4dGVybmFsIEVtYWlsXQ0KDQpEZWFyIEppZSwNCg0KDQpUaGFuayB5b3UgZm9yIHlv
dXIgcGF0Y2guDQoNCg0KQW0gMTEuMDQuMjIgdW0gMTc6MTUgc2NocmllYiBaaGFuZywgSmVzc2Uo
SmllKToNCg0KWW91IG1pZ2h0IHdhbnQgdG8gYWRkIGEgc3BhY2UgYmVmb3JlIHRoZSAoLg0KDQo+
IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHldDQoNClBsZWFzZSBzZW5kIGEgcGF0Y2ggd2l0aCBgZ2l0
IGZvcm1hdC1wYXRjaGAgb3Igc2ltaWxhci4NCg0KPiBGaXggZGlzY292ZXJ5IGlwIGZhaWxlZCwg
YW5kIHRoZSBsb2c6DQoNCk9uIHdoYXQgc3lzdGVtPw0KDQo+ICAgICA1Ni4xMjk1NDldIFtkcm06
YW1kZ3B1X2Rpc2NvdmVyeV92YWxpZGF0ZV9pcCBbYW1kZ3B1XV0gKkVSUk9SKiBVbmV4cGVjdGVk
IG51bWJlcl9pbnN0YW5jZSAoNjQpIGZyb20gaXAgZGlzY292ZXJ5IGJsb2INCj4gWyAgIDU2LjEz
MDEyOV0gW2RybTphbWRncHVfZGlzY292ZXJ5X3ZhbGlkYXRlX2lwIFthbWRncHVdXSAqRVJST1Iq
IFVuZXhwZWN0ZWQgaHdfaWQgKDQ1MDU2KSBmcm9tIGlwIGRpc2NvdmVyeSBibG9iDQo+IFsgICA1
Ni4xMzA3MDFdIFtkcm06YW1kZ3B1X2Rpc2NvdmVyeV92YWxpZGF0ZV9pcCBbYW1kZ3B1XV0gKkVS
Uk9SKiBVbmV4cGVjdGVkIG51bWJlcl9pbnN0YW5jZSAoNjYpIGZyb20gaXAgZGlzY292ZXJ5IGJs
b2INCj4gWyAgIDU2LjEzMTI4M10gW2RybTphbWRncHVfZGlzY292ZXJ5X3ZhbGlkYXRlX2lwIFth
bWRncHVdXSAqRVJST1IqIFVuZXhwZWN0ZWQgaHdfaWQgKDQ1NTY4KSBmcm9tIGlwIGRpc2NvdmVy
eSBibG9iDQo+IFsgICA1Ni4xMzE4NTVdIFtkcm06YW1kZ3B1X2Rpc2NvdmVyeV92YWxpZGF0ZV9p
cCBbYW1kZ3B1XV0gKkVSUk9SKiBVbmV4cGVjdGVkIG51bWJlcl9pbnN0YW5jZSAoNjYpIGZyb20g
aXAgZGlzY292ZXJ5IGJsb2INCj4gWyAgIDU2LjEzMjQzNl0gW2RybTphbWRncHVfZGlzY292ZXJ5
X3ZhbGlkYXRlX2lwIFthbWRncHVdXSAqRVJST1IqIFVuZXhwZWN0ZWQgaHdfaWQgKDQ4MCkgZnJv
bSBpcCBkaXNjb3ZlcnkgYmxvYg0KPiBbICAgNTYuMTMzMDUzXSBbZHJtOmFtZGdwdV9kaXNjb3Zl
cnlfdmFsaWRhdGVfaXAgW2FtZGdwdV1dICpFUlJPUiogVW5leHBlY3RlZCBod19pZCAoNjA4KSBm
cm9tIGlwIGRpc2NvdmVyeSBibG9iDQo+IFsgICA1Ni4xMzM2MjZdIFtkcm06YW1kZ3B1X2Rpc2Nv
dmVyeV92YWxpZGF0ZV9pcCBbYW1kZ3B1XV0gKkVSUk9SKiBVbmV4cGVjdGVkIGh3X2lkICg2NDAp
IGZyb20gaXAgZGlzY292ZXJ5IGJsb2INCj4gWyAgIDU2LjEzNDIwN10gW2RybTphbWRncHVfZGlz
Y292ZXJ5X3ZhbGlkYXRlX2lwIFthbWRncHVdXSAqRVJST1IqIFVuZXhwZWN0ZWQgbnVtYmVyX2lu
c3RhbmNlICg2NCkgZnJvbSBpcCBkaXNjb3ZlcnkgYmxvYg0KPiBbICAgNTYuMTM0NzgwXSBbZHJt
OmFtZGdwdV9kaXNjb3ZlcnlfdmFsaWRhdGVfaXAgW2FtZGdwdV1dICpFUlJPUiogVW5leHBlY3Rl
ZCBudW1iZXJfaW5zdGFuY2UgKDY0KSBmcm9tIGlwIGRpc2NvdmVyeSBibG9iDQo+IFsgICA1Ni4x
MzUzNjBdIFtkcm06YW1kZ3B1X2Rpc2NvdmVyeV92YWxpZGF0ZV9pcCBbYW1kZ3B1XV0gKkVSUk9S
KiBVbmV4cGVjdGVkIGh3X2lkICgyODY3MikgZnJvbSBpcCBkaXNjb3ZlcnkgYmxvYg0KDQpQbGVh
c2UgZGVzY3JpYmUgdGhlIHJlYXNvbiBmb3IgdGhlIGZhaWx1cmUsIGFuZCB5b3VyIGZpeC4NCg0K
QSBTaWduZWQtb2ZmLWJ5IGxpbmUgaXMgbWlzc2luZy4NCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+IGluZGV4IDc2NjAwNmEwNzVlYy4uYTc3
OGIwMzkyZTlmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGlzY292ZXJ5LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2Rpc2NvdmVyeS5jDQo+IEBAIC03OTgsNyArNzk4LDcgQEAgc3RhdGljIGludCBhbWRncHVfZGlz
Y292ZXJ5X3N5c2ZzX2lwcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgIHJlcyA9IGtvYmplY3RfYWRkKCZpcF9od19pbnN0YW5jZS0+a29iaiwg
TlVMTCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIlZCIs
IGlwX2h3X2luc3RhbmNlLT5udW1faW5zdGFuY2UpOw0KPiBuZXh0X2lwOg0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICBpcF9vZmZzZXQgKz0gc2l6ZW9mKCppcCkgKyA0ICogKGlwLT5udW1fYmFz
ZV9hZGRyZXNzIC0gMSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlwX29mZnNldCArPSBz
dHJ1Y3Rfc2l6ZShpcCwgYmFzZV9hZGRyZXNzLCBpcC0+bnVtX2Jhc2VfYWRkcmVzcyk7DQo+ICAg
ICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICB9DQo+DQo+IEBAIC0xMDYzLDcgKzEwNjMsNyBA
QCBpbnQgYW1kZ3B1X2Rpc2NvdmVyeV9yZWdfYmFzZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPg0KPiBuZXh0X2lwOg0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICBpcF9vZmZzZXQgKz0gc2l6ZW9mKCppcCkgKyA0ICogKGlw
LT5udW1fYmFzZV9hZGRyZXNzIC0gMSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlwX29m
ZnNldCArPSBzdHJ1Y3Rfc2l6ZShpcCwgYmFzZV9hZGRyZXNzLCBpcC0+bnVtX2Jhc2VfYWRkcmVz
cyk7DQo+ICAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICB9DQo+DQo+IEBAIC0xMTEzLDcg
KzExMTMsNyBAQCBpbnQgYW1kZ3B1X2Rpc2NvdmVyeV9nZXRfaXBfdmVyc2lvbihzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwgaW50IGh3X2lkLCBpbnQgbg0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICpyZXZpc2lvbiA9IGlwLT5yZXZpc2lvbjsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICB9DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGlwX29mZnNldCArPSBzaXplb2Yo
KmlwKSArIDQgKiAoaXAtPm51bV9iYXNlX2FkZHJlc3MgLSAxKTsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgaXBfb2Zmc2V0ICs9IHN0cnVjdF9zaXplKGlwLCBiYXNlX2FkZHJlc3MsIGlwLT5u
dW1fYmFzZV9hZGRyZXNzKTsNCj4gICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgIH0NCj4N
Cg0KS2luZCByZWdhcmRzLA0KDQpQYXVsDQo=

--_002_DM4PR12MB51529669CBDA773CD36D420FE3ED9DM4PR12MB5152namp_
Content-Type: application/octet-stream;
	name="0001-fix-ip-discovery-failed-SWDEV-332054.patch"
Content-Description: 0001-fix-ip-discovery-failed-SWDEV-332054.patch
Content-Disposition: attachment;
	filename="0001-fix-ip-discovery-failed-SWDEV-332054.patch"; size=1656;
	creation-date="Tue, 12 Apr 2022 01:50:00 GMT";
	modification-date="Tue, 12 Apr 2022 01:52:34 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmMTA1Y2Y5YjkyY2Q5NGEwZGM1YzEzYjEzZDRlMTAxODU1NjQ1ODIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBqaWUxemhhbiA8amVzc2UuemhhbmdAYW1kLmNvbT4KRGF0ZTog
TW9uLCAxMSBBcHIgMjAyMiAyMjo1OToxNiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGZpeCBpcCBk
aXNjb3ZlcnkgZmFpbGVkIC1TV0RFVi0zMzIwNTQKClVzZSBmbGV4aWJsZSBhcnJheSBtZW1iZXIg
aW4gaXAgZGlzY292ZXJ5IHN0cnVjdAoKU2lnbmVkLW9mZi1ieTogSmVzc2UgWmhhbmcgPEplc3Nl
LlpoYW5nQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNv
bT4KQ2hhbmdlLUlkOiBJNzQxMGNhODBhYjM5YjljZjBhMjk3ZWMwMGUwNDAyMTBlZjkyMjUxZAot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYyB8IDYgKysr
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNjb3ZlcnkuYwppbmRleCA3NjYw
MDZhMDc1ZWMuLmFhZjJmYzZiMWE4MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kaXNjb3ZlcnkuYwpAQCAtNzk4LDcgKzc5OCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1
X2Rpc2NvdmVyeV9zeXNmc19pcHMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQlyZXMg
PSBrb2JqZWN0X2FkZCgmaXBfaHdfaW5zdGFuY2UtPmtvYmosIE5VTEwsCiAJCQkJCSAgIiVkIiwg
aXBfaHdfaW5zdGFuY2UtPm51bV9pbnN0YW5jZSk7CiBuZXh0X2lwOgotCQkJaXBfb2Zmc2V0ICs9
IHNpemVvZigqaXApICsgNCAqIChpcC0+bnVtX2Jhc2VfYWRkcmVzcyAtIDEpOworCQkJaXBfb2Zm
c2V0ICs9IHN0cnVjdF9zaXplKGlwLCBiYXNlX2FkZHJlc3MsIGlwLT5udW1fYmFzZV9hZGRyZXNz
KTsKIAkJfQogCX0KIApAQCAtMTA2Myw3ICsxMDYzLDcgQEAgaW50IGFtZGdwdV9kaXNjb3Zlcnlf
cmVnX2Jhc2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJCX0KIAogbmV4dF9p
cDoKLQkJCWlwX29mZnNldCArPSBzaXplb2YoKmlwKSArIDQgKiAoaXAtPm51bV9iYXNlX2FkZHJl
c3MgLSAxKTsKKwkJCWlwX29mZnNldCArPSBzdHJ1Y3Rfc2l6ZShpcCwgYmFzZV9hZGRyZXNzLCBp
cC0+bnVtX2Jhc2VfYWRkcmVzcyk7CiAJCX0KIAl9CiAKQEAgLTExMTMsNyArMTExMyw3IEBAIGlu
dCBhbWRncHVfZGlzY292ZXJ5X2dldF9pcF92ZXJzaW9uKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LCBpbnQgaHdfaWQsIGludCBuCiAJCQkJCSpyZXZpc2lvbiA9IGlwLT5yZXZpc2lvbjsKIAkJ
CQlyZXR1cm4gMDsKIAkJCX0KLQkJCWlwX29mZnNldCArPSBzaXplb2YoKmlwKSArIDQgKiAoaXAt
Pm51bV9iYXNlX2FkZHJlc3MgLSAxKTsKKwkJCWlwX29mZnNldCArPSBzdHJ1Y3Rfc2l6ZShpcCwg
YmFzZV9hZGRyZXNzLCBpcC0+bnVtX2Jhc2VfYWRkcmVzcyk7CiAJCX0KIAl9CiAKLS0gCjIuMjUu
MQoK

--_002_DM4PR12MB51529669CBDA773CD36D420FE3ED9DM4PR12MB5152namp_--
