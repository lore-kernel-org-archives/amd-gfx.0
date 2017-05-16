From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/1] amdgpu: move asic id table to a separate file
Date: Tue, 16 May 2017 10:38:29 +0900
Message-ID: <392afe85-eafa-345f-bac3-09b6f1d7e315@daenzer.net>
References: <1494449815-10162-1-git-send-email-Samuel.Li@amd.com>
 <DM3PR1201MB10392013EC4407011C4F9B84F5EC0@DM3PR1201MB1039.namprd12.prod.outlook.com>
 <fcbc7ab9-f5f7-c529-9526-d78772c0d830@daenzer.net>
 <CY1PR1201MB1033C872BA2CF7916ED3A369F5ED0@CY1PR1201MB1033.namprd12.prod.outlook.com>
 <1bdcfa4a-6840-796e-1623-2949358a0364@daenzer.net>
 <CY1PR1201MB103331794AEFCBCD27AB5FFCF5E20@CY1PR1201MB1033.namprd12.prod.outlook.com>
 <832d50ad-6dbb-fd6b-b052-664f9de08153@daenzer.net>
 <CY1PR1201MB10332061C42EE8988B8250F3F5E10@CY1PR1201MB1033.namprd12.prod.outlook.com>
 <MWHPR12MB131257AB734A08B73015F1CAFFE60@MWHPR12MB1312.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB131257AB734A08B73015F1CAFFE60-Gy0DoCVfaSVTEcpIPqmgfAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Yuan,
 Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

T24gMTYvMDUvMTcgMTA6MzIgQU0sIFpoYW5nLCBKZXJyeSB3cm90ZToKPiBGWUkuCj4gCj4gSW4g
YW1kZ3B1LXBybyBzdGFjaywgaXQgaGVscHMgdXMgdGhhdDoKPiAgIC0gZmxleGlibGUgdG8gbWFp
bnRhaW4gdGhlIHJlbGVhc2UgcHJvY2Vzcy4gKEFkZC9yZW1vdmUvcG9ydGluZyBhbW9uZyBkaWZm
ZXJlbnQgcmVsZWFzZSBicmFuY2hlcykKPiAgIC0gbGliZHJtIGdpdCBsb2cgd2lsbCBub3QgYmUg
bWVzc2VkIHVwIHdpdGggbG90cyBvZiB1cGRhdGluZyBjb21taXQKPiAgIC0gYWxzbyBoZWxwZnVs
IHRvIHN1cHBvcnQgY3VzdG9tZXJzIGZvciBzdWNoIGtpbmQgb2YgaXNzdWVzLgoKVGhvc2UgYXJl
IEFNRCBpbnRlcm5hbCBpc3N1ZXMgd2hpY2ggY2FuIGJlIG1hbmFnZWQgcmVnYXJkbGVzcyBvZiB3
aGVyZQp0aGUgZmlsZSBpcyBsb2NhdGVkIHVwc3RyZWFtLCBleGNlcHQgcG9zc2libHkgZm9yIHRo
ZSBHaXQgbG9nLiBJcyB0aGUKZmlsZSBleHBlY3RlZCB0byBnZXQgdXBkYXRlZCB0aGF0IG9mdGVu
PwoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAg
ICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
