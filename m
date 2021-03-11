Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1B6C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 15:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A165864F99
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 15:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A165864F99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EC836EE0C;
	Thu, 11 Mar 2021 15:40:49 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2055.outbound.protection.outlook.com [40.107.101.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B40096EE07
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Mar 2021 15:40:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5C4NxUSdEDQOJ7FM6aTg+z+AecrWuZ8DOPGPElDCVbDl8BvRXIYfybK5uku5tsIopk2xMSiHsoSeginVK4vwiGEyD6CAEAUX43CnifPqb39/vq8zI6OwQXbpLJOKMIZMlM2mCdesZWeVILG+shEkFK6fo3ZRmWRtG0QUFP9GVACp43sE7dmK/mL/ZLj/Q2TpkUJOOX70xLRKLVnJ2OF4RDyY7fW/pRwcoS0lKv51bvk95OSIlc4uyrIvC/ujbd+KzXp76xsBgrHJOODP/naG+Qqj+YYV5V1gvNa3qIkwRuK6GcZoojBSPbVJPl6eYnjeLiujPf+mWgTqbRGtiDGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRbyT7xrYalV9ijOBC5742VNhJP/J9vm2RRWeQGnRMQ=;
 b=llBuK6datB2jZCNOOb4Y0zNDM9Zb4davYfSyljZTuEEgEogJ4+tcpRbTptTdvDe0eY2FWS73v56zrBMLHQY2l4YNzVFMpVSRC7stBGD7p6ePN/bMGrROicmqhBVAGGVHldNWW75uj06gJNQZXlOL5QkjDujvzUkc/l+Eor6pOfL8t4qrU8i0TCuyKglTZtiYiDar3kO7V2uXwTOn1HZ5UXHNyFzygU6wlg1wrPXw+vCbEIu/Pj2UoseAsml5AcW+scV/IQ65hG/OFJIe/BdIEjO+JUnKHhUeWktSl0a2AsJ51Hk+ljqe3YxBxPkgmyuQLIMAxekkL/JsQdtcdIEdfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRbyT7xrYalV9ijOBC5742VNhJP/J9vm2RRWeQGnRMQ=;
 b=QO4pOq03AaCLsPA1zjW06RbWbohkpFvT6NcRujbpWkxeBF03lLxWl0rOnyz3jE2ulowTeK4qK/fFL39SQL/fFgLJ00FHhwE17SziI8nAcBuUiq+w7+tFv7VqPjJOmhZdauE5lK3KCbNeaj8DUa45hBPOkfoEZ4r6wWfBOgmNbcc=
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10)
 by DM5PR12MB1145.namprd12.prod.outlook.com (2603:10b6:3:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Thu, 11 Mar
 2021 15:40:44 +0000
Received: from DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::28e0:5877:b4e6:6bdc]) by DM5PR1201MB0204.namprd12.prod.outlook.com
 ([fe80::28e0:5877:b4e6:6bdc%9]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 15:40:43 +0000
From: "Zhang, Jack (Jian)" <Jack.Zhang1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Liu, Monk"
 <Monk.Liu@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH v7] drm/amd/amdgpu implement tdr advanced mode
Thread-Topic: [PATCH v7] drm/amd/amdgpu implement tdr advanced mode
Thread-Index: AQHXFju1UE+NnWQNtkW8Cn+tvO40R6p+mZuAgAAbTjOAADgnWg==
Date: Thu, 11 Mar 2021 15:40:43 +0000
Message-ID: <DM5PR1201MB0204013D8BE813FE5D15D0D9BB909@DM5PR1201MB0204.namprd12.prod.outlook.com>
References: <20210311055838.980188-1-Jack.Zhang1@amd.com>,
 <a7108500-6d23-f674-959b-94fc988ba3af@amd.com>,
 <DM5PR1201MB0204B2725774B55A2DA57706BB909@DM5PR1201MB0204.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR1201MB0204B2725774B55A2DA57706BB909@DM5PR1201MB0204.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-11T12:18:48.1780789Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.246.140.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 97399994-bb29-4624-d2a7-08d8e4a4086b
