Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FFEC77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 13:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 319B310E049;
	Fri, 19 May 2023 13:10:46 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CE2310E02A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 13:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ka8ULRAbVqeKIB6bqS234C5lle/EtUb7+LyS3i1r+Y7CuKlgc+PJTHn7CYF5L7w5JaQMCHSl7ocpZR7Y9ZgthIOa2D9uRRQZaZCvYgAMTdp3Ffg9elYUxiBYfO+FQcQriuiBSAhotXfivPMS7cwXUX9UWoUQwDcQidhh+O5iOyxT3a6xJidbDSTKaK0w7ldSEyUHSUIRzvajiFHMxSr8GTsGPyER+d3VrAp0B9kmcJviR1F4EgWrWy0sQJPAHf5yv5/ApX6A8bncM7eSbtahzKaoWmS0a1QTjczC+d+k89C+17qY7HI63QY6SCwtjBu3jFJFOXWvzqtYO6vxUeuO2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TvFiWlbpYecFVJXhsdtW4J/u5VMMAnL3oEcoXkJpVg=;
 b=ioHtxud/QzuTmpbCAFmIb7Z9JRFNizDf5s/ajd3sgnL/uLi+yY46v40a3hONNNudZaCjLH0jdLOYp18VWEpEDiYxMFCVyGdkR6OaljQgjmBiQmSkpRMkFIUu1UAFE4XVxoI8XWqLXh0/e8Kh2dEJb3DMsIL5DLageVnFv325m8XRaYn5cw3waEE2bQds7s9hkPhpdjlcum/uceFx6iyEFAks9H4EI3a6Kyi8jXjF6UKeSmiQW0bQgpRlEsi0gPfhiowe3HUB2b62JM39ozPo7GiKmj5GEjkUSvT0ZEGbviwMynUmC9XHPskJ/2X6+kJbpWhaC+FnrdIR3kdlppSkQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TvFiWlbpYecFVJXhsdtW4J/u5VMMAnL3oEcoXkJpVg=;
 b=iKghtb+HmjEPYvz05g7MjYGbg3fc0nBP71GeOHmOssXApG2sk6WUngBWq0prgju7VzIOlfuUDjYWxJgGZdRZyc8QcWXCCA2RUIsahXeapGk1CTCnmZ5zgNSE7z89LNgo5z2j58FiBTXdCQGcqXsPxGjZ9uMX0N6i5bkwZTpfBGg=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 13:10:41 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::db02:3271:73cf:2431%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 13:10:40 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix unused amdgpu_acpi_get_numa_info function
 in amdgpu_acpi_get_node_id()
Thread-Topic: [PATCH] drm/amdgpu: Fix unused amdgpu_acpi_get_numa_info
 function in amdgpu_acpi_get_node_id()