x-ms-traffictypediagnostic: DM5PR12MB1145:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11459A0F5302E8DE3ED1756FBB909@DM5PR12MB1145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /8JE4rMFUJRXx+TCFhr3auFKHLLn+/FDr95iXqtTk8/AlHlkmkH9g6kcCxJsP4VelZd84tvWcGdeNxMWFX2wazE25fjP/CsBYSIUQwi2isTguIikM3MLWn8myLHB+xkwzCNWE8istv6+CMV1MukshigMLPqqxERJnRW1si83nritW8ZIi7PmxsjLVbsBiMPQIKVHOR0+O0fXnBTnyZeRN2tnxAaOPlnBl/qcGpBlbYWl79KmIcN1FpCiZbr4p/3kZ1wRJrgp5ln6IvrrkhyWMug98y09K8UD8pEt99c3hoAucD5ehs+BGRY3HRZgXl/s2ftapTS57edDQy/A8NeWoBg2dzp+jfes1R+tvIilQwnFN4J/v3YREUjycEE1jcfBKQk0UtQlpWsvvlELhV7fytsZyqd5AjukBlMNCKybzCL2sKhL8+vuLNzK0PbyBbopArOrGg3I0izN/o/FXf9PKupwC+Lju69cgdPl4vl0qDeJjv8sdV9UzRtUBQHIOFN8pDox97pD6qe49f1VCHqz+w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0204.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(5660300002)(6506007)(66446008)(26005)(33656002)(53546011)(30864003)(83380400001)(76116006)(91956017)(478600001)(64756008)(66946007)(66556008)(66476007)(2906002)(110136005)(186003)(52536014)(71200400001)(86362001)(2940100002)(55016002)(9686003)(8936002)(8676002)(6636002)(316002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?gb2312?B?SnUzNDdsa1Y5MlR2UWVyMGtuSjhxcHhPcUJLZU5GMisybTBoa2dwWTVFdm9N?=
 =?gb2312?B?NVN6T0tUVnZCVVRLaU03TllNYThXbTNYRGR5TG15QUwxdTVhdStDdHR2WXlO?=
 =?gb2312?B?VnRQYkp4N0FCTFRhYWpUWGllMFZUeHBPV2l1YlZNa2tmUWJvZ08vU2Ntckty?=
 =?gb2312?B?WEpsRXFEaUtQbmk5Mk45b21HeE9tMjc4WXp6OWFxWWt1VWdQZGszanBUZEdW?=
 =?gb2312?B?aTVuTGJOT3BvZHBIUFByRS9aVTZFZXNGM05FaWFHVG9JRGZhL3VIZ2JGZGtT?=
 =?gb2312?B?RW9LUVlQZXc0bCsyT3JQMjFSdzdSTWhremxWODNEeHBMUTBQUWFjc21BZTVv?=
 =?gb2312?B?RHB0cWt0Q1lWVi81cjQzOUJLRXhsTmlSZEMwR2Z5Wk1oSlNBU0NiV2dyRGZ1?=
 =?gb2312?B?R0h2YUJtTytPY1RVNlRtOTFOOStLaTlQdHIzQXJNTkRMcFAzV2c3aWxYOEU5?=
 =?gb2312?B?c2xicEkxdVJtYllGZ3l3aHVpa0Y1WjlOWkxxUnhuUXBkbjJlRm5iRklDMEE3?=
 =?gb2312?B?Sk5VQ0pweVR4S0pvMHI3QmlZbllsU3RiOFBGajZ1eTZyeTFlL3ZiNTNaZHV1?=
 =?gb2312?B?UjBrKzhZR2lIZllRZ0VaR2R3NmowS0JNb2hab0tWd1hBMWx5STRXTzc0V2RE?=
 =?gb2312?B?QXJ3WlhwVm1tU0pwOTdpR2dQRVlqdnA2Yi96a1pyYmFqMWkyTDlISXYxY3VV?=
 =?gb2312?B?c0phenA1L3ZJZ29RdUVmVmp5MkJ2ejg1cWNEN1d1djVRVmlKVEtTV3FpZWdH?=
 =?gb2312?B?WUlTZU12N0RuK0ZueDNEdkJONlRKNEE2TmxneVJQUVlDV0ZVUjYyWndvWUFi?=
 =?gb2312?B?RU5yNEUxYVhLV2FENk9YUHRpS0ZjdVFZeE1ES2VobFZabml4V2NsSmsvdjdE?=
 =?gb2312?B?Uml6MEtwVk1IT3pvRk16Ym9ZYk1qb3h4aXRDc1RlTHQva3RNU3dYd1hxTnZx?=
 =?gb2312?B?bXVoazRpOS91ZVFzT1E5eXZwa1Y3MzlucmJ5ZkxKbUJHZE84WFgyREN3RTQ3?=
 =?gb2312?B?Sk43aHU0STE3TTM5a2N5N0l4N2NPdll3KzhRTitFVXE4aXNGcUJFcGFhSmE1?=
 =?gb2312?B?cUYvUWUxWEhwMHFjaU9EdlRWTERLU1EySXNEVWV2Q1llUXZBbG81TG05MHRJ?=
 =?gb2312?B?dkxTMVZna0dLUFJNTUQ0cTU4S0hKMlBhU1ljeVJZZkMzNC9KdCtBNGxnOXVN?=
 =?gb2312?B?VG4rMlh2aWNKaytrVzRmUmVVTlpMQTQrZUNlWXlQMXlMSEd1bGNSa2hEcFRx?=
 =?gb2312?B?Y0RmaTFvUW92aGoreExZZFBJdmxCeXFaSXZ5R0RWMDBtd3pSNmc1bTFYV1dS?=
 =?gb2312?B?Q1ltK1ZHVi8vS1JaLy9Hbmd5ZEh5VW5hMkhzRy9CMkd1eGczZTdnSktNM09L?=
 =?gb2312?B?cDB2dlA0Wi93azloWTNpa1RJdTFHWlc5Q3FOTnVTTDNFdzU4aWVBdWJ1cml4?=
 =?gb2312?B?RzVUeGVhUzlXeXVwbUNhV3lEc2ZkQnlMdzhCYW1ORkVMQVYrU0YwcVFmQzg1?=
 =?gb2312?B?TmxhWHJrZUczWmE0MENHRkpPblF4S3BmV0ZJVGdYZHkrV3BicEZQbFZaZi9J?=
 =?gb2312?B?dDZ2VEhqVlBDUE5CSHF0TWJnY0ptczVkTW9oMmYyWU05MHRSaEE3Uk0rL2pi?=
 =?gb2312?B?OGRuRGNuRGVxckFnd2FaTVF1dVN2Z1h0WDRCbXlWTG5RVFlkVGdPRlBOeVAr?=
 =?gb2312?B?NStjUEk3MkF4dENxSGs3R1dMRGV6Rkp5RGlDOVFzTDNkMXNNaHRMQnU5NUhn?=
 =?gb2312?B?d0VTRDhxYUtXam1aeE43djJYdmxoVGI3Zm5LdER4NHFOWWVTUTVkT0NFQXVs?=
 =?gb2312?B?TW5WeGwrZ3Y1dm1XaUpsUT09?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0204.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97399994-bb29-4624-d2a7-08d8e4a4086b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 15:40:43.8899 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZUSlSuHQuqupPial80in9Pmg93ivenI8Qi4JqW0x/sB7uQKyfvo3/K+167Yftjn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
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
Content-Type: multipart/mixed; boundary="===============1161715170=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1161715170==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_DM5PR1201MB0204013D8BE813FE5D15D0D9BB909DM5PR1201MB0204_"

--_000_DM5PR1201MB0204013D8BE813FE5D15D0D9BB909DM5PR1201MB0204_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpo
aaOsQW5kcmV5IGFuZCBDaHJpc3RpYW6jrA0KDQpWOCBwYXRjaCBpcyB1cGxvYWRlZC4NCg0KDQpU
aGFua3OjrA0KSmFjaw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjL
OiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPiC0+rHtIFpo
YW5nLCBKYWNrIChKaWFuKSA8SmFjay5aaGFuZzFAYW1kLmNvbT4NCreiy83KsbzkOiAyMDIxxOoz
1MIxMcjV0MfG2svEIM/Czuc4OjIwDQrK1bz+yMs6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnOyBHcm9kem92c2t5LCBBbmRyZXk7IExpdSwgTW9uazsgRGVuZywgRW1pbHk7IEtvZW5pZywg
Q2hyaXN0aWFuDQrW98ziOiBSZTogW1BBVENIIHY3XSBkcm0vYW1kL2FtZGdwdSBpbXBsZW1lbnQg
dGRyIGFkdmFuY2VkIG1vZGUNCg0KDQpbQU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwg
RGlzdHJpYnV0aW9uIE9ubHldDQoNCg0KW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFs
IERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQpoaaOsQ2hyaXN0aWFuo6wNCg0KR29vZCBpZGVho6x0aGFu
ayB5b3UgZm9yIHRoZXNlIGVmZm9ydHMuDQpJIHdpbGwgdXBkYXRlIGluIG5leHQgdmVyc2lvbi4N
Cg0KSmFjaw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJvbTogS29lbmln
LCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClNlbnQ6IFRodXJzZGF5LCBN
YXJjaCAxMSwgMjAyMSA2OjQxOjA1IFBNDQpUbzogWmhhbmcsIEphY2sgKEppYW4pIDxKYWNrLlpo
YW5nMUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcgPGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnPjsgR3JvZHpvdnNreSwgQW5kcmV5IDxBbmRyZXkuR3JvZHpvdnNr
eUBhbWQuY29tPjsgTGl1LCBNb25rIDxNb25rLkxpdUBhbWQuY29tPjsgRGVuZywgRW1pbHkgPEVt
aWx5LkRlbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjddIGRybS9hbWQvYW1kZ3B1
IGltcGxlbWVudCB0ZHIgYWR2YW5jZWQgbW9kZQ0KDQoNCg0KQW0gMTEuMDMuMjEgdW0gMDY6NTgg
c2NocmllYiBKYWNrIFpoYW5nOg0KPiBbV2h5XQ0KPiBQcmV2aW91cyB0ZHIgZGVzaWduIHRyZWF0
cyB0aGUgZmlyc3Qgam9iIGluIGpvYl90aW1lb3V0IGFzIHRoZSBiYWQgam9iLg0KPiBCdXQgc29t
ZXRpbWVzIGEgbGF0ZXIgYmFkIGNvbXB1dGUgam9iIGNhbiBibG9jayBhIGdvb2QgZ2Z4IGpvYiBh
bmQNCj4gY2F1c2UgYW4gdW5leHBlY3RlZCBnZnggam9iIHRpbWVvdXQgYmVjYXVzZSBnZnggYW5k
IGNvbXB1dGUgcmluZyBzaGFyZQ0KPiBpbnRlcm5hbCBHQyBIVyBtdXR1YWxseS4NCj4NCj4gW0hv
d10NCj4gVGhpcyBwYXRjaCBpbXBsZW1lbnRzIGFuIGFkdmFuY2VkIHRkciBtb2RlLkl0IGludm9s
dmVzIGFuIGFkZGl0aW5hbA0KPiBzeW5jaHJvbm91cyBwcmUtcmVzdWJtaXQgc3RlcChTdGVwMCBS
ZXN1Ym1pdCkgYmVmb3JlIG5vcm1hbCByZXN1Ym1pdA0KPiBzdGVwIGluIG9yZGVyIHRvIGZpbmQg
dGhlIHJlYWwgYmFkIGpvYi4NCj4NCj4gMS4gQXQgU3RlcDAgUmVzdWJtaXQgc3RhZ2UsIGl0IHN5
bmNocm9ub3VzbHkgc3VibWl0cyBhbmQgcGVuZHMgZm9yIHRoZQ0KPiBmaXJzdCBqb2IgYmVpbmcg
c2lnbmFsZWQuIElmIGl0IGdldHMgdGltZW91dCwgd2UgaWRlbnRpZnkgaXQgYXMgZ3VpbHR5DQo+
IGFuZCBkbyBodyByZXNldC4gQWZ0ZXIgdGhhdCwgd2Ugd291bGQgZG8gdGhlIG5vcm1hbCByZXN1
Ym1pdCBzdGVwIHRvDQo+IHJlc3VibWl0IGxlZnQgam9icy4NCj4NCj4gMi4gRm9yIHdob2xlIGdw
dSByZXNldCh2cmFtIGxvc3QpLCBkbyByZXN1Ym1pdCBhcyB0aGUgb2xkIHdheS4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogSmFjayBaaGFuZyA8SmFjay5aaGFuZzFAYW1kLmNvbT4NCj4gLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgIDYzICsrKysrKysr
KysrKw0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyAgICB8ICAg
MiArLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jICAgICB8IDEw
NyArKysrKysrKysrKysrKystLS0tLS0NCj4gICBpbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmgg
ICAgICAgICAgICAgICAgfCAgIDMgKw0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTQyIGluc2VydGlv
bnMoKyksIDMzIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jDQo+IGluZGV4IGUyNDdjM2EyZWMwOC4uNWIxODJhZGUyNmFkIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+IEBAIC00
NjM5LDYgKzQ2MzksNyBAQCBpbnQgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcihzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwNCj4gICAgICAgIGludCBpLCByID0gMDsNCj4gICAgICAgIGJvb2wg
bmVlZF9lbWVyZ2VuY3lfcmVzdGFydCA9IGZhbHNlOw0KPiAgICAgICAgYm9vbCBhdWRpb19zdXNw
ZW5kZWQgPSBmYWxzZTsNCj4gKyAgICAgaW50IHRtcF92cmFtX2xvc3RfY291bnRlcjsNCj4NCj4g
ICAgICAgIC8qDQo+ICAgICAgICAgKiBTcGVjaWFsIGNhc2U6IFJBUyB0cmlnZ2VyZWQgYW5kIGZ1
bGwgcmVzZXQgaXNuJ3Qgc3VwcG9ydGVkDQo+IEBAIC00Nzg4LDYgKzQ3ODksNyBAQCBpbnQgYW1k
Z3B1X2RldmljZV9ncHVfcmVjb3ZlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAg
ICAgICAgICAgICAgfQ0KPiAgICAgICAgfQ0KPg0KPiArICAgICB0bXBfdnJhbV9sb3N0X2NvdW50
ZXIgPSBhdG9taWNfcmVhZCgmKChhZGV2KS0+dnJhbV9sb3N0X2NvdW50ZXIpKTsNCj4gICAgICAg
IC8qIEFjdHVhbCBBU0lDIHJlc2V0cyBpZiBuZWVkZWQuKi8NCj4gICAgICAgIC8qIFRPRE8gSW1w
bGVtZW50IFhHTUkgaGl2ZSByZXNldCBsb2dpYyBmb3IgU1JJT1YgKi8NCj4gICAgICAgIGlmIChh
bWRncHVfc3Jpb3ZfdmYoYWRldikpIHsNCj4gQEAgLTQ4MDUsNiArNDgwNyw2NyBAQCBpbnQgYW1k
Z3B1X2RldmljZV9ncHVfcmVjb3ZlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gICAg
ICAgIC8qIFBvc3QgQVNJQyByZXNldCBmb3IgYWxsIGRldnMgLiovDQo+ICAgICAgICBsaXN0X2Zv
cl9lYWNoX2VudHJ5KHRtcF9hZGV2LCBkZXZpY2VfbGlzdF9oYW5kbGUsIGdtYy54Z21pLmhlYWQp
IHsNCj4NCj4gKyAgICAgICAgICAgICBpZiAoYW1kZ3B1X2dwdV9yZWNvdmVyeSA9PSAyICYmDQo+
ICsgICAgICAgICAgICAgICAgICAgICAhKHRtcF92cmFtX2xvc3RfY291bnRlciA8IGF0b21pY19y
ZWFkKCZhZGV2LT52cmFtX2xvc3RfY291bnRlcikpKSB7DQo+ICsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgIGZvciAoaSA9IDA7IGkgPCBBTURHUFVfTUFYX1JJTkdTOyArK2kpIHsNCg0KU3RhcnRp
bmcgZnJvbSBoZXJlIEkgd291bGQgcHV0IHRoaXMgaW50byBhIHNlcGFyYXRlIGhlbHBlciBmdW5j
dGlvbiBpbg0KYW1kZ3B1X3JpbmcuYy4NCg0KWW91IHNob3VsZCBhbHNvIHByb2JhYmx5IHVzZSBj
aGVja3BhdGNoLnBsIG9uY2UgbW9yZSBzaW5jZSBhIGNvdXBsZSBvZg0KbGluZXMgYmVsb3cgbWln
aHQgcmVzdWx0IGluIHdhcm5pbmdzLg0KDQpDaHJpc3RpYW4uDQoNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nID0gdG1wX2FkZXYtPnJpbmdz
W2ldOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgcmV0ID0gMDsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRybV9zY2hlZF9qb2IgKnNfam9iOw0K
PiArDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICghcmluZyB8fCAhcmluZy0+
c2NoZWQudGhyZWFkKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bnRpbnVlOw0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIE5vIHBvaW50
IHRvIHJlc3VibWl0IGpvYnMgaWYgd2UgZGlkbid0IEhXIHJlc2V0Ki8NCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKCF0bXBfYWRldi0+YXNpY19yZXNldF9yZXMgJiYgIWpvYl9z
aWduYWxlZCkgew0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c19qb2IgPSBsaXN0X2ZpcnN0X2VudHJ5X29yX251bGwoJnJpbmctPnNjaGVkLnBlbmRpbmdfbGlz
dCwgc3RydWN0IGRybV9zY2hlZF9qb2IsIGxpc3QpOw0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGlmIChzX2pvYiA9PSBOVUxMKQ0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ICsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBjbGVhciBqb2IncyBndWlsdHkgYW5kIGRlcGVu
ZCB0aGUgZm9sb3dpbmcgc3RlcCB0byBkZWNpZGUgdGhlIHJlYWwgb25lICovDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZHJtX3NjaGVkX3Jlc2V0X2thcm1hKHNfam9i
KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkcm1fc2NoZWRfcmVz
dWJtaXRfam9ic19leHQoJnJpbmctPnNjaGVkLCAxKTsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICByZXQgPSBkbWFfZmVuY2Vfd2FpdF90aW1lb3V0KHNfam9iLT5zX2Zl
bmNlLT5wYXJlbnQsIGZhbHNlLCByaW5nLT5zY2hlZC50aW1lb3V0KTsNCj4gKw0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQgPT0gMCkgeyAvKiB0aW1lb3V0
ICovDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBEUk1f
RVJST1IoIkZvdW5kIHRoZSByZWFsIGJhZCBqb2IhIHJpbmc6JXMsIGpvYl9pZDolbGx4XG4iLCBy
aW5nLT5zY2hlZC5uYW1lLCBzX2pvYi0+aWQpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgLyogc2V0IGd1aWx0eSAqLw0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZHJtX3NjaGVkX2luY3JlYXNlX2thcm1hKHNf
am9iKTsNCj4gKw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLyogZG8gaHcgcmVzZXQgKi8NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X3ZpcnRfZmlu
aV9kYXRhX2V4Y2hhbmdlKGFkZXYpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICByID0gYW1kZ3B1X2RldmljZV9yZXNldF9zcmlvdihhZGV2
LCBmYWxzZSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGlmIChyKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPmFzaWNfcmVzZXRfcmVzID0gcjsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHIgID0g
YW1kZ3B1X2RvX2FzaWNfcmVzZXQoaGl2ZSwgZGV2aWNlX2xpc3RfaGFuZGxlLCAmbmVlZF9mdWxs
X3Jlc2V0LCBmYWxzZSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGlmIChyICYmIHIgPT0gLUVBR0FJTikNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHJldHJ5
Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiAr
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBhZGQg
cmVzZXQgY291bnRlciBzbyB0aGF0IHRoZSBmb2xsb3dpbmcgcmVzdWJtaXR0ZWQgam9iIGNvdWxk
IGZsdXNoIHZtaWQgKi8NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGF0b21pY19pbmMoJnRtcF9hZGV2LT5ncHVfcmVzZXRfY291bnRlcik7DQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ICsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBnb3QgdGhlIGh3IGZlbmNlLCBzaWduYWwgZmlu
aXNoZWQgZmVuY2UgKi8NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBh
dG9taWNfZGVjKCZyaW5nLT5zY2hlZC5udW1fam9icyk7DQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZG1hX2ZlbmNlX2dldCgmc19qb2ItPnNfZmVuY2UtPmZpbmlzaGVk
KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkbWFfZmVuY2Vfc2ln
bmFsKCZzX2pvYi0+c19mZW5jZS0+ZmluaXNoZWQpOw0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGRtYV9mZW5jZV9wdXQoJnNfam9iLT5zX2ZlbmNlLT5maW5pc2hlZCk7
DQo+ICsNCj4gKw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8qIHJl
bW92ZSBub2RlIGZyb20gbGlzdCBhbmQgZnJlZSB0aGUgam9iICovDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc3Bpbl9sb2NrKCZyaW5nLT5zY2hlZC5qb2JfbGlzdF9s
b2NrKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaXN0X2RlbF9p
bml0KCZzX2pvYi0+bm9kZSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc3Bpbl91bmxvY2soJnJpbmctPnNjaGVkLmpvYl9saXN0X2xvY2spOw0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJpbmctPnNjaGVkLm9wcy0+ZnJlZV9qb2Ioc19q
b2IpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgICAgICAg
ICAgICAgICB9DQo+ICsgICAgICAgICAgICAgfQ0KPiArDQo+ICAgICAgICAgICAgICAgIGZvciAo
aSA9IDA7IGkgPCBBTURHUFVfTUFYX1JJTkdTOyArK2kpIHsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSB0bXBfYWRldi0+cmluZ3NbaV07DQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMNCj4gaW5kZXggODY1ZjkyNDc3
MmIwLi45YzNmNGVkYjc1MzIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kcnYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZHJ2LmMNCj4gQEAgLTUwOSw3ICs1MDksNyBAQCBtb2R1bGVfcGFyYW1fbmFtZWQoY29tcHV0
ZV9tdWx0aXBpcGUsIGFtZGdwdV9jb21wdXRlX211bHRpcGlwZSwgaW50LCAwNDQ0KTsNCj4gICAg
KiBET0M6IGdwdV9yZWNvdmVyeSAoaW50KQ0KPiAgICAqIFNldCB0byBlbmFibGUgR1BVIHJlY292
ZXJ5IG1lY2hhbmlzbSAoMSA9IGVuYWJsZSwgMCA9IGRpc2FibGUpLiBUaGUgZGVmYXVsdCBpcyAt
MSAoYXV0bywgZGlzYWJsZWQgZXhjZXB0IFNSSU9WKS4NCj4gICAgKi8NCj4gLU1PRFVMRV9QQVJN
X0RFU0MoZ3B1X3JlY292ZXJ5LCAiRW5hYmxlIEdQVSByZWNvdmVyeSBtZWNoYW5pc20sICgxID0g
ZW5hYmxlLCAwID0gZGlzYWJsZSwgLTEgPSBhdXRvKSIpOw0KPiArTU9EVUxFX1BBUk1fREVTQyhn
cHVfcmVjb3ZlcnksICJFbmFibGUgR1BVIHJlY292ZXJ5IG1lY2hhbmlzbSwgKDIgPSBhZHZhbmNl
ZCB0ZHIgbW9kZSwgMSA9IGVuYWJsZSwgMCA9IGRpc2FibGUsIC0xID0gYXV0bykiKTsNCj4gICBt
b2R1bGVfcGFyYW1fbmFtZWQoZ3B1X3JlY292ZXJ5LCBhbWRncHVfZ3B1X3JlY292ZXJ5LCBpbnQs
IDA0NDQpOw0KPg0KPiAgIC8qKg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3NjaGVk
dWxlci9zY2hlZF9tYWluLmMgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4u
Yw0KPiBpbmRleCBkODJhN2ViZjYwOTkuLmJiMGExMjlkMWY0MCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMNCj4gQEAgLTM2MSw0MCArMzYxLDE2IEBAIHN0YXRp
YyB2b2lkIGRybV9zY2hlZF9qb2JfdGltZWRvdXQoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0K
PiAgICAgKi8NCj4gICB2b2lkIGRybV9zY2hlZF9pbmNyZWFzZV9rYXJtYShzdHJ1Y3QgZHJtX3Nj
aGVkX2pvYiAqYmFkKQ0KPiAgIHsNCj4gLSAgICAgaW50IGk7DQo+IC0gICAgIHN0cnVjdCBkcm1f
c2NoZWRfZW50aXR5ICp0bXA7DQo+IC0gICAgIHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5ICplbnRp
dHk7DQo+IC0gICAgIHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQgPSBiYWQtPnNjaGVk
Ow0KPiAtDQo+IC0gICAgIC8qIGRvbid0IGluY3JlYXNlIEBiYWQncyBrYXJtYSBpZiBpdCdzIGZy
b20gS0VSTkVMIFJRLA0KPiAtICAgICAgKiBiZWNhdXNlIHNvbWV0aW1lcyBHUFUgaGFuZyB3b3Vs
ZCBjYXVzZSBrZXJuZWwgam9icyAobGlrZSBWTSB1cGRhdGluZyBqb2JzKQ0KPiAtICAgICAgKiBj
b3JydXB0IGJ1dCBrZWVwIGluIG1pbmQgdGhhdCBrZXJuZWwgam9icyBhbHdheXMgY29uc2lkZXJl
ZCBnb29kLg0KPiAtICAgICAgKi8NCj4gLSAgICAgaWYgKGJhZC0+c19wcmlvcml0eSAhPSBEUk1f
U0NIRURfUFJJT1JJVFlfS0VSTkVMKSB7DQo+IC0gICAgICAgICAgICAgYXRvbWljX2luYygmYmFk
LT5rYXJtYSk7DQo+IC0gICAgICAgICAgICAgZm9yIChpID0gRFJNX1NDSEVEX1BSSU9SSVRZX01J
TjsgaSA8IERSTV9TQ0hFRF9QUklPUklUWV9LRVJORUw7DQo+IC0gICAgICAgICAgICAgICAgICBp
KyspIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBkcm1fc2NoZWRfcnEgKnJxID0g
JnNjaGVkLT5zY2hlZF9ycVtpXTsNCj4gLQ0KPiAtICAgICAgICAgICAgICAgICAgICAgc3Bpbl9s
b2NrKCZycS0+bG9jayk7DQo+IC0gICAgICAgICAgICAgICAgICAgICBsaXN0X2Zvcl9lYWNoX2Vu
dHJ5X3NhZmUoZW50aXR5LCB0bXAsICZycS0+ZW50aXRpZXMsIGxpc3QpIHsNCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKGJhZC0+c19mZW5jZS0+c2NoZWR1bGVkLmNvbnRleHQg
PT0NCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudGl0eS0+ZmVuY2VfY29u
dGV4dCkgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChhdG9t
aWNfcmVhZCgmYmFkLT5rYXJtYSkgPg0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBiYWQtPnNjaGVkLT5oYW5nX2xpbWl0KQ0KPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGVudGl0eS0+Z3VpbHR5KQ0KPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhdG9taWNfc2V0
KGVudGl0eS0+Z3VpbHR5LCAxKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBicmVhazsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiAtICAgICAg
ICAgICAgICAgICAgICAgfQ0KPiAtICAgICAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2soJnJx
LT5sb2NrKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgIGlmICgmZW50aXR5LT5saXN0ICE9ICZy
cS0+ZW50aXRpZXMpDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAt
ICAgICAgICAgICAgIH0NCj4gLSAgICAgfQ0KPiArICAgICBkcm1fc2NoZWRfaW5jcmVhc2Vfa2Fy
bWFfZXh0KGJhZCwgMSk7DQo+ICAgfQ0KPiAgIEVYUE9SVF9TWU1CT0woZHJtX3NjaGVkX2luY3Jl
YXNlX2thcm1hKTsNCj4NCj4gK3ZvaWQgZHJtX3NjaGVkX3Jlc2V0X2thcm1hKHN0cnVjdCBkcm1f
c2NoZWRfam9iICpiYWQpDQo+ICt7DQo+ICsgICAgIGRybV9zY2hlZF9pbmNyZWFzZV9rYXJtYV9l
eHQoYmFkLCAwKTsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0woZHJtX3NjaGVkX3Jlc2V0X2thcm1h
KTsNCj4gKw0KPiAgIC8qKg0KPiAgICAqIGRybV9zY2hlZF9zdG9wIC0gc3RvcCB0aGUgc2NoZWR1
bGVyDQo+ICAgICoNCj4gQEAgLTUzMywxNSArNTA5LDMyIEBAIEVYUE9SVF9TWU1CT0woZHJtX3Nj
aGVkX3N0YXJ0KTsNCj4gICAgKg0KPiAgICAqLw0KPiAgIHZvaWQgZHJtX3NjaGVkX3Jlc3VibWl0
X2pvYnMoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCkNCj4gK3sNCj4gKyAgICAgZHJt
X3NjaGVkX3Jlc3VibWl0X2pvYnNfZXh0KHNjaGVkLCBJTlRfTUFYKTsNCj4gK30NCj4gK0VYUE9S
VF9TWU1CT0woZHJtX3NjaGVkX3Jlc3VibWl0X2pvYnMpOw0KPiArDQo+ICsvKioNCj4gKyAqIGRy
bV9zY2hlZF9yZXN1Ym1pdF9qb2JzX2V4dCAtIGhlbHBlciB0byByZWx1bmNoIGNlcnRhaW4gbnVt
YmVyIG9mIGpvYnMgZnJvbSBtaXJyb3IgcmluZyBsaXN0DQo+ICsgKg0KPiArICogQHNjaGVkOiBz
Y2hlZHVsZXIgaW5zdGFuY2UNCj4gKyAqIEBtYXg6IGpvYiBudW1iZXJzIHRvIHJlbGF1bmNoDQo+
ICsgKg0KPiArICovDQo+ICt2b2lkIGRybV9zY2hlZF9yZXN1Ym1pdF9qb2JzX2V4dChzdHJ1Y3Qg
ZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkLCBpbnQgbWF4KQ0KPiAgIHsNCj4gICAgICAgIHN0cnVj
dCBkcm1fc2NoZWRfam9iICpzX2pvYiwgKnRtcDsNCj4gICAgICAgIHVpbnQ2NF90IGd1aWx0eV9j
b250ZXh0Ow0KPiAgICAgICAgYm9vbCBmb3VuZF9ndWlsdHkgPSBmYWxzZTsNCj4gICAgICAgIHN0
cnVjdCBkbWFfZmVuY2UgKmZlbmNlOw0KPiArICAgICBpbnQgaSA9IDA7DQo+DQo+ICAgICAgICBs
aXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoc19qb2IsIHRtcCwgJnNjaGVkLT5wZW5kaW5nX2xpc3Qs
IGxpc3QpIHsNCj4gICAgICAgICAgICAgICAgc3RydWN0IGRybV9zY2hlZF9mZW5jZSAqc19mZW5j
ZSA9IHNfam9iLT5zX2ZlbmNlOw0KPg0KPiArICAgICAgICAgICAgIGlmIChpID49IG1heCkNCj4g
KyAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiArDQo+ICAgICAgICAgICAgICAgIGlmICgh
Zm91bmRfZ3VpbHR5ICYmIGF0b21pY19yZWFkKCZzX2pvYi0+a2FybWEpID4gc2NoZWQtPmhhbmdf
bGltaXQpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICBmb3VuZF9ndWlsdHkgPSB0cnVlOw0K
PiAgICAgICAgICAgICAgICAgICAgICAgIGd1aWx0eV9jb250ZXh0ID0gc19qb2ItPnNfZmVuY2Ut
PnNjaGVkdWxlZC5jb250ZXh0Ow0KPiBAQCAtNTUyLDYgKzU0NSw3IEBAIHZvaWQgZHJtX3NjaGVk
X3Jlc3VibWl0X2pvYnMoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCkNCj4NCj4gICAg
ICAgICAgICAgICAgZG1hX2ZlbmNlX3B1dChzX2pvYi0+c19mZW5jZS0+cGFyZW50KTsNCj4gICAg
ICAgICAgICAgICAgZmVuY2UgPSBzY2hlZC0+b3BzLT5ydW5fam9iKHNfam9iKTsNCj4gKyAgICAg
ICAgICAgICBpKys7DQo+DQo+ICAgICAgICAgICAgICAgIGlmIChJU19FUlJfT1JfTlVMTChmZW5j
ZSkpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICBpZiAoSVNfRVJSKGZlbmNlKSkNCj4gQEAg
LTU2Myw3ICs1NTcsNyBAQCB2b2lkIGRybV9zY2hlZF9yZXN1Ym1pdF9qb2JzKHN0cnVjdCBkcm1f
Z3B1X3NjaGVkdWxlciAqc2NoZWQpDQo+ICAgICAgICAgICAgICAgIH0NCj4gICAgICAgIH0NCj4g
ICB9DQo+IC1FWFBPUlRfU1lNQk9MKGRybV9zY2hlZF9yZXN1Ym1pdF9qb2JzKTsNCj4gK0VYUE9S
VF9TWU1CT0woZHJtX3NjaGVkX3Jlc3VibWl0X2pvYnNfZXh0KTsNCj4NCj4gICAvKioNCj4gICAg
KiBkcm1fc2NoZWRfam9iX2luaXQgLSBpbml0IGEgc2NoZWR1bGVyIGpvYg0KPiBAQCAtOTAzLDMg
Kzg5Nyw1MiBAQCB2b2lkIGRybV9zY2hlZF9maW5pKHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAq
c2NoZWQpDQo+ICAgICAgICBzY2hlZC0+cmVhZHkgPSBmYWxzZTsNCj4gICB9DQo+ICAgRVhQT1JU
X1NZTUJPTChkcm1fc2NoZWRfZmluaSk7DQo+ICsNCj4gKy8qKg0KPiArICogZHJtX3NjaGVkX2lu
Y3JlYXNlX2thcm1hX2V4dCAtIFVwZGF0ZSBzY2hlZF9lbnRpdHkgZ3VpbHR5IGZsYWcNCj4gKyAq
DQo+ICsgKiBAYmFkOiBUaGUgam9iIGd1aWx0eSBvZiB0aW1lIG91dA0KPiArICogQHR5cGU6IHR5
cGUgZm9yIGluY3JlYXNlL3Jlc2V0IGthcm1hDQo+ICsgKg0KPiArICovDQo+ICt2b2lkIGRybV9z
Y2hlZF9pbmNyZWFzZV9rYXJtYV9leHQoc3RydWN0IGRybV9zY2hlZF9qb2IgKmJhZCwgaW50IHR5
cGUpDQo+ICt7DQo+ICsgICAgIGludCBpOw0KPiArICAgICBzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0
eSAqdG1wOw0KPiArICAgICBzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5Ow0KPiArICAg
ICBzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkID0gYmFkLT5zY2hlZDsNCj4gKw0KPiAr
ICAgICAvKiBkb24ndCBjaGFuZ2UgQGJhZCdzIGthcm1hIGlmIGl0J3MgZnJvbSBLRVJORUwgUlEs
DQo+ICsgICAgICAqIGJlY2F1c2Ugc29tZXRpbWVzIEdQVSBoYW5nIHdvdWxkIGNhdXNlIGtlcm5l
bCBqb2JzIChsaWtlIFZNIHVwZGF0aW5nIGpvYnMpDQo+ICsgICAgICAqIGNvcnJ1cHQgYnV0IGtl
ZXAgaW4gbWluZCB0aGF0IGtlcm5lbCBqb2JzIGFsd2F5cyBjb25zaWRlcmVkIGdvb2QuDQo+ICsg
ICAgICAqLw0KPiArICAgICBpZiAoYmFkLT5zX3ByaW9yaXR5ICE9IERSTV9TQ0hFRF9QUklPUklU
WV9LRVJORUwpIHsNCj4gKyAgICAgICAgICAgICBpZiAodHlwZSA9PSAwKQ0KPiArICAgICAgICAg
ICAgICAgICAgICAgYXRvbWljX3NldCgmYmFkLT5rYXJtYSwgMCk7DQo+ICsgICAgICAgICAgICAg
ZWxzZSBpZiAodHlwZSA9PSAxKQ0KPiArICAgICAgICAgICAgICAgICAgICAgYXRvbWljX2luYygm
YmFkLT5rYXJtYSk7DQo+ICsNCj4gKyAgICAgICAgICAgICBmb3IgKGkgPSBEUk1fU0NIRURfUFJJ
T1JJVFlfTUlOOyBpIDwgRFJNX1NDSEVEX1BSSU9SSVRZX0tFUk5FTDsNCj4gKyAgICAgICAgICAg
ICAgICAgIGkrKykgew0KPiArICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRybV9zY2hlZF9y
cSAqcnEgPSAmc2NoZWQtPnNjaGVkX3JxW2ldOw0KPiArDQo+ICsgICAgICAgICAgICAgICAgICAg
ICBzcGluX2xvY2soJnJxLT5sb2NrKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgIGxpc3RfZm9y
X2VhY2hfZW50cnlfc2FmZShlbnRpdHksIHRtcCwgJnJxLT5lbnRpdGllcywgbGlzdCkgew0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoYmFkLT5zX2ZlbmNlLT5zY2hlZHVsZWQu
Y29udGV4dCA9PQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW50aXR5LT5m
ZW5jZV9jb250ZXh0KSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aWYgKGVudGl0eS0+Z3VpbHR5KSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpZiAodHlwZSA9PSAwKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhdG9taWNfc2V0KGVudGl0eS0+Z3VpbHR5LCAw
KTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVsc2Ug
aWYgKHR5cGUgPT0gMSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYXRvbWljX3NldChlbnRpdHktPmd1aWx0eSwgMSk7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgICAg
ICAgIHNwaW5fdW5sb2NrKCZycS0+bG9jayk7DQo+ICsgICAgICAgICAgICAgICAgICAgICBpZiAo
JmVudGl0eS0+bGlzdCAhPSAmcnEtPmVudGl0aWVzKQ0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBicmVhazsNCj4gKyAgICAgICAgICAgICB9DQo+ICsgICAgIH0NCj4gK30NCj4gK0VY
UE9SVF9TWU1CT0woZHJtX3NjaGVkX2luY3JlYXNlX2thcm1hX2V4dCk7DQo+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVyLmggYi9pbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVy
LmgNCj4gaW5kZXggMWM4MTVlMGExNGVkLi40ZWE4NjA2ZDkxZmUgMTAwNjQ0DQo+IC0tLSBhL2lu
Y2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaA0KPiArKysgYi9pbmNsdWRlL2RybS9ncHVfc2NoZWR1
bGVyLmgNCj4gQEAgLTMyMSw3ICszMjEsMTAgQEAgdm9pZCBkcm1fc2NoZWRfd2FrZXVwKHN0cnVj
dCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQpOw0KPiAgIHZvaWQgZHJtX3NjaGVkX3N0b3Aoc3Ry
dWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCwgc3RydWN0IGRybV9zY2hlZF9qb2IgKmJhZCk7
DQo+ICAgdm9pZCBkcm1fc2NoZWRfc3RhcnQoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hl
ZCwgYm9vbCBmdWxsX3JlY292ZXJ5KTsNCj4gICB2b2lkIGRybV9zY2hlZF9yZXN1Ym1pdF9qb2Jz
KHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAqc2NoZWQpOw0KPiArdm9pZCBkcm1fc2NoZWRfcmVz
dWJtaXRfam9ic19leHQoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCwgaW50IG1heCk7
DQo+ICAgdm9pZCBkcm1fc2NoZWRfaW5jcmVhc2Vfa2FybWEoc3RydWN0IGRybV9zY2hlZF9qb2Ig
KmJhZCk7DQo+ICt2b2lkIGRybV9zY2hlZF9yZXNldF9rYXJtYShzdHJ1Y3QgZHJtX3NjaGVkX2pv
YiAqYmFkKTsNCj4gK3ZvaWQgZHJtX3NjaGVkX2luY3JlYXNlX2thcm1hX2V4dChzdHJ1Y3QgZHJt
X3NjaGVkX2pvYiAqYmFkLCBpbnQgdHlwZSk7DQo+ICAgYm9vbCBkcm1fc2NoZWRfZGVwZW5kZW5j
eV9vcHRpbWl6ZWQoc3RydWN0IGRtYV9mZW5jZSogZmVuY2UsDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSk7DQo+ICAg
dm9pZCBkcm1fc2NoZWRfZmF1bHQoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCk7DQoN
Cg0K

--_000_DM5PR1201MB0204013D8BE813FE5D15D0D9BB909DM5PR1201MB0204_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
</head>
<body>
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
hi=A3=ACAndrey and Christian=A3=AC</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
V8 patch is uploaded.&nbsp;</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
Thanks=A3=AC</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
Jack</div>
<div id=3D"id-f211715d-ca40-4ad3-8149-dd2cebd21c76" class=3D"ms-outlook-mob=
ile-reference-message">
<div style=3D"font-family: sans-serif; font-size: 12pt; color: rgb(0, 0, 0)=
;"><br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg"><strong>=B7=A2=BC=FE=C8=CB:</strong> amd-gfx &lt;=
amd-gfx-bounces@lists.freedesktop.org&gt; =B4=FA=B1=ED Zhang, Jack (Jian) &=
lt;Jack.Zhang1@amd.com&gt;<br>
<strong>=B7=A2=CB=CD=CA=B1=BC=E4:</strong> 2021=C4=EA3=D4=C211=C8=D5=D0=C7=
=C6=DA=CB=C4 =CF=C2=CE=E78:20<br>
<strong>=CA=D5=BC=FE=C8=CB:</strong> amd-gfx@lists.freedesktop.org; Grodzov=
sky, Andrey; Liu, Monk; Deng, Emily; Koenig, Christian<br>
<strong>=D6=F7=CC=E2:</strong> Re: [PATCH v7] drm/amd/amdgpu implement tdr =
advanced mode<br>
</div>
<br>
<meta content=3D"text/html; charset=3Diso-2022-jp">
<p align=3D"Left" style=3D"font-family:Arial; font-size:11pt; color:#0078D7=
; margin:5pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<p align=3D"Left" style=3D"font-family:Arial; font-size:11pt; color:#0078D7=
; margin:5pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
hi=A3=ACChristian=A3=AC<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Good idea=A3=ACthank you for these efforts.<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
I will update in next version. <br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0px; padding:0px; font-fam=
ily:sans-serif; font-size:11pt; color:black; text-align:left">
Jack<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig@amd.com&gt;<br>
<b>Sent:</b> Thursday, March 11, 2021 6:41:05 PM<br>
<b>To:</b> Zhang, Jack (Jian) &lt;Jack.Zhang1@amd.com&gt;; amd-gfx@lists.fr=
eedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;; Grodzovsky, Andrey &lt=
;Andrey.Grodzovsky@amd.com&gt;; Liu, Monk &lt;Monk.Liu@amd.com&gt;; Deng, E=
mily &lt;Emily.Deng@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH v7] drm/amd/amdgpu implement tdr advanced mode</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
<br>
Am 11.03.21 um 06:58 schrieb Jack Zhang:<br>
&gt; [Why]<br>
&gt; Previous tdr design treats the first job in job_timeout as the bad job=
.<br>
&gt; But sometimes a later bad compute job can block a good gfx job and<br>
&gt; cause an unexpected gfx job timeout because gfx and compute ring share=
<br>
&gt; internal GC HW mutually.<br>
&gt;<br>
&gt; [How]<br>
&gt; This patch implements an advanced tdr mode.It involves an additinal<br=
>
&gt; synchronous pre-resubmit step(Step0 Resubmit) before normal resubmit<b=
r>
&gt; step in order to find the real bad job.<br>
&gt;<br>
&gt; 1. At Step0 Resubmit stage, it synchronously submits and pends for the=
<br>
&gt; first job being signaled. If it gets timeout, we identify it as guilty=
<br>
&gt; and do hw reset. After that, we would do the normal resubmit step to<b=
r>
&gt; resubmit left jobs.<br>
&gt;<br>
&gt; 2. For whole gpu reset(vram lost), do resubmit as the old way.<br>
&gt;<br>
&gt; Signed-off-by: Jack Zhang &lt;Jack.Zhang1@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |&nbsp; 63 ++++=
++++++++<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp; 2 +-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_main.c&nbsp;&nbsp;&nbsp;&n=
bsp; | 107 +++++++++++++++------<br>
&gt;&nbsp;&nbsp; include/drm/gpu_scheduler.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3=
 +<br>
&gt;&nbsp;&nbsp; 4 files changed, 142 insertions(+), 33 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index e247c3a2ec08..5b182ade26ad 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -4639,6 +4639,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool need_emergency_restart =
=3D false;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool audio_suspended =3D fal=
se;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int tmp_vram_lost_counter;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Special case: RAS tr=
iggered and full reset isn't supported<br>
&gt; @@ -4788,6 +4789,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_devi=
ce *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; tmp_vram_lost_counter =3D atomic_read(&amp;(=
(adev)-&gt;vram_lost_counter));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Actual ASIC resets if nee=
ded.*/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO Implement XGMI hive =
reset logic for SRIOV */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {=
<br>
&gt; @@ -4805,6 +4807,67 @@ int amdgpu_device_gpu_recover(struct amdgpu_dev=
ice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Post ASIC reset for all d=
evs .*/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry(tmp_adev=
, device_list_handle, gmc.xgmi.head) {<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (amdgpu_gpu_recovery =3D=3D 2 &amp;&amp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(tmp_vram_lost_counter=
 &lt; atomic_read(&amp;adev-&gt;vram_lost_counter))) {<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AM=
DGPU_MAX_RINGS; ++i) {<br>
<br>
Starting from here I would put this into a separate helper function in <br>
amdgpu_ring.c.<br>
<br>
You should also probably use checkpatch.pl once more since a couple of <br>
lines below might result in warnings.<br>
<br>
Christian.<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D tmp_adev-&gt;rings[i]=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *s_job;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!ring || !ring-&gt;sched.thread)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; co=
ntinue;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; /* No point to resubmit jobs if we didn't HW reset=
*/<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!tmp_adev-&gt;asic_reset_res &amp;&amp; !job_s=
ignaled) {<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s_=
job =3D list_first_entry_or_null(&amp;ring-&gt;sched.pending_list, struct d=
rm_sched_job, list);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (s_job =3D=3D NULL)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 clear job's guilty and depend the folowing step to decide the real one */<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dr=
m_sched_reset_karma(s_job);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dr=
m_sched_resubmit_jobs_ext(&amp;ring-&gt;sched, 1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
t =3D dma_fence_wait_timeout(s_job-&gt;s_fence-&gt;parent, false, ring-&gt;=
sched.timeout);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (ret =3D=3D 0) { /* timeout */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Found the rea=
l bad job! ring:%s, job_id:%llx\n&quot;, ring-&gt;sched.name, s_job-&gt;id)=
;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set guilty */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_increase_karma(s_jo=
b);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* do hw reset */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {<=
br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; amdgpu_virt_fini_data_exchange(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_reset_sriov(adev, false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt=
;asic_reset_res =3D r;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; r&nbsp; =3D amdgpu_do_asic_reset(hive, device_list_handl=
e, &amp;need_full_reset, false);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; if (r &amp;&amp; r =3D=3D -EAGAIN)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto ret=
ry;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* add reset counter so that =
the following resubmitted job could flush vmid */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;tmp_adev-&gt;=
gpu_reset_counter);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 got the hw fence, signal finished fence */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; at=
omic_dec(&amp;ring-&gt;sched.num_jobs);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm=
a_fence_get(&amp;s_job-&gt;s_fence-&gt;finished);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm=
a_fence_signal(&amp;s_job-&gt;s_fence-&gt;finished);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm=
a_fence_put(&amp;s_job-&gt;s_fence-&gt;finished);<br>
&gt; +<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*=
 remove node from list and free the job */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sp=
in_lock(&amp;ring-&gt;sched.job_list_lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; li=
st_del_init(&amp;s_job-&gt;node);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sp=
in_unlock(&amp;ring-&gt;sched.job_list_lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ri=
ng-&gt;sched.ops-&gt;free_job(s_job);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; AMDGPU_MAX_RINGS; ++i) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct =
amdgpu_ring *ring =3D tmp_adev-&gt;rings[i];<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c<br>
&gt; index 865f924772b0..9c3f4edb7532 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; @@ -509,7 +509,7 @@ module_param_named(compute_multipipe, amdgpu_compu=
te_multipipe, int, 0444);<br>
&gt;&nbsp;&nbsp;&nbsp; * DOC: gpu_recovery (int)<br>
&gt;&nbsp;&nbsp;&nbsp; * Set to enable GPU recovery mechanism (1 =3D enable=
, 0 =3D disable). The default is -1 (auto, disabled except SRIOV).<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; -MODULE_PARM_DESC(gpu_recovery, &quot;Enable GPU recovery mechanism, (=
1 =3D enable, 0 =3D disable, -1 =3D auto)&quot;);<br>
&gt; +MODULE_PARM_DESC(gpu_recovery, &quot;Enable GPU recovery mechanism, (=
2 =3D advanced tdr mode, 1 =3D enable, 0 =3D disable, -1 =3D auto)&quot;);<=
br>
&gt;&nbsp;&nbsp; module_param_named(gpu_recovery, amdgpu_gpu_recovery, int,=
 0444);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/=
scheduler/sched_main.c<br>
&gt; index d82a7ebf6099..bb0a129d1f40 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; +++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; @@ -361,40 +361,16 @@ static void drm_sched_job_timedout(struct work_s=
truct *work)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; void drm_sched_increase_karma(struct drm_sched_job *bad)<b=
r>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *tmp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *entity;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler *sched =3D bad-&gt;=
sched;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* don't increase @bad's karma if it's from =
KERNEL RQ,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * because sometimes GPU hang would cau=
se kernel jobs (like VM updating jobs)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * corrupt but keep in mind that kernel=
 jobs always considered good.<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (bad-&gt;s_priority !=3D DRM_SCHED_PRIORI=
TY_KERNEL) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; atomic_inc(&amp;bad-&gt;karma);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; for (i =3D DRM_SCHED_PRIORITY_MIN; i &lt; DRM_SCHED_PRIORITY_KERNEL;<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i++) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_rq *rq=
 =3D &amp;sched-&gt;sched_rq[i];<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;rq-&gt;l=
ock);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_saf=
e(entity, tmp, &amp;rq-&gt;entities, list) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (bad-&gt;s_fence-&gt;scheduled.context =3D=3D<b=
r>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity-&gt;fence_context) =
{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (atomic_read(&amp;bad-&gt;karma) &gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; bad-&gt;sched-&gt;hang_limit)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (entity-&gt;guilty)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; atomic_set(entity-&gt;guilty, 1);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br=
eak;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;rq-&gt=
;lock);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (&amp;entity-&gt;lis=
t !=3D &amp;rq-&gt;entities)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_increase_karma_ext(bad, 1);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; EXPORT_SYMBOL(drm_sched_increase_karma);<br>
&gt;&nbsp;&nbsp; <br>
&gt; +void drm_sched_reset_karma(struct drm_sched_job *bad)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_increase_karma_ext(bad, 0);<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL(drm_sched_reset_karma);<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * drm_sched_stop - stop the scheduler<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt; @@ -533,15 +509,32 @@ EXPORT_SYMBOL(drm_sched_start);<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sch=
ed)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_resubmit_jobs_ext(sched, INT_MAX);=
<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL(drm_sched_resubmit_jobs);<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * drm_sched_resubmit_jobs_ext - helper to relunch certain number of =
jobs from mirror ring list<br>
&gt; + *<br>
&gt; + * @sched: scheduler instance<br>
&gt; + * @max: job numbers to relaunch<br>
&gt; + *<br>
&gt; + */<br>
&gt; +void drm_sched_resubmit_jobs_ext(struct drm_gpu_scheduler *sched, int=
 max)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *s_job,=
 *tmp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t guilty_context;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool found_guilty =3D false;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *fence;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i =3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(s_j=
ob, tmp, &amp;sched-&gt;pending_list, list) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct drm_sched_fence *s_fence =3D s_job-&gt;s_fence;<=
br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (i &gt;=3D max)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!found_guilty &amp;&amp; atomic_read(&amp;s_job-&gt=
;karma) &gt; sched-&gt;hang_limit) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found_g=
uilty =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; guilty_=
context =3D s_job-&gt;s_fence-&gt;scheduled.context;<br>
&gt; @@ -552,6 +545,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_schedu=
ler *sched)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dma_fence_put(s_job-&gt;s_fence-&gt;parent);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; fence =3D sched-&gt;ops-&gt;run_job(s_job);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; i++;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (IS_ERR_OR_NULL(fence)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_=
ERR(fence))<br>
&gt; @@ -563,7 +557,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_schedu=
ler *sched)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt; -EXPORT_SYMBOL(drm_sched_resubmit_jobs);<br>
&gt; +EXPORT_SYMBOL(drm_sched_resubmit_jobs_ext);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * drm_sched_job_init - init a scheduler job<br>
&gt; @@ -903,3 +897,52 @@ void drm_sched_fini(struct drm_gpu_scheduler *sch=
ed)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched-&gt;ready =3D false;<b=
r>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; EXPORT_SYMBOL(drm_sched_fini);<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * drm_sched_increase_karma_ext - Update sched_entity guilty flag<br>
&gt; + *<br>
&gt; + * @bad: The job guilty of time out<br>
&gt; + * @type: type for increase/reset karma<br>
&gt; + *<br>
&gt; + */<br>
&gt; +void drm_sched_increase_karma_ext(struct drm_sched_job *bad, int type=
)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *tmp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_entity *entity;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler *sched =3D bad-&gt;=
sched;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; /* don't change @bad's karma if it's from KE=
RNEL RQ,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * because sometimes GPU hang would cau=
se kernel jobs (like VM updating jobs)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * corrupt but keep in mind that kernel=
 jobs always considered good.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (bad-&gt;s_priority !=3D DRM_SCHED_PRIORI=
TY_KERNEL) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (type =3D=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_set(&amp;bad-&gt=
;karma, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else if (type =3D=3D 1)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;bad-&gt=
;karma);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; for (i =3D DRM_SCHED_PRIORITY_MIN; i &lt; DRM_SCHED_PRIORITY_KERNEL;<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i++) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_rq *rq=
 =3D &amp;sched-&gt;sched_rq[i];<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;rq-&gt;l=
ock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_saf=
e(entity, tmp, &amp;rq-&gt;entities, list) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (bad-&gt;s_fence-&gt;scheduled.context =3D=3D<b=
r>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entity-&gt;fence_context) =
{<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (entity-&gt;guilty) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (type =3D=3D 0)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; atomic_set(entity-&gt;guilty, 0);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (type =3D=3D 1)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; atomic_set(entity-&gt;guilty, 1);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br=
eak;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;rq-&gt=
;lock);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (&amp;entity-&gt;lis=
t !=3D &amp;rq-&gt;entities)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +EXPORT_SYMBOL(drm_sched_increase_karma_ext);<br>
&gt; diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h=
<br>
&gt; index 1c815e0a14ed..4ea8606d91fe 100644<br>
&gt; --- a/include/drm/gpu_scheduler.h<br>
&gt; +++ b/include/drm/gpu_scheduler.h<br>
&gt; @@ -321,7 +321,10 @@ void drm_sched_wakeup(struct drm_gpu_scheduler *s=
ched);<br>
&gt;&nbsp;&nbsp; void drm_sched_stop(struct drm_gpu_scheduler *sched, struc=
t drm_sched_job *bad);<br>
&gt;&nbsp;&nbsp; void drm_sched_start(struct drm_gpu_scheduler *sched, bool=
 full_recovery);<br>
&gt;&nbsp;&nbsp; void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sch=
ed);<br>
&gt; +void drm_sched_resubmit_jobs_ext(struct drm_gpu_scheduler *sched, int=
 max);<br>
&gt;&nbsp;&nbsp; void drm_sched_increase_karma(struct drm_sched_job *bad);<=
br>
&gt; +void drm_sched_reset_karma(struct drm_sched_job *bad);<br>
&gt; +void drm_sched_increase_karma_ext(struct drm_sched_job *bad, int type=
);<br>
&gt;&nbsp;&nbsp; bool drm_sched_dependency_optimized(struct dma_fence* fenc=
e,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm=
_sched_entity *entity);<br>
&gt;&nbsp;&nbsp; void drm_sched_fault(struct drm_gpu_scheduler *sched);<br>
<br>
</div>
</span></font></div>
</div>
</div>
<br>
</div>
</div>
</body>
</html>

--_000_DM5PR1201MB0204013D8BE813FE5D15D0D9BB909DM5PR1201MB0204_--

--===============1161715170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1161715170==--