Thread-Index: AQHZikx5i4Vt95uQ7UaCDbQ+IFrZp69hkcsg
Date: Fri, 19 May 2023 13:10:40 +0000
Message-ID: <BYAPR12MB4614542DA8E5849F08F3BB2F977C9@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20230519122124.328736-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230519122124.328736-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e1cb8f2c-221b-4010-b611-f02137b3278d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-19T13:09:51Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4614:EE_|SA1PR12MB6751:EE_
x-ms-office365-filtering-correlation-id: c6e3bf2f-ac90-4f5f-725b-08db586a7207
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vzthut2n05JB7EvqTwdRNIPbu0IGkmD+CSs8LvI7IuTwi8vVdYVa4cD6FKezjkQvk7BN5WhA28XGipUT9P5+C7u/jG3qHta8ZOqFeraoDXfodG76KkbgqN9eZqqFPp1+kGQxz0GOuIYOWKR/+k9cFzXCkfUAstGHIHtfPJvbu6Mh6AD9OeUE1VEiephmrPOZIP/DXEnwdZ4gb2brGpuQn2x5ozvbXeC6eQmskMYqQzOvRc46nE8ACizjZEnAZ4ZxqtOAWXRPB38yZ8cGOnbP10bsy2g8m4UL9iiVD/PCgP7Xuxy+fB7+seHAzAwtoM7kFRkcviR15XoKdpnvTV8MDpkXYisFGqrO33otSCso+5mUiG9npoHGsQyBi6JC5HHQun0WoSWShJiu84tms9N1w9KrnXSTfhuHeVZ2czxvdpxok6mKLJewihTULu2gubA0pdWnRBEIvDKJsUXfJLzJO1z0DhsUfDvzRAvQx8HHRgDvB+O50mqubqJz85hQlgX2EEoMzRU5hf8nia+vqfYxPRiV5YviegW3j3BEI7IqydGSkfX7EYKT/G+FKeb11EslCMumPSw/Od5aY2KYeNdfs3XCh4Zt96+PL/TBtpL4nEKB+og0toHiUEsL8lylwLD1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(66446008)(64756008)(66556008)(66946007)(6636002)(4326008)(76116006)(66476007)(110136005)(55016003)(8936002)(8676002)(478600001)(316002)(7696005)(41300700001)(71200400001)(2906002)(33656002)(86362001)(122000001)(53546011)(6506007)(26005)(9686003)(186003)(38070700005)(83380400001)(52536014)(38100700002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHBiNHI0T2h3eFZSNGQvZ2w0cGRuMW5RbXlYZ25DMi8raVJhY0xaTm05dkZU?=
 =?utf-8?B?WGhPQm5sZk5YekNsQ1RlVHJIeFRaOU83S1VKS1NXVHNVQjdodzZRQ1hMRXlC?=
 =?utf-8?B?dGNTeWJtY2o3bzJDR25lVUowQmUvbEV3eS9IaXZoN2prQlNJTytkd3lWalJq?=
 =?utf-8?B?QkZ4eDl3OXl2SHU5c1FMRTh6NENINTlGWHJRb1NYYUZRT0h4K3J4NmdxdmxU?=
 =?utf-8?B?SGlNLzQ1QUZ3TjFWOVg4bFRoVVJiSUd2TzVJb2FCekcvMEFFSGZoQTNIOEJl?=
 =?utf-8?B?VUt3TGJxZWJKbG5tQjFTV3RnelhxV21rMXdwU1VkVlQwWGFhMVdreDZPZDcr?=
 =?utf-8?B?allQVVVRQzhUdmFEUGJ2QXBaRXh5clJGekNkdEdxb1g0TUd5cm5wa2gyN1NC?=
 =?utf-8?B?dlZFVis2UVB4TlZ1U3ZJUU9zbzBBZGF0MStGU3BxanRnMUFkdUQySGFvS0Ey?=
 =?utf-8?B?QUpLd1RCQy9WL3hKc0hVVFU2ZEkxVkFsMy9QckhrakFPVFllWUxZaC9FV2pS?=
 =?utf-8?B?WWZlR052amZva2p6WnpTdWxPVUZTUVlIMzdlcjNFazRHZWxEdjBZbEFacGZz?=
 =?utf-8?B?M0ZGQzNJVGNMTmREVXRlcUtpbW9uUmRhbG1KNnEvNHRjQVBSQUdvd3hOUmtY?=
 =?utf-8?B?YXhlOTREaWI3ekdzbHRHYXk3Tk5OMFcwUHB6QndtckdoM0xnS3B2eEIrc3Iz?=
 =?utf-8?B?cGx4cDlLdHJ5VEduQ0w3Z0lyU2lTTVJlS0Mwa0pyTStWNlFPN1hvSmFwM2hY?=
 =?utf-8?B?NE5JNDJLVFNNMWhHVnRqVXFWZnBQSlVvdkUzZ3o5L2dWeDBrZXhDU2JucVBI?=
 =?utf-8?B?MEFKMmZGTDEwbzZhcXRzZlBzUE1idjN6ZWVYenJrTmVJejV6SGhPTTVQb3U2?=
 =?utf-8?B?Wk9DaDlkZVJFcTVYSWR3MkxJK2xIdVl6M29YNXVoczlySDREVmtmcDlRSksz?=
 =?utf-8?B?dTFkVnFrWk1oT001WHpxKzd1K0loTmh3c0RCdWdaSWtza1M2ejJjSit6OFhq?=
 =?utf-8?B?alB0L3FQejE3Y0puSzNoQ2x2c1RWRjA0M0xWekVmYWVzcTBOUWlqRzIrTVZG?=
 =?utf-8?B?MGxtQ1BTSlZMby9zdnJuQU1raEN2ZDFXYjNwckc2TEE2N293bGE3UmpBK25L?=
 =?utf-8?B?VUhJNkxGMmRMeFAxbnV0VmI1VVRkQWs4NlZCZytYMkJ2NUVpZTZJdExDVjU0?=
 =?utf-8?B?UmkxR2dONGQ0QWNFSCtqZHVtQ2ozWHBGRFN3TFQvanVtYXRscmJZWkl4ekNS?=
 =?utf-8?B?akRWMFk5c3ZWSEVRMDFaeTg3ejU1Vmpyc1JNUVdKdit5b1FOZnQ5Q1NMaEVM?=
 =?utf-8?B?NXdtQ29tRmtxNk1zTWd6QWlnTWZHYXB1eS9ua0J1TFRZaEJGMTFLTHlBMVBy?=
 =?utf-8?B?UWQ3SGNqU2FYUjZnc28rc1ZvcWR2eVNNTmFyUkVGaUhTZmZyRDJwOTNVd0FG?=
 =?utf-8?B?Ykljc3pvOGV4SzQrMmdUL3NaUkJybUFUdDNBUmlXankzdmYrMVNBcm9jNDZa?=
 =?utf-8?B?YnFhK0hjVmw0NXg1eTRMNGZZMGE3Njd4RXcyVTJER3V2MlFvaUtieDVRd2lr?=
 =?utf-8?B?RHRWbWE4ZE41QldQOWlBNmIvajhlS3d4ZVBPNlVxVk9SNmdKRzRUMjZsaGVn?=
 =?utf-8?B?cHNZSytxbmFPM0lLanVjWnJ2by9GRXlnOEZneXR0MExRanhWbnpaeW5FaXZm?=
 =?utf-8?B?d29FOGUxUERoRHJHRG9KM3B6REVYblVzbEpCbUNXcVMraVlxYmNhOFp2ZTI2?=
 =?utf-8?B?MVpiUVUyWUR6UGxBRDRhTmJ5RVNvMjhjS2hBS0RITldrMzdYRFlDTStpWk5n?=
 =?utf-8?B?WHpqb1VndUhQcm9wb3Bpb2lYbWpveXJ0L1ZZS280SERZamtjVGs4L213TVBF?=
 =?utf-8?B?RTNTbjVsaVBYRUJmUXBVcGh3UGt6UUpWeENTblkyTVF1YjNKdFJVbzBOSmVX?=
 =?utf-8?B?SWFKRm9taEFITndabFkxTFBIVjREMUd6eDRxRGxKVEhEeW5xRVlLTEFSNVZk?=
 =?utf-8?B?dVNhMzVyQldaYlY3dHUzMEdVVDFtbWtXSkJMQ1oxS1hHK0NZSHhmNWwzVE8x?=
 =?utf-8?B?TTQwWlF0ekJYRG1rTzVXNEhCdDVyaUZWV294am13MWJlQ0VXNVhCSm9TeElJ?=
 =?utf-8?Q?TqJo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e3bf2f-ac90-4f5f-725b-08db586a7207
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 13:10:40.5554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: boQzsNdvcrtqrS85gSGgSElNOcTympfbaM6+b1aXpJLPej8fNR4Ygm/4tWOfmOQn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClRoYW5rcyBmb3IgdGhlIGZpeC4g
UGxlYXNlIHVzZSBtb3ZlIHRoZSArI2lmZGVmIENPTkZJR19BQ1BJX05VTUEgdXAgYSBiaXQgdG8g
Y292ZXIgYW1kZ3B1X2FjcGlfZ2V0X251bWFfc2l6ZSBhcyB3ZWxsLg0KDQpUaGFua3MsDQpMaWpv
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTSEFOTVVHQU0sIFNSSU5JVkFT
QU4gPFNSSU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQpTZW50OiBGcmlkYXksIE1heSAxOSwg
MjAyMyA1OjUxIFBNDQpUbzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IFR1
aWtvdiwgTHViZW4gPEx1YmVuLlR1aWtvdkBhbWQuY29tPjsgTGF6YXIsIExpam8gPExpam8uTGF6
YXJAYW1kLmNvbT4NCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgU0hBTk1VR0FN
LCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29tPg0KU3ViamVjdDogW1BB
VENIXSBkcm0vYW1kZ3B1OiBGaXggdW51c2VkIGFtZGdwdV9hY3BpX2dldF9udW1hX2luZm8gZnVu
Y3Rpb24gaW4gYW1kZ3B1X2FjcGlfZ2V0X25vZGVfaWQoKQ0KDQpGaXggdGhlIGJlbG93IGNvbXBp
bGVyIGNvbXBsYWluaW5nIGVycm9yOg0KDQpkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYWNwaS5jOjg2MDozMzogZXJyb3I6IHVudXNlZCBmdW5jdGlvbiAnYW1kZ3B1X2FjcGlfZ2V0
X251bWFfaW5mbycgWy1XZXJyb3IsLVd1bnVzZWQtZnVuY3Rpb25dIHN0YXRpYyBzdHJ1Y3QgYW1k
Z3B1X251bWFfaW5mbyAqYW1kZ3B1X2FjcGlfZ2V0X251bWFfaW5mbyh1aW50MzJfdCBweG0pDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCjEgZXJyb3IgZ2VuZXJhdGVkLg0KDQpC
eSBndWFyZGluZyBhbWRncHVfYWNwaV9nZXRfbnVtYV9pbmZvIGZ1bmN0aW9uLCBvbmx5IHdoZW4g
Q09ORklHX0FDUElfTlVNQSBpcyBlbmFibGVkLg0KDQpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KQ2M6IExpam8gTGF6YXIgPGxpam8ubGF6YXJAYW1kLmNv
bT4NCkNjOiBMdWJlbiBUdWlrb3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tPg0KQ2M6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IFNyaW5pdmFz
YW4gU2hhbm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KLS0tDQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYyB8IDIgKysNCiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYWNwaS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Fj
cGkuYw0KaW5kZXggNzE1MGMwOTkzM2NmLi45NDMzNTk2MDc2ZDAgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jDQorKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jDQpAQCAtODU3LDYgKzg1Nyw3IEBAIHN0YXRpYyBp
bmxpbmUgdWludDY0X3QgYW1kZ3B1X2FjcGlfZ2V0X251bWFfc2l6ZShpbnQgbmlkKQ0KICAgICAg
ICByZXR1cm4gbWFuYWdlZF9wYWdlcyAqIFBBR0VfU0laRTsNCiB9DQoNCisjaWZkZWYgQ09ORklH
X0FDUElfTlVNQQ0KIHN0YXRpYyBzdHJ1Y3QgYW1kZ3B1X251bWFfaW5mbyAqYW1kZ3B1X2FjcGlf
Z2V0X251bWFfaW5mbyh1aW50MzJfdCBweG0pICB7DQogICAgICAgIHN0cnVjdCBhbWRncHVfbnVt
YV9pbmZvICpudW1hX2luZm87DQpAQCAtODg2LDYgKzg4Nyw3IEBAIHN0YXRpYyBzdHJ1Y3QgYW1k
Z3B1X251bWFfaW5mbyAqYW1kZ3B1X2FjcGlfZ2V0X251bWFfaW5mbyh1aW50MzJfdCBweG0pDQoN
CiAgICAgICAgcmV0dXJuIG51bWFfaW5mbzsNCiB9DQorI2VuZGlmDQoNCiAvKioNCiAgKiBhbWRn
cHVfYWNwaV9nZXRfbm9kZV9pZCAtIG9idGFpbiB0aGUgTlVNQSBub2RlIGlkIGZvciBjb3JyZXNw
b25kaW5nIGFtZGdwdQ0KLS0NCjIuMjUuMQ0KDQo=
